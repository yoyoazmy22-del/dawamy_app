import 'day_data.dart';

class MonthData {
  final int year;
  final int month;
  final List<DayData> days;
  final double totalOvertimeHours;
  final int workDays;
  final int offDays;
  final int morningShifts;
  final int eveningShifts;
  final int nightShifts;
  final int customShifts;

  const MonthData({
    required this.year,
    required this.month,
    required this.days,
    this.totalOvertimeHours = 0,
    this.workDays = 0,
    this.offDays = 0,
    this.morningShifts = 0,
    this.eveningShifts = 0,
    this.nightShifts = 0,
    this.customShifts = 0,
  });

  Map<String, dynamic> toJson() => {
        'year': year,
        'month': month,
        'days': days.map((d) => d.toJson()).toList(),
        'totalOvertimeHours': totalOvertimeHours,
        'workDays': workDays,
        'offDays': offDays,
        'morningShifts': morningShifts,
        'eveningShifts': eveningShifts,
        'nightShifts': nightShifts,
        'customShifts': customShifts,
      };

  factory MonthData.fromJson(Map<String, dynamic> json) => MonthData(
        year: json['year'] as int,
        month: json['month'] as int,
        days: (json['days'] as List<dynamic>)
            .map((d) => DayData.fromJson(d as Map<String, dynamic>))
            .toList(),
        totalOvertimeHours: (json['totalOvertimeHours'] as num?)?.toDouble() ?? 0,
        workDays: json['workDays'] as int? ?? 0,
        offDays: json['offDays'] as int? ?? 0,
        morningShifts: json['morningShifts'] as int? ?? 0,
        eveningShifts: json['eveningShifts'] as int? ?? 0,
        nightShifts: json['nightShifts'] as int? ?? 0,
        customShifts: json['customShifts'] as int? ?? 0,
      );

  static String monthName(int month) {
    const names = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return names[month - 1];
  }
}
