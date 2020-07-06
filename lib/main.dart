import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guideofcoc/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

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
 
class Updates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getUpdates();
    return Home();
  }
  final Firestore db = Firestore.instance;
  void getUpdates() {
    db.collection("updates").getDocuments().then((querySnapshot) {
    querySnapshot.documents.forEach((result) async {
      // print(result.data['urls']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
    prefs.setString("updates", result.data['urls'].join(" "));
      // print(result.data['urls']);
    });
  });
  }
}