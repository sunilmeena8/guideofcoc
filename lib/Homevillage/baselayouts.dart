import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guideofcoc/favourities.dart';
import 'package:guideofcoc/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

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
  String _thvalue = thList[0];
  var nameList = [
    "Town Hall 13",
    "Town Hall 12",
    "Town Hall 11",
    "Town Hall 10",
    "Town Hall 9",
    "Town Hall 8",
    "Town Hall 7",
  ];
  static bool favourite = false;

  @override
  Widget build(BuildContext context) {
    // getThs();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            elevation: 10.0,
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Favourities()),
              );
            },
            child: Icon(
              Icons.favorite,
              size: 30.0,
            )),
        appBar: new AppBar(
          backgroundColor: const Color(0xff000000),
          title: new Theme(
            child: Row(
              children: <Widget>[
                new DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    dropdownColor: Colors.blue[300],
                    value: _thvalue,
                    items: thList.map(
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
                    future: getFav(documentId),
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

  getThs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString("town halls");
    return stringValue.split(";");
  }

 

  addFav(String id, BaseLayoutItem item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fabString = prefs.getString("favourities");
    
    if(fabString==null){
      Map<String,String> map = new Map<String,String>();
      map[id] = item.url+";"+item.download_url;
      String jsonFormat  = jsonEncode(map);
      prefs.setString("favourities", jsonFormat);
    
    }
    else{
      var fabs = jsonDecode(fabString);
      fabs[id] = item.url+";"+item.download_url;
      String jsonFormat  = jsonEncode(fabs);
      prefs.setString("favourities", jsonFormat);
    }
    
  }

  Future<bool> getFav(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fabString = prefs.get("favourities");
    Map<String,dynamic>map = jsonDecode(fabString);
    if(map.containsKey(id)){
      return(true);
    }
    else{
      return(false);
    }
  }

  removeFav(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fabString = prefs.getString("favourities");
    Map<String,dynamic> fabs = jsonDecode(fabString);
    fabs.remove(id);
    fabString = jsonEncode(fabs);
    prefs.setString("favourities", fabString);
  }

  Widget BaseLayoutCard(BaseLayoutItem item, String documentId) {
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
                    onTap: () {
                      if (item.favourite == false) {
                        addFav(documentId, item);
                      } else {
                        removeFav(documentId);
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
