import 'package:flutter/material.dart';
import '../../domain/models/month_data.dart';
import '../../domain/models/day_data.dart';
import '../../domain/models/shift.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/date_utils.dart';

class CalendarGrid extends StatelessWidget {
  final MonthData? monthData;
  final DateTime currentMonth;
  final void Function(DayData) onDayTap;

  const CalendarGrid({
    super.key,
    required this.monthData,
    required this.currentMonth,
    required this.onDayTap,
  });

  static const _weekdayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = AppDateUtils.getMonthGrid(currentMonth);
    final today = DateTime.now();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _weekdayLabels.map((label) {
            return SizedBox(
              width: 38,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTypography.labelMedium.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        ...List.generate(6, (row) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (col) {
                final index = row * 7 + col;
                if (index >= days.length) return const SizedBox(width: 38, height: 44);
                final date = days[index];
                final isCurrentMonth = date.month == currentMonth.month;
                final isToday = AppDateUtils.isSameDay(date, today);

                DayData? dayData;
                if (monthData != null && isCurrentMonth) {
                  try {
                    dayData = monthData!.days.firstWhere(
                      (d) => AppDateUtils.isSameDay(d.date, date),
                    );
                  } catch (_) {}
                }

                return _DayCell(
                  date: date,
                  dayData: dayData,
                  isCurrentMonth: isCurrentMonth,
                  isToday: isToday,
                  onTap: dayData != null ? () => onDayTap(dayData!) : null,
                );
              }),
            ),
          );
        }),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  final DateTime date;
  final DayData? dayData;
  final bool isCurrentMonth;
  final bool isToday;
  final VoidCallback? onTap;

  const _DayCell({
    required this.date,
    this.dayData,
    required this.isCurrentMonth,
    required this.isToday,
    this.onTap,
  });

  ShiftTypeEnum? get _shiftType {
    if (dayData?.isOffDay == true) return ShiftTypeEnum.off;
    return dayData?.shift?.type;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shiftType = _shiftType;
    final hasShift = shiftType != null;

    return GestureDetector(
      onTap: isCurrentMonth ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 38,
        height: 44,
        decoration: BoxDecoration(
          color: isToday
              ? theme.colorScheme.primary
              : hasShift && isCurrentMonth
                  ? _getShiftColor(shiftType, theme).withOpacity(0.15)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isToday
              ? Border.all(color: theme.colorScheme.primary, width: 1.5)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: 13,
                fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                color: isToday
                    ? theme.colorScheme.onPrimary
                    : !isCurrentMonth
                        ? theme.colorScheme.onSurface.withOpacity(0.2)
                        : theme.colorScheme.onSurface,
              ),
            ),
            if (hasShift && isCurrentMonth && shiftType != ShiftTypeEnum.off)
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: _getShiftColor(shiftType, theme),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getShiftColor(ShiftTypeEnum type, ThemeData theme) {
    switch (type) {
      case ShiftTypeEnum.morning:
        return const Color(0xFF6C5CE7);
      case ShiftTypeEnum.evening:
        return const Color(0xFFFD79A8);
      case ShiftTypeEnum.night:
        return const Color(0xFF2D3436);
      case ShiftTypeEnum.custom:
        return const Color(0xFF00CEC9);
      case ShiftTypeEnum.off:
        return const Color(0xFFB2BEC3);
    }
  }
}
