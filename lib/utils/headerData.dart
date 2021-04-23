import 'dart:html';

import 'package:shared_preferences/shared_preferences.dart';

class HeaderData {
  // static final HeaderData _instance = HeaderData._internal();
  // factory HeaderData() {
  //   return _instance;
  // }
  // HeaderData._internal();
  static SharedPreferences prefs;
  static Future<bool> setToken(String value) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  static Future<String> getToken() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<bool> setRole(int value) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setInt("role", value);
  }

  static Future<int> getRole() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.get("role");
  }

  static Future<String> setId(String id) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("_id", id);
  }

  static Future<String> getId() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("_id");
  }

  static Future<String> setUserName(String userName) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", userName);
  }

  static Future<String> getUserName() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString("userName");
  }
}
