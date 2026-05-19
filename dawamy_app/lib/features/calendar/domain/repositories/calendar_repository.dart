import 'package:dawamy/features/calendar/domain/models/month_data.dart';
import 'package:dawamy/features/calendar/domain/models/day_data.dart';

abstract class CalendarRepository {
  Future<MonthData> getMonthData(int year, int month);
  Future<DayData?> getDayData(DateTime date);
  Future<void> saveDayData(DayData dayData);
  Future<void> saveMonthData(MonthData monthData);
  Future<void> updateShiftForDay(DateTime date, String shiftId);
  Future<void> markDayOff(DateTime date);
  Future<List<MonthData>> getAllMonths();
  Future<double> getTotalOvertimeHours(int year, int month);
}
