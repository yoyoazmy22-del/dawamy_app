import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/user.dart';

class LocalAuthDatasource {
  Future<void> saveUser(AppUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_user', jsonEncode(user.toJson()));
  }

  Future<AppUser?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('auth_user');
    if (data == null) return null;
    return AppUser.fromJson(jsonDecode(data));
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_user');
  }

  Future<bool> hasUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_user');
  }
}

final localAuthDatasourceProvider = Provider<LocalAuthDatasource>((ref) {
  return LocalAuthDatasource();
});
