import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FavUtils {
  static addFav(String id, String value, String villageType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fabString = prefs.getString(villageType);

    if (fabString == null) {
      Map<String, String> map = new Map<String, String>();
      map[id] = value;
      String jsonFormat = jsonEncode(map);
      prefs.setString(villageType, jsonFormat);
    } else {
      var fabs = jsonDecode(fabString);
      fabs[id] = value;
      String jsonFormat = jsonEncode(fabs);
      prefs.setString(villageType, jsonFormat);
    }
  }

  static Future<bool> getFav(String id, String villageType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fabString = prefs.get(villageType);
    if (fabString == null) {
      return (false);
    }
    Map<String, dynamic> map = jsonDecode(fabString);
    if (map.containsKey(id)) {
      return (true);
    } else {
      return (false);
    }
  }

  static removeFav(String id, String villageType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fabString = prefs.getString(villageType);
    Map<String, dynamic> fabs = jsonDecode(fabString);
    fabs.remove(id);
    fabString = jsonEncode(fabs);
    prefs.setString(villageType, fabString);
  }

  static getAllFavourities(String villageType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fabString = prefs.getString(villageType);

    Map<String, dynamic> fabs = new Map<String, dynamic>();
    if (fabString != null) {
      fabs = jsonDecode(fabString);
    }

    return (fabs);
  }
}
