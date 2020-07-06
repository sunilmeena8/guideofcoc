import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guideofcoc/favourities.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class BuilderBaseBaseLayouts extends StatefulWidget {
  @override
  _BuilderBaseBaseLayoutsState createState() => _BuilderBaseBaseLayoutsState();
}

class BaseLayoutItem {
  String url;
  String download_url;
  bool favourite;
  BaseLayoutItem({this.url, this.download_url, this.favourite});
  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['url'] = url;
    m['download_url'] = download_url;
    m['favourite'] = favourite;
    return m;
  }
}

class BaseLayoutList {
  List<BaseLayoutItem> items;
  BaseLayoutList() {
    items = new List();
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

class _BuilderBaseBaseLayoutsState extends State<BuilderBaseBaseLayouts> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
    Tab(text: "Bottom"),
    Tab(
      text: "Up",
    ),
  ];

  final Firestore db = Firestore.instance;
  String _bhvalue = "Builder Hall 9";
  var nameList = [
    "Builder Hall 9",
    "Builder Hall 8",
    "Builder Hall 7",
    "Builder Hall 6",
    "Builder Hall 5",
  ];
  static bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          floatingActionButton: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Favourities()),
                );
              },
              child: Icon(Icons.favorite,color: Colors.pink[200])),
          appBar: AppBar(
            backgroundColor: const Color(0xff000000),
            title: new Theme(
              child: Row(
                children: <Widget>[
                  new DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                      dropdownColor: Colors.blue[300],
                      value: _bhvalue,
                      items: nameList.map(
                        (item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String value) {
                        setState(() => _bhvalue = value);
                      },
                    ),
                  ),
                ],
              ),
              data: new ThemeData.dark(),
            ),
          ),
          body: baseList(context, _bhvalue)),
    );
  }

  Widget baseList(context, String _bhvalue) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection("bases/builder base/" + _bhvalue).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.documents.length > 0) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                BaseLayoutItem item = new BaseLayoutItem();
                item.url = document.data['url'];
                item.download_url = document.data['download_url'];
                item.favourite = favourite;
                getFav(item);
                item.favourite = favourite;
                return BaseLayoutCard(item);
              }).toList(),
            );
          } else {
            return Container(
              padding: EdgeInsets.only(top: 50.0),
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('images/not-found.png', width: 40, height: 40.0),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'No Activities Yet',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0,
                        fontFamily: 'Quicksand'),
                  ),
                ],
              ),
            );
          }
        } else {
          return Container(
            padding: EdgeInsets.only(top: 50.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //loader
                SizedBox(height: 15.0),
                Text(
                  'Please Wait',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontFamily: 'Quicksand'),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  addFav(BaseLayoutItem item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(item.download_url, item.download_url + ";" + item.url);
  }

  getFav(BaseLayoutItem item) async {
    var fab = await getFavFromSF(item);
    if (fab == null) {
      favourite = false;
    } else {
      favourite = true;
    }
  }

  getFavFromSF(BaseLayoutItem item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(item.download_url);
    return stringValue;
  }

  removeFav(BaseLayoutItem item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(item.download_url);
  }

  Widget BaseLayoutCard(BaseLayoutItem item) {
    return Container(
        width: 400,
        height: 250,
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          children: <Widget>[
            new Positioned.fill(
                child: Image.network(
              item.url,
              fit: BoxFit.cover,
            )),
            Positioned(
                top: 210,
                left: 10,
                child: GestureDetector(
                    onTap: item.favourite == false
                        ? () {
                            item.favourite = !item.favourite;
                            addFav(item);
                            setState(() {});
                          }
                        : () {
                            removeFav(item);
                            setState(() {
                              item.favourite = !item.favourite;
                            });
                          },
                    child: Icon(Icons.favorite,
                        color: item.favourite == false
                            ? Colors.white
                            : Colors.pink[300]))),
            Positioned(
              top: 10,
              left: 350,
              child: GestureDetector(
                onTap: () {
                  Share.share(item.download_url.toString());
                },
                child: Icon(
                  Icons.share,
                  color: Colors.blue[300],
                ),
              ),
            ),
            Positioned(
                top: 210,
                left: 350,
                child: GestureDetector(
                    onTap: () {
                      _launchURL(item.download_url.toString());
                    },
                    child: Icon(Icons.file_download, color: Colors.white)))
          ],
        ));
  }

  _launchURL(String copy_url) async {
    String url = copy_url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
