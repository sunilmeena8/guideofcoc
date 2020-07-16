import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:guideofcoc/services.dart';

class GetUpdates {
  final Firestore db = Firestore.instance;
  
  void checkSP() {
    
    SharedPreferences.getInstance().then((prefs) async {
      
      if (prefs.get(dataStrings[0]) == null || prefs.get(dataStrings[1]) == null || prefs.get(dataStrings[2]) == null) {
        getUpdates(dataStrings);
      } else {
        
        dataStrings.forEach((value) {
          String jsonString = prefs.get(value);
          // print(jsonString);
          Map<String, dynamic> map = jsonDecode(jsonString);
          appState[value] = map[value];
        });
        getUpdates(dataStrings);
      }
    });
  }

  void getUpdates(List<String> data) {
    data.forEach((value) {
      db.collection(value).getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((result) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Map<String, List<dynamic>> map = new Map<String, List<dynamic>>();
          print("yes");
          map[value] = result.data["list"];
          String jsonString = jsonEncode(map);
          print(jsonString);
          prefs.setString(value, jsonString);
          appState[value] = result.data['list'];
        });
      });
    });
  }
}