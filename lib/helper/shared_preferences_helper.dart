import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<String> getCurrentWeapon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("currentWeapon");
  }

  static Future<void> setCurrentWeapon(String currentWeapon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("currentWeapon", currentWeapon);
  }

  static Future<List<String>> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("list");
  }

  static Future<void> setList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("list", list);
  }
}
