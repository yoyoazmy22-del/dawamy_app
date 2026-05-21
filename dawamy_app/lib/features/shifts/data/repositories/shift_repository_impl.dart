import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/shift_repository.dart';
import '../../domain/models/shift_config.dart';
import '../../domain/models/shift_pattern.dart';
import '../datasources/local_shift_datasource.dart';

class ShiftRepositoryImpl implements ShiftRepository {
  final LocalShiftDatasource _local;

  ShiftRepositoryImpl(this._local);

  @override
  Future<ShiftConfig?> getConfigForMonth(int year, int month) async {
    return _local.getConfigForMonth(year, month);
  }

  @override
  Future<void> saveConfigForMonth(ShiftConfig config) async {
    await _local.saveConfigForMonth(config);
  }

  @override
  Future<List<ShiftConfig>> getAllConfigs() async {
    return _local.getAllConfigs();
  }

  @override
  Future<void> deleteConfig(String id) async {
    await _local.deleteConfig(id);
  }

  @override
  Future<void> addPatternToMonth(int year, int month, ShiftPattern pattern) async {
    final config = await _local.getConfigForMonth(year, month);
    if (config != null) {
      final updated = config.copyWith(
        patterns: [...config.patterns, pattern],
      );
      await _local.saveConfigForMonth(updated);
    }
  }

  @override
  Future<void> removePattern(String configId, String patternId) async {
    final allConfigs = await _local.getAllConfigs();
    final idx = allConfigs.indexWhere((c) => c.id == configId);
    if (idx == -1) return;
    final config = allConfigs[idx];
    final updated = config.copyWith(
      patterns: config.patterns.where((p) => p.id != patternId).toList(),
      updatedAt: DateTime.now(),
    );
    await _local.saveConfigForMonth(updated);
  }

  @override
  Future<void> overrideDay(String configId, DateTime date) async {
    final allConfigs = await _local.getAllConfigs();
    final idx = allConfigs.indexWhere((c) => c.id == configId);
    if (idx == -1) return;
    final config = allConfigs[idx];
    final dateStr = '${date.year}-${date.month}-${date.day}';
    if (config.overriddenDayIds.contains(dateStr)) return;
    final updated = config.copyWith(
      overriddenDayIds: [...config.overriddenDayIds, dateStr],
      updatedAt: DateTime.now(),
    );
    await _local.saveConfigForMonth(updated);
  }
}

final shiftRepositoryProvider = Provider<ShiftRepository>((ref) {
  final local = ref.read(localShiftDatasourceProvider);
  return ShiftRepositoryImpl(local);
});
