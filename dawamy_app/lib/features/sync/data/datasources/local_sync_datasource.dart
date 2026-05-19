import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSyncDatasource {
  Future<void> saveLastSyncTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_sync_time', time.toIso8601String());
  }

  Future<DateTime?> getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('last_sync_time');
    if (data == null) return null;
    return DateTime.parse(data);
  }

  Future<void> markPendingSync() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('pending_sync', true);
  }

  Future<bool> hasPendingSync() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('pending_sync') ?? false;
  }

  Future<void> clearPendingSync() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('pending_sync');
  }
}

final localSyncDatasourceProvider = Provider<LocalSyncDatasource>((ref) {
  return LocalSyncDatasource();
});
