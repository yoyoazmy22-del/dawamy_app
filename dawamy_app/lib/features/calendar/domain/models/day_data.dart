import 'shift.dart';

class DayData {
  final DateTime date;
  final Shift? shift;
  final bool isOffDay;
  final bool isToday;
  final double overtimeHours;
  final List<String> notes;

  const DayData({
    required this.date,
    this.shift,
    this.isOffDay = false,
    this.isToday = false,
    this.overtimeHours = 0,
    this.notes = const [],
  });

  DayData copyWith({
    DateTime? date,
    Shift? shift,
    bool? isOffDay,
    bool? isToday,
    double? overtimeHours,
    List<String>? notes,
  }) {
    return DayData(
      date: date ?? this.date,
      shift: shift ?? this.shift,
      isOffDay: isOffDay ?? this.isOffDay,
      isToday: isToday ?? this.isToday,
      overtimeHours: overtimeHours ?? this.overtimeHours,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'shift': shift?.toJson(),
        'isOffDay': isOffDay,
        'overtimeHours': overtimeHours,
        'notes': notes,
      };

  factory DayData.fromJson(Map<String, dynamic> json) => DayData(
        date: DateTime.parse(json['date'] as String),
        shift: json['shift'] != null
            ? Shift.fromJson(json['shift'] as Map<String, dynamic>)
            : null,
        isOffDay: json['isOffDay'] as bool? ?? false,
        isToday: json['isToday'] as bool? ?? false,
        overtimeHours: (json['overtimeHours'] as num?)?.toDouble() ?? 0,
        notes: List<String>.from(json['notes'] ?? []),
      );
}
