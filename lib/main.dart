import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guideofcoc/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await checkSP();
  runApp(MyApp());
}

checkSP() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
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
}

getUpdates(List<String> data) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  await Future.forEach(data, (value) async {
    await db.collection(value).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, List<dynamic>> map = new Map<String, List<dynamic>>();
        map[value] = result.data()["list"];
        String jsonString = jsonEncode(map);
        prefs.setString(value, jsonString);
        appState[value] = result.data()['list'];
      });
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COC guide',
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}
