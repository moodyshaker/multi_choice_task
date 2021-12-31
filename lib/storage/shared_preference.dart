import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences _preferences;
  static final Preferences instance = Preferences._instance();
  static const String id = 'ID';
  static const String token = 'TOKEN';

  Preferences._instance();

  Future<SharedPreferences> initPref() async =>
      _preferences ??= await SharedPreferences.getInstance();

  Future<bool> setUserId(String value) async {
    bool isSet = await _preferences.setString(id, value);
    return isSet;
  }

  Future<bool> setAccessToken(String value) async {
    bool isSet = await _preferences.setString(token, value);
    return isSet;
  }

  Future<bool> clearUser() async {
    bool isCleared = await _preferences.clear();
    return isCleared;
  }



  String get getUserId => _preferences.getString(id) ?? '';


  String get getAccessToken => _preferences.getString(token) ?? '';




}
