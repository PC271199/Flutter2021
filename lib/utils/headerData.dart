
import 'package:shared_preferences/shared_preferences.dart';

class HeaderData {

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

  static Future<bool> setUserId(String value) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.setString("userId", value);
  }

  static Future<String> getUserId() async {
    prefs = await SharedPreferences.getInstance();
    return prefs.get("userId");
  }
}
