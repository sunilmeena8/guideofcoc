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
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    SharedPreferences.getInstance().then((prefs) async {
      await getFromSP();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('images/splashscreen.png'),
      ),
    );
  }

  getFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    thList = prefs.getString("town halls").split(';');
    updatesList = prefs.getString("updates").split(' ');
    bhList = prefs.getString('builder halls').split(';');
  }
}
