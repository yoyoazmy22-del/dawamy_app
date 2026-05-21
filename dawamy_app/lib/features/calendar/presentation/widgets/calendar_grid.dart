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
    final cs = Theme.of(context).colorScheme;
    final days = AppDateUtils.getMonthGrid(currentMonth);
    final today = DateTime.now();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (i) {
              final isWeekend = i == 0 || i == 6;
              return SizedBox(
                width: 42,
                child: Text(
                  _weekdayLabels[i],
                  textAlign: TextAlign.center,
                  style: AppTypography.labelMedium.copyWith(
                    color: isWeekend
                        ? cs.error.withOpacity(0.5)
                        : cs.onSurface.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(6, (row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (col) {
                final index = row * 7 + col;
                if (index >= days.length) return const SizedBox(width: 42, height: 48);
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

Color shiftColor(ShiftTypeEnum type) {
  switch (type) {
    case ShiftTypeEnum.morning: return const Color(0xFF6C5CE7);
    case ShiftTypeEnum.evening: return const Color(0xFFFF6B81);
    case ShiftTypeEnum.night: return const Color(0xFF2D3436);
    case ShiftTypeEnum.custom: return const Color(0xFF00CEC9);
    case ShiftTypeEnum.off: return const Color(0xFFB2BEC3);
  }
}

Color shiftLabelColor(ShiftTypeEnum type) {
  switch (type) {
    case ShiftTypeEnum.morning: return const Color(0xFF6C5CE7);
    case ShiftTypeEnum.evening: return const Color(0xFFE8505B);
    case ShiftTypeEnum.night: return const Color(0xFF34495E);
    case ShiftTypeEnum.custom: return const Color(0xFF00B894);
    case ShiftTypeEnum.off: return const Color(0xFFB2BEC3);
  }
}

class _DayCell extends StatefulWidget {
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

  @override
  State<_DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<_DayCell> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ShiftTypeEnum? get _shiftType {
    if (widget.dayData?.isOffDay == true) return ShiftTypeEnum.off;
    return widget.dayData?.shift?.type;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final shiftType = _shiftType;
    final hasShift = shiftType != null;

    return GestureDetector(
      onTap: widget.isCurrentMonth ? widget.onTap : null,
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          width: 42,
          height: 48,
          decoration: BoxDecoration(
            color: widget.isToday
                ? cs.primary
                : hasShift && widget.isCurrentMonth
                    ? shiftColor(shiftType).withOpacity(0.12)
                    : null,
            borderRadius: BorderRadius.circular(12),
            border: widget.isToday
                ? Border.all(color: cs.primary, width: 2)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.date.day.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: widget.isToday ? FontWeight.w700 : FontWeight.w500,
                  color: widget.isToday
                      ? cs.onPrimary
                      : !widget.isCurrentMonth
                          ? cs.onSurface.withOpacity(0.15)
                          : cs.onSurface,
                ),
              ),
              if (hasShift && widget.isCurrentMonth && shiftType != ShiftTypeEnum.off)
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    color: widget.isToday
                        ? cs.onPrimary.withOpacity(0.9)
                        : shiftColor(shiftType),
                    shape: BoxShape.circle,
                  ),
                ),
              if (widget.dayData?.isOffDay == true && widget.isCurrentMonth)
                Container(
                  width: 20,
                  height: 2,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    color: widget.isToday
                        ? cs.onPrimary.withOpacity(0.5)
                        : const Color(0xFFB2BEC3).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
