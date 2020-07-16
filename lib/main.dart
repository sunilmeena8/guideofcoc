import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guideofcoc/services.dart';
import 'package:guideofcoc/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COC guide',
      theme: ThemeData.dark(),
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
    
    // getUpdates();
    // getTownHalls();
    // getBuilderHalls();
    return SplashScreen();
  }

  final Firestore db = Firestore.instance;

  void getUpdates() {
    db.collection("updates").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("updates", result.data['urls'].join(" "));
        appState["updates"] = result.data['urls'];
        print(appState["updates"]);
      });
    });
  }

  void getTownHalls() {
    db.collection("town halls").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("town halls", result.data["list"].join(";"));
        appState["thList"] = result.data['list'];
        print(appState["thList"]);
      });
    });
  }

  void getBuilderHalls() {
    db.collection("builder halls").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("builder halls", result.data["list"].join(";"));
        appState["builder halls"] = result.data['list'];
        print(appState["builder halls"]);
      });
    });
  }

}
