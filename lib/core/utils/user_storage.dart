import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desktop_nextmind/data/models/user_model.dart';

class UserStorage {
  static const _userKey = 'user';

  /// Salva o usuário no SharedPreferences
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  /// Carrega o usuário do SharedPreferences
  static Future<UserModel?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString == null) return null;
    return UserModel.fromJson(jsonDecode(userString));
  }

  /// Remove o usuário (ex: logout)
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
