import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/shift_repository.dart';
import '../../domain/models/shift_config.dart';
import '../../domain/models/shift_pattern.dart';
import '../../data/repositories/shift_repository_impl.dart';

class ShiftState {
  final List<ShiftConfig> configs;
  final ShiftConfig? currentConfig;
  final int selectedYear;
  final int selectedMonth;
  final bool isLoading;
  final String? error;

  const ShiftState({
    this.configs = const [],
    this.currentConfig,
    required this.selectedYear,
    required this.selectedMonth,
    this.isLoading = false,
    this.error,
  });

  ShiftState copyWith({
    List<ShiftConfig>? configs,
    ShiftConfig? currentConfig,
    int? selectedYear,
    int? selectedMonth,
    bool? isLoading,
    String? error,
  }) {
    return ShiftState(
      configs: configs ?? this.configs,
      currentConfig: currentConfig ?? this.currentConfig,
      selectedYear: selectedYear ?? this.selectedYear,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ShiftNotifier extends StateNotifier<ShiftState> {
  final ShiftRepository _repository;

  ShiftNotifier(this._repository)
      : super(ShiftState(
          selectedYear: DateTime.now().year,
          selectedMonth: DateTime.now().month,
        ));

  Future<void> loadConfigs() async {
    state = state.copyWith(isLoading: true);
    try {
      final configs = await _repository.getAllConfigs();
      state = state.copyWith(configs: configs, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMonthConfig(int year, int month) async {
    state = state.copyWith(isLoading: true);
    try {
      final config = await _repository.getConfigForMonth(year, month);
      state = state.copyWith(
        currentConfig: config,
        selectedYear: year,
        selectedMonth: month,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addPattern(ShiftPattern pattern) async {
    try {
      await _repository.addPatternToMonth(
        state.selectedYear,
        state.selectedMonth,
        pattern,
      );
      await loadMonthConfig(state.selectedYear, state.selectedMonth);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> saveConfig(ShiftConfig config) async {
    try {
      await _repository.saveConfigForMonth(config);
      await loadConfigs();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final shiftProvider = StateNotifierProvider<ShiftNotifier, ShiftState>((ref) {
  return ShiftNotifier(ref.read(shiftRepositoryProvider));
});
