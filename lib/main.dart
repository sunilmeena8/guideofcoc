import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guideofcoc/Home.dart';
import 'package:guideofcoc/services.dart';
import 'package:guideofcoc/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());
var admin = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COC guide',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Updates(),
    );
  }
}

class Updates extends StatefulWidget {
  @override
  _UpdatesState createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> {
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUpdates();
    getTownHalls();
    getBuilderHalls();
    return SplashScreen();
  }

  final Firestore db = Firestore.instance;

  void getUpdates() {
    db.collection("updates").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("updates", result.data['urls'].join(" "));
      });
    });
  }

  void getTownHalls() {
    db.collection("town halls").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("town halls", result.data["list"].join(";"));
      });
    });
  }

  void getBuilderHalls() {
    db.collection("builder halls").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("builder halls", result.data["list"].join(";"));
      });
    });
  }

}
