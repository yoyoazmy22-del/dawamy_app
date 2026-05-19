import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/models/day_data.dart';
import '../../domain/models/shift.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/shift_badge.dart';

class DayDetailSheet extends StatelessWidget {
  final DayData dayData;

  const DayDetailSheet({super.key, required this.dayData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shift = dayData.shift;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.85,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppDateUtils.formatFull(dayData.date),
                          style: AppTypography.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppDateUtils.formatDayName(dayData.date),
                          style: AppTypography.bodyMedium.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    if (shift != null)
                      ShiftBadge(type: mapToWidgetShift(shift.type), fontSize: 13),
                    if (dayData.isOffDay)
                      const ShiftBadge(type: ShiftType.off, fontSize: 13),
                  ],
                ),
                const SizedBox(height: 24),
                if (shift != null) ...[
                  _buildInfoCard(
                    context,
                    Icons.schedule_outlined,
                    'Shift Hours',
                    shift.startTime != null && shift.endTime != null
                        ? '${shift.startTime} - ${shift.endTime}'
                        : 'Not set',
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    context,
                    Icons.access_time_rounded,
                    'Duration',
                    '${shift.hours.toStringAsFixed(1)} hours',
                  ),
                  if (dayData.overtimeHours > 0) ...[
                    const SizedBox(height: 12),
                    _buildInfoCard(
                      context,
                      Icons.timer_outlined,
                      'Overtime',
                      '${dayData.overtimeHours.toStringAsFixed(1)} hours',
                      accent: true,
                    ),
                  ],
                ],
                if (dayData.notes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Notes',
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...dayData.notes.map((note) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 4,
                          color: theme.colorScheme.onSurface.withOpacity(0.3),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            note,
                            style: AppTypography.bodySmall.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
                const SizedBox(height: 24),
                shift != null ? _buildShiftTimeline(context, shift) : const SizedBox(),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1);
        },
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool accent = false,
  }) {
    final theme = Theme.of(context);
    final color = accent
        ? const Color(0xFFE17055)
        : theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.caption.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              )),
              const SizedBox(height: 2),
              Text(value, style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShiftTimeline(BuildContext context, Shift shift) {
    if (shift.startTime == null || shift.endTime == null) {
      return const SizedBox();
    }

    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shift Timeline',
            style: AppTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF00B894),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start', style: AppTypography.caption.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  )),
                  Text(shift.startTime!, style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Container(
              width: 2,
              height: 24,
              margin: const EdgeInsets.symmetric(vertical: 4),
              color: theme.dividerColor,
            ),
          ),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFE17055),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('End', style: AppTypography.caption.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  )),
                  Text(shift.endTime!, style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
