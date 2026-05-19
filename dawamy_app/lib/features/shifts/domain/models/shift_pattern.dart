import 'package:uuid/uuid.dart';
import '../../../calendar/domain/models/shift.dart';

class ShiftPattern {
  final String id;
  final String name;
  final ShiftTypeEnum shiftType;
  final int consecutiveWorkDays;
  final int consecutiveOffDays;
  final String startTime;
  final String endTime;
  final DateTime startDate;
  final String? customName;
  final DateTime createdAt;

  const ShiftPattern({
    required this.id,
    required this.name,
    required this.shiftType,
    required this.consecutiveWorkDays,
    required this.consecutiveOffDays,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    this.customName,
    required this.createdAt,
  });

  ShiftPattern copyWith({
    String? id,
    String? name,
    ShiftTypeEnum? shiftType,
    int? consecutiveWorkDays,
    int? consecutiveOffDays,
    String? startTime,
    String? endTime,
    DateTime? startDate,
    String? customName,
    DateTime? createdAt,
  }) {
    return ShiftPattern(
      id: id ?? this.id,
      name: name ?? this.name,
      shiftType: shiftType ?? this.shiftType,
      consecutiveWorkDays: consecutiveWorkDays ?? this.consecutiveWorkDays,
      consecutiveOffDays: consecutiveOffDays ?? this.consecutiveOffDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startDate: startDate ?? this.startDate,
      customName: customName ?? this.customName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'shiftType': shiftType.name,
        'consecutiveWorkDays': consecutiveWorkDays,
        'consecutiveOffDays': consecutiveOffDays,
        'startTime': startTime,
        'endTime': endTime,
        'startDate': startDate.toIso8601String(),
        'customName': customName,
        'createdAt': createdAt.toIso8601String(),
      };

  factory ShiftPattern.fromJson(Map<String, dynamic> json) => ShiftPattern(
        id: json['id'] as String,
        name: json['name'] as String,
        shiftType: ShiftTypeEnum.values.firstWhere(
          (e) => e.name == json['shiftType'],
          orElse: () => ShiftTypeEnum.morning,
        ),
        consecutiveWorkDays: json['consecutiveWorkDays'] as int,
        consecutiveOffDays: json['consecutiveOffDays'] as int,
        startTime: json['startTime'] as String,
        endTime: json['endTime'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        customName: json['customName'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  List<Shift> generateShifts(int year, int month) {
    final shifts = <Shift>[];
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    final cycleLength = consecutiveWorkDays + consecutiveOffDays;

    int dayIndex = 0;
    for (int day = 1; day <= lastDay.day; day++) {
      final date = DateTime(year, month, day);
      if (date.isBefore(startDate)) {
        dayIndex++;
        continue;
      }

      final positionInCycle = dayIndex % cycleLength;
      final isWorkDay = positionInCycle < consecutiveWorkDays;
      dayIndex++;

      if (isWorkDay) {
        shifts.add(Shift(
          id: const Uuid().v4(),
          type: shiftType,
          date: date,
          startTime: startTime,
          endTime: endTime,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
      }
    }
    return shifts;
  }
}
