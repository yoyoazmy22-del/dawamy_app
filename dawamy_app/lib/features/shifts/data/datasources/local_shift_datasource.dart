import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/shift_config.dart';
import '../../../../core/constants/app_constants.dart';

class LocalShiftDatasource {
  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(AppConstants.hiveShiftsBox);
  }

  Future<ShiftConfig?> getConfigForMonth(int year, int month) async {
    final key = 'config_${year}_$month';
    final data = _box.get(key);
    if (data == null) return null;
    return ShiftConfig.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  Future<void> saveConfigForMonth(ShiftConfig config) async {
    final key = 'config_${config.year}_${config.month}';
    await _box.put(key, jsonEncode(config.toJson()));
  }

  Future<List<ShiftConfig>> getAllConfigs() async {
    final configs = <ShiftConfig>[];
    final keys = _box.keys.where((k) => (k as String).startsWith('config_'));
    for (final key in keys) {
      final data = _box.get(key);
      if (data != null) {
        configs.add(ShiftConfig.fromJson(jsonDecode(data) as Map<String, dynamic>));
      }
    }
    configs.sort((a, b) {
      if (a.year != b.year) return b.year.compareTo(a.year);
      return b.month.compareTo(a.month);
    });
    return configs;
  }

  Future<void> deleteConfig(String id) async {
    final keys = _box.keys.where((k) {
      final data = _box.get(k);
      if (data == null) return false;
      try {
        final config = ShiftConfig.fromJson(jsonDecode(data) as Map<String, dynamic>);
        return config.id == id;
      } catch (_) {
        return false;
      }
    });
    for (final key in keys) {
      await _box.delete(key);
    }
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}

final localShiftDatasourceProvider = Provider<LocalShiftDatasource>((ref) {
  return LocalShiftDatasource();
});
