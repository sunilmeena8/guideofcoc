import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guideofcoc/Home.dart';
import 'package:guideofcoc/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Firestore db = Firestore.instance;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, checkSP);
  }

  void checkSP() {
    SharedPreferences.getInstance().then((prefs) async {
      if (prefs.get(dataStrings[0]) == null ||
          prefs.get(dataStrings[1]) == null ||
          prefs.get(dataStrings[2]) == null) {
        await getUpdates(dataStrings);
      } else {
        dataStrings.forEach((value) {
          String jsonString = prefs.get(value);

          Map<String, dynamic> map = jsonDecode(jsonString);
          appState[value] = map[value];
        });
        await getUpdates(dataStrings);
      }
      navigationPage();
    });
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('images/ic_launcher.png'),
      ),
    );
  }

  getUpdates(List<String> data) async {
    await Future.forEach(data, (value) async {
      await db.collection(value).getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((result) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Map<String, List<dynamic>> map = new Map<String, List<dynamic>>();
          map[value] = result.data["list"];
          String jsonString = jsonEncode(map);
          prefs.setString(value, jsonString);
          appState[value] = result.data['list'];
        });
      });
    });
  }
}
