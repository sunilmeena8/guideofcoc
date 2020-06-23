import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class BuilderBaseBaseLayouts extends StatefulWidget {
  @override
  _BuilderBaseBaseLayoutsState createState() => _BuilderBaseBaseLayoutsState();
}

class _BuilderBaseBaseLayoutsState extends State<BuilderBaseBaseLayouts> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
    Tab(text: "Bottom"),
    Tab(text: "Up",),
  ];
  
  final Firestore db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final title = 'Base Layouts';
    

    return
    DefaultTabController(
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
          body: TabBarView(
            children: <Widget>[
              baseList(context,"war"),
              baseList(context,"TROPHY"),
              baseList(context,"HYBRID"),
              baseList(context,"FARMING"),
            ]
          ),
        
      ),
    );
    
  }
  Widget baseList(context,String type) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection("bases/th13/"+type).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.documents.length>0) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: snapshot.data.documents.map((DocumentSnapshot document){
                return Text(document.documentID);
              }).toList(), 
              );
          }
          else{
             return Container(
               padding: EdgeInsets.only(top: 50.0),
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[  
                 Image.asset('assets/not-found.png',width: 40,height:40.0),
                  SizedBox(height: 10.0,),             
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
}