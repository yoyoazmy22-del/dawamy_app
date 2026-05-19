import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../calendar/domain/models/month_data.dart';
import '../../../calendar/domain/models/day_data.dart';
import '../../../../core/constants/app_constants.dart';

class LocalCalendarDatasource {
  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(AppConstants.hiveCalendarBox);
  }

  Future<MonthData?> getMonthData(int year, int month) async {
    final key = 'month_${year}_$month';
    final data = _box.get(key);
    if (data == null) return null;
    return MonthData.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  Future<void> saveMonthData(MonthData monthData) async {
    final key = 'month_${monthData.year}_${monthData.month}';
    await _box.put(key, jsonEncode(monthData.toJson()));
  }

  Future<DayData?> getDayData(DateTime date) async {
    final key = 'day_${date.year}_${date.month}_${date.day}';
    final data = _box.get(key);
    if (data == null) return null;
    return DayData.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  Future<void> saveDayData(DayData dayData) async {
    final key = 'day_${dayData.date.year}_${dayData.date.month}_${dayData.date.day}';
    await _box.put(key, jsonEncode(dayData.toJson()));
  }

  Future<List<MonthData>> getAllMonths() async {
    final months = <MonthData>[];
    final keys = _box.keys.where((k) => (k as String).startsWith('month_'));
    for (final key in keys) {
      final data = _box.get(key);
      if (data != null) {
        months.add(MonthData.fromJson(jsonDecode(data) as Map<String, dynamic>));
      }
    }
    return months;
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}

final localCalendarDatasourceProvider = Provider<LocalCalendarDatasource>((ref) {
  return LocalCalendarDatasource();
});
