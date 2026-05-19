import 'package:dawamy/features/shifts/domain/models/shift_config.dart';
import 'package:dawamy/features/shifts/domain/models/shift_pattern.dart';

abstract class ShiftRepository {
  Future<ShiftConfig?> getConfigForMonth(int year, int month);
  Future<void> saveConfigForMonth(ShiftConfig config);
  Future<List<ShiftConfig>> getAllConfigs();
  Future<void> deleteConfig(String id);
  Future<void> addPatternToMonth(int year, int month, ShiftPattern pattern);
  Future<void> removePattern(String configId, String patternId);
  Future<void> overrideDay(String configId, DateTime date);
}
