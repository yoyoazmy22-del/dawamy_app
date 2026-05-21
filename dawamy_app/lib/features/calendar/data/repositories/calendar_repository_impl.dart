import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../calendar/domain/repositories/calendar_repository.dart';
import '../../../calendar/domain/models/month_data.dart';
import '../../../calendar/domain/models/day_data.dart';
import '../../../calendar/domain/models/shift.dart';
import '../datasources/local_calendar_datasource.dart';
import '../datasources/remote_calendar_datasource.dart';
import '../../../../services/http_service.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  final LocalCalendarDatasource _local;
  final RemoteCalendarDatasource _remote;

  CalendarRepositoryImpl(this._local, this._remote);

  @override
  Future<MonthData> getMonthData(int year, int month) async {
    final local = await _local.getMonthData(year, month);
    if (local != null) return local;

    final days = <DayData>[];
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);

    for (int day = 1; day <= lastDay.day; day++) {
      final date = DateTime(year, month, day);
      final localDay = await _local.getDayData(date);
      days.add(localDay ?? DayData(
        date: date,
        isToday: _isToday(date),
      ));
    }

    return MonthData(year: year, month: month, days: days);
  }

  @override
  Future<DayData?> getDayData(DateTime date) async => _local.getDayData(date);

  @override
  Future<void> saveDayData(DayData dayData) async => _local.saveDayData(dayData);

  @override
  Future<void> saveMonthData(MonthData monthData) async => _local.saveMonthData(monthData);

  @override
  Future<void> updateShiftForDay(DateTime date, String shiftId) async {
    final existing = await _local.getDayData(date);
    final shift = Shift(
      id: shiftId,
      type: ShiftTypeEnum.morning,
      date: date,
      startTime: DateTime(date.year, date.month, date.day, 8, 0),
      endTime: DateTime(date.year, date.month, date.day, 16, 0),
    );
    await _local.saveDayData(
      (existing ?? DayData(date: date, isToday: _isToday(date)))
          .copyWith(shift: shift, isOffDay: false),
    );
  }

  @override
  Future<void> markDayOff(DateTime date) async {
    final existing = await _local.getDayData(date);
    await _local.saveDayData(
      (existing ?? DayData(date: date, isToday: _isToday(date)))
          .copyWith(shift: null, isOffDay: true),
    );
  }

  @override
  Future<List<MonthData>> getAllMonths() async => _local.getAllMonths();

  @override
  Future<double> getTotalOvertimeHours(int year, int month) async {
    final monthData = await getMonthData(year, month);
    return monthData.totalOvertimeHours;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  final local = ref.read(localCalendarDatasourceProvider);
  final http = ref.read(httpServiceProvider);
  final remote = RemoteCalendarDatasource(http.dio);
  return CalendarRepositoryImpl(local, remote);
});
