import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/models/day_data.dart';
import '../../domain/models/shift.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/shift_badge.dart';
import '../widgets/calendar_grid.dart';

class DayDetailSheet extends StatelessWidget {
  final DayData dayData;

  const DayDetailSheet({super.key, required this.dayData});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final shift = dayData.shift;
    final isDark = cs.brightness == Brightness.dark;
    final sc = shiftColor(shift?.type ?? ShiftTypeEnum.off);

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.85,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.15)
                          : Colors.black.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppDateUtils.formatFull(dayData.date),
                            style: AppTypography.titleLarge.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_rounded,
                                  size: 12,
                                  color: cs.onSurface.withOpacity(0.4)),
                              const SizedBox(width: 4),
                              Text(
                                AppDateUtils.formatDayName(dayData.date),
                                style: AppTypography.bodyMedium.copyWith(
                                  color: cs.onSurface.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (shift != null)
                      ShiftBadge(type: mapToWidgetShift(shift.type), fontSize: 13),
                    if (dayData.isOffDay)
                      const ShiftBadge(type: ShiftType.off, fontSize: 13),
                  ],
                ),
                const SizedBox(height: 24),
                if (shift != null) ...[
                  Row(
                    children: [
                      Expanded(child: _infoTile(
                        cs, Icons.schedule_outlined, 'Start',
                        shift.startTime ?? '--',
                        sc,
                      )),
                      const SizedBox(width: 8),
                      Expanded(child: _infoTile(
                        cs, Icons.schedule_outlined, 'End',
                        shift.endTime ?? '--',
                        shiftLabelColor(shift.type),
                      )),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _infoTile(
                        cs, Icons.access_time_rounded, 'Duration',
                        '${shift.hours.toStringAsFixed(1)} hrs',
                        sc,
                      )),
                      if (dayData.overtimeHours > 0) ...[
                        const SizedBox(width: 8),
                        Expanded(child: _infoTile(
                          cs, Icons.timer_outlined, 'Overtime',
                          '${dayData.overtimeHours.toStringAsFixed(1)} hrs',
                          const Color(0xFFE17055),
                        )),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (shift.startTime != null && shift.endTime != null)
                    _buildTimeline(context, shift, cs, sc),
                ],
                if (dayData.isOffDay) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB2BEC3).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFB2BEC3).withOpacity(0.15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.nightlight_round,
                          size: 32, color: const Color(0xFFB2BEC3)),
                        const SizedBox(height: 8),
                        Text('Day Off',
                          style: AppTypography.titleMedium.copyWith(
                            color: const Color(0xFFB2BEC3),
                          )),
                      ],
                    ),
                  ),
                ],
                if (dayData.notes.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Notes',
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...dayData.notes.map((note) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: cs.primary.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            note,
                            style: AppTypography.bodyMedium.copyWith(
                              color: cs.onSurface.withOpacity(0.7),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1);
        },
      ),
    );
  }

  Widget _infoTile(ColorScheme cs, IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.caption.copyWith(
                color: cs.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w500,
              )),
              Text(value, style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, Shift shift, ColorScheme cs, Color sc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outline.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: sc.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.timeline_rounded, size: 16, color: sc),
              ),
              const SizedBox(width: 8),
              Text('Shift Timeline',
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                )),
            ],
          ),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(
                        color: sc, shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: sc.withOpacity(0.4), blurRadius: 6, spreadRadius: 1),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 2,
                        color: cs.outline.withOpacity(0.2),
                      ),
                    ),
                    Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(
                        color: shiftLabelColor(shift.type), shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: shiftLabelColor(shift.type).withOpacity(0.4),
                            blurRadius: 6, spreadRadius: 1),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Start', style: AppTypography.caption.copyWith(
                        color: cs.onSurface.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      )),
                      Text(shift.startTime!, style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700, color: sc,
                      )),
                      const SizedBox(height: 16),
                      Text('End', style: AppTypography.caption.copyWith(
                        color: cs.onSurface.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      )),
                      Text(shift.endTime!, style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: shiftLabelColor(shift.type),
                      )),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: sc.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${shift.hours.toStringAsFixed(1)}h total',
                          style: AppTypography.caption.copyWith(
                            color: sc, fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
