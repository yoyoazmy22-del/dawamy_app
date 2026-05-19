import 'package:flutter/material.dart';
import '../../features/calendar/domain/models/shift.dart';

enum ShiftType { morning, evening, night, custom, off }

ShiftType mapToWidgetShift(ShiftTypeEnum type) {
  switch (type) {
    case ShiftTypeEnum.morning: return ShiftType.morning;
    case ShiftTypeEnum.evening: return ShiftType.evening;
    case ShiftTypeEnum.night: return ShiftType.night;
    case ShiftTypeEnum.custom: return ShiftType.custom;
    case ShiftTypeEnum.off: return ShiftType.off;
  }
}

class ShiftBadge extends StatelessWidget {
  final ShiftType type;
  final double fontSize;
  final bool compact;
  final String? customLabel;

  const ShiftBadge({
    super.key,
    required this.type,
    this.fontSize = 11,
    this.compact = false,
    this.customLabel,
  });

  Color _getColor(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    switch (type) {
      case ShiftType.morning:
        return isDark ? const Color(0xFF7C6FF7) : const Color(0xFF6C5CE7);
      case ShiftType.evening:
        return isDark ? const Color(0xFFFD79A8) : const Color(0xFFFD79A8);
      case ShiftType.night:
        return isDark ? const Color(0xFF636E72) : const Color(0xFF2D3436);
      case ShiftType.custom:
        return isDark ? const Color(0xFF00D2D3) : const Color(0xFF00CEC9);
      case ShiftType.off:
        return isDark ? const Color(0xFF3D4059) : const Color(0xFFB2BEC3);
    }
  }

  Color _getTextColor(BuildContext context) {
    if (type == ShiftType.off && Theme.of(context).brightness == Brightness.light) {
      return const Color(0xFF636E72);
    }
    if (type == ShiftType.night) {
      return Colors.white;
    }
    return Colors.white;
  }

  String get _label {
    switch (type) {
      case ShiftType.morning:
        return 'Morning';
      case ShiftType.evening:
        return 'Evening';
      case ShiftType.night:
        return 'Night';
      case ShiftType.custom:
        return customLabel ?? 'Custom';
      case ShiftType.off:
        return 'Off';
    }
  }

  String get _shortLabel {
    switch (type) {
      case ShiftType.morning:
        return 'M';
      case ShiftType.evening:
        return 'E';
      case ShiftType.night:
        return 'N';
      case ShiftType.custom:
        return 'C';
      case ShiftType.off:
        return '';
    }
  }

  IconData? get _icon {
    switch (type) {
      case ShiftType.morning:
        return Icons.wb_sunny_outlined;
      case ShiftType.evening:
        return Icons.nights_stay_outlined;
      case ShiftType.night:
        return Icons.dark_mode_outlined;
      case ShiftType.custom:
        return Icons.schedule_outlined;
      case ShiftType.off:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor(context);
    final textColor = _getTextColor(context);

    if (compact && type != ShiftType.off) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            _shortLabel,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(type == ShiftType.off ? 0.15 : 0.9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_icon != null) ...[
            Icon(_icon, size: fontSize + 1, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            _label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: textColor,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
