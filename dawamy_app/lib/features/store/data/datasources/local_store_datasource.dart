import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/store_data.dart';

class LocalStoreDatasource {
  Future<void> saveStoreLink(StoreLink link) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('store_link', jsonEncode(link.toJson()));
  }

  Future<StoreLink?> getStoreLink() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('store_link');
    if (data == null) return null;
    return StoreLink.fromJson(jsonDecode(data));
  }

  Future<void> removeStoreLink() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('store_link');
  }
}

final localStoreDatasourceProvider = Provider<LocalStoreDatasource>((ref) {
  return LocalStoreDatasource();
});
