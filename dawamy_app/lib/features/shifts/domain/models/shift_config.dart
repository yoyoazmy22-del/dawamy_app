import 'shift_pattern.dart';

class ShiftConfig {
  final String id;
  final int year;
  final int month;
  final List<ShiftPattern> patterns;
  final List<String> overriddenDayIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ShiftConfig({
    required this.id,
    required this.year,
    required this.month,
    required this.patterns,
    this.overriddenDayIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  ShiftConfig copyWith({
    String? id,
    int? year,
    int? month,
    List<ShiftPattern>? patterns,
    List<String>? overriddenDayIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ShiftConfig(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      patterns: patterns ?? this.patterns,
      overriddenDayIds: overriddenDayIds ?? this.overriddenDayIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'year': year,
        'month': month,
        'patterns': patterns.map((p) => p.toJson()).toList(),
        'overriddenDayIds': overriddenDayIds,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory ShiftConfig.fromJson(Map<String, dynamic> json) => ShiftConfig(
        id: json['id'] as String,
        year: json['year'] as int,
        month: json['month'] as int,
        patterns: (json['patterns'] as List<dynamic>)
            .map((p) => ShiftPattern.fromJson(p as Map<String, dynamic>))
            .toList(),
        overriddenDayIds: List<String>.from(json['overriddenDayIds'] ?? []),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
}
