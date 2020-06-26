import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeBaseBaseLayouts extends StatefulWidget {
  @override
  _HomeBaseBaseLayoutsState createState() => _HomeBaseBaseLayoutsState();
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

  @override
  Widget build(BuildContext context) {
    final title = 'Base Layouts';

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Text("WAR")),
              Tab(icon: Text("TROPHY")),
              Tab(icon: Text("HYBRID")),
              Tab(icon: Text("FARMING")),
            ],
          ),
          title: Text(title),
        ),
        body: TabBarView(children: <Widget>[
          baseList(context, "war", "th13"),
          baseList(context, "TROPHY", "th13"),
          baseList(context, "HYBRID", "th13"),
          baseList(context, "FARMING", "th13"),
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
                return BaseLayoutCard(document.data['link']);
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

  Widget BaseLayoutCard(String link) {
    return Container(
        width: 400,
        height: 250,
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          children: <Widget>[
            new Positioned.fill(
                child: Image.network(
              link,
              fit: BoxFit.cover,
            )),
            Positioned(
                top: 210,
                left: 10,
                child: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.favorite, color: Colors.white))),
            Positioned(
              top: 10,
              left: 350,
              child: Icon(
                Icons.share,
                color: Colors.blue[300],
              ),
            ),
            Positioned(top: 210, left: 350, child: Icon(Icons.file_download))
          ],
        ));
  }
}
