import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/calendar_repository.dart';
import '../../domain/models/month_data.dart';
import '../../domain/models/day_data.dart';
import '../../data/repositories/calendar_repository_impl.dart';

class CalendarState {
  final DateTime currentMonth;
  final MonthData? monthData;
  final DayData? selectedDay;
  final bool isLoading;
  final String? error;
  final bool showDetailSheet;

  const CalendarState({
    required this.currentMonth,
    this.monthData,
    this.selectedDay,
    this.isLoading = false,
    this.error,
    this.showDetailSheet = false,
  });

  CalendarState copyWith({
    DateTime? currentMonth,
    MonthData? monthData,
    DayData? selectedDay,
    bool? isLoading,
    String? error,
    bool? showDetailSheet,
  }) {
    return CalendarState(
      currentMonth: currentMonth ?? this.currentMonth,
      monthData: monthData ?? this.monthData,
      selectedDay: selectedDay ?? this.selectedDay,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      showDetailSheet: showDetailSheet ?? this.showDetailSheet,
    );
  }
}

class CalendarNotifier extends StateNotifier<CalendarState> {
  final CalendarRepository _repository;

  CalendarNotifier(this._repository)
      : super(CalendarState(currentMonth: DateTime.now()));

  Future<void> loadMonth({int? year, int? month}) async {
    final y = year ?? state.currentMonth.year;
    final m = month ?? state.currentMonth.month;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final monthData = await _repository.getMonthData(y, m);
      state = state.copyWith(
        currentMonth: DateTime(y, m),
        monthData: monthData,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void goToNextMonth() {
    final newMonth = DateTime(
      state.currentMonth.year,
      state.currentMonth.month + 1,
      1,
    );
    loadMonth(year: newMonth.year, month: newMonth.month);
  }

  void goToPreviousMonth() {
    final newMonth = DateTime(
      state.currentMonth.year,
      state.currentMonth.month - 1,
      1,
    );
    loadMonth(year: newMonth.year, month: newMonth.month);
  }

  void goToToday() {
    loadMonth(year: DateTime.now().year, month: DateTime.now().month);
  }

  void selectDay(DayData day) {
    state = state.copyWith(
      selectedDay: day,
      showDetailSheet: true,
    );
  }

  void closeDetailSheet() {
    state = state.copyWith(showDetailSheet: false);
  }

  Future<void> markDayOff(DateTime date) async {
    await _repository.markDayOff(date);
    await loadMonth(year: date.year, month: date.month);
  }
}

final calendarProvider = StateNotifierProvider<CalendarNotifier, CalendarState>((ref) {
  return CalendarNotifier(ref.read(calendarRepositoryProvider));
});
