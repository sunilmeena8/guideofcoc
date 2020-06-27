import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guideofcoc/favourities.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:localstorage/localstorage.dart';

class HomeBaseBaseLayouts extends StatefulWidget {
  @override
  _HomeBaseBaseLayoutsState createState() => _HomeBaseBaseLayoutsState();
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

class _HomeBaseBaseLayoutsState extends State<HomeBaseBaseLayouts> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
    Tab(text: "Bottom"),
    Tab(
      text: "Up",
    ),
  ];

  final Firestore db = Firestore.instance;
  String _thvalue = "Town Hall 13";
  var nameList = [
    "Town Hall 13",
    "Town Hall 12",
    "Town Hall 11",
    "Town Hall 10",
    "Town Hall 9",
    "Town Hall 8",
    "Town Hall 7",
  ];
  final LocalStorage localStorage = new LocalStorage('favourities');
  final BaseLayoutList list = new BaseLayoutList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: new AppBar(
          title: new Theme(
            child: Row(
              children: <Widget>[
                new DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    dropdownColor: Colors.blue[300],
                    value: _thvalue,
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
                      setState(() => _thvalue = value);
                    },
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Favourities()),
                      );
                    },
                    child: Icon(Icons.favorite)),
              ],
            ),
            data: new ThemeData.dark(),
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Text("WAR")),
              Tab(icon: Text("TROPHY")),
              Tab(icon: Text("HYBRID")),
              Tab(icon: Text("FARMING")),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          baseList(context, "war", _thvalue),
          baseList(context, "TROPHY", _thvalue),
          baseList(context, "HYBRID", _thvalue),
          baseList(context, "FARMING", _thvalue),
        ]),
      ),
    );
  }

  Widget baseList(context, String type, String th) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection("bases/" + th + "/" + type).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.documents.length > 0) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                var fabs =
                    localStorage.getItem("favourities");
                
                bool favourite = false;
                Map<dynamic,dynamic> checkfav= new Map();
                checkfav['url'] = document.data['link'];
                checkfav['download_url'] = document.data['download_url'];
                checkfav['favourite'] = true;
                
                if (fabs != null) {
                  for(int i=0;i<fabs.length;i++){
                  if(fabs[i]['url']==checkfav['url'] && fabs[i]['download_url']==checkfav['download_url'] && fabs[i]['favourite']==checkfav['favourite']){
                    favourite = true;
                    break;
                  }
                }
                }
                
                BaseLayoutItem item = new BaseLayoutItem();
                item.url = document.data['link'];
                item.download_url = document.data['download_url'];
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

  _addItem(BaseLayoutItem item) {
    setState(() {
      list.items.add(item);
      _saveToStorage();
    });
  }

  _removeItem(BaseLayoutItem item) {
    setState(() {
      list.items.remove(item);
      _saveToStorage();
    });
  }

  _saveToStorage() {
    localStorage.setItem('favourities', list.toJSONEncodable());
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
                            _addItem(item);
                            // _setFavourite(item);
                            setState(() {
                              
                            });
                          }
                        : () {
                            _removeItem(item);
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
                      _launchURL(item.download_url);
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
