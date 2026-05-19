enum ShiftTypeEnum { morning, evening, night, custom, off }

class Shift {
  final String id;
  final ShiftTypeEnum type;
  final DateTime date;
  final String? startTime;
  final String? endTime;
  final String? notes;
  final bool isOverridden;
  final String? customName;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Shift({
    required this.id,
    required this.type,
    required this.date,
    this.startTime,
    this.endTime,
    this.notes,
    this.isOverridden = false,
    this.customName,
    required this.createdAt,
    required this.updatedAt,
  });

  Shift copyWith({
    String? id,
    ShiftTypeEnum? type,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? notes,
    bool? isOverridden,
    String? customName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Shift(
      id: id ?? this.id,
      type: type ?? this.type,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
      isOverridden: isOverridden ?? this.isOverridden,
      customName: customName ?? this.customName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'date': date.toIso8601String(),
        'startTime': startTime,
        'endTime': endTime,
        'notes': notes,
        'isOverridden': isOverridden,
        'customName': customName,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json['id'] as String,
        type: ShiftTypeEnum.values.firstWhere(
          (e) => e.name == json['type'],
          orElse: () => ShiftTypeEnum.off,
        ),
        date: DateTime.parse(json['date'] as String),
        startTime: json['startTime'] as String?,
        endTime: json['endTime'] as String?,
        notes: json['notes'] as String?,
        isOverridden: json['isOverridden'] as bool? ?? false,
        customName: json['customName'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );

  double get hours {
    if (startTime == null || endTime == null) return 0;
    final parts = startTime!.split(':');
    final start = int.parse(parts[0]) * 60 + int.parse(parts[1]);
    final endParts = endTime!.split(':');
    final end = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);
    return (end - start) / 60;
  }

  String get displayName {
    if (type == ShiftTypeEnum.custom && customName != null) return customName!;
    switch (type) {
      case ShiftTypeEnum.morning:
        return 'Morning Shift';
      case ShiftTypeEnum.evening:
        return 'Evening Shift';
      case ShiftTypeEnum.night:
        return 'Night Shift';
      case ShiftTypeEnum.custom:
        return 'Custom Shift';
      case ShiftTypeEnum.off:
        return 'Off Day';
    }
  }
}
