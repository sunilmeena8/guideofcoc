import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guideofcoc/favourities.dart';
import 'package:guideofcoc/services.dart';
import 'package:guideofcoc/utils/fav_utils.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:photo_view/photo_view.dart';

class HomeBaseBaseLayouts extends StatefulWidget {
  @override
  _HomeBaseBaseLayoutsState createState() => _HomeBaseBaseLayoutsState();
}

class BaseLayoutItem {
  String url;
  String download_url;
  bool favourite;
  BaseLayoutItem({
    this.url,
    this.download_url,
    this.favourite,
  });
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
  String _thvalue = appState[dataStrings[1]][0];

  static bool favourite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xff121212),
        floatingActionButton: FloatingActionButton(
            elevation: 10.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Favourities("home village favourities")),
              );
            },
            child: Icon(
              Icons.favorite,
              size: 30.0,
            )),
        appBar: new AppBar(
          backgroundColor: const Color(0xff272727),
          title: new Theme(
            child: Row(
              children: <Widget>[
                new DropdownButtonHideUnderline(
                  child: new DropdownButton<dynamic>(
                    dropdownColor: Color(0xff363636),
                    value: _thvalue,
                    items: appState[dataStrings[1]].map(
                      (item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                color: Colors.blue[200],
                                fontWeight: FontWeight.w500,
                              )),
                        );
                      },
                    ).toList(),
                    onChanged: (dynamic value) {
                      setState(() => _thvalue = value);
                    },
                  ),
                ),
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
          baseList(context, "trophy", _thvalue),
          baseList(context, "hybrid", _thvalue),
          baseList(context, "farming", _thvalue),
        ]),
      ),
    );
  }

  Widget baseList(context, String type, String th) {
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection("bases/home village/" + th + "/" + type + "/bases")
          .snapshots(),
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
                String documentId = document.documentID;
                return FutureBuilder(
                    future:
                        FavUtils.getFav(documentId, "home village favourities"),
                    builder: (context, favourite) {
                      item.favourite = favourite.data;
                      return BaseLayoutCard(item, documentId);
                    });
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
                    'No Bases found',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
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
                  'Please wait...',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Quicksand'),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget BaseLayoutCard(BaseLayoutItem item, String documentId) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      child: Container(
          width: 400,
          height: 250,
          child: Stack(
            children: <Widget>[
              Center(child: CircularProgressIndicator()),
              new Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return DetailScreen(item.url);
                    }));
                  },
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: item.url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  top: 210,
                  left: 10,
                  child: GestureDetector(
                      onTap: () {
                        if (item.favourite == false) {
                          FavUtils.addFav(
                              documentId,
                              item.url + ";" + item.download_url,
                              "home village favourities");
                        } else {
                          FavUtils.removeFav(
                              documentId, "home village favourities");
                        }
                        setState(() {});
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
          )),
    );
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

class DetailScreen extends StatelessWidget {
  final String url;
  DetailScreen(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: PhotoView(
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}
