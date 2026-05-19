import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  Future<void> setThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode);
  }

  Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme_mode') ?? 'system';
  }

  Future<void> exportData() async {}
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});
