import 'package:flutter/material.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/theme/light_theme.dart';
import '../../domain/models/month_data.dart';

class StatsCards extends StatelessWidget {
  final MonthData? monthData;

  const StatsCards({super.key, this.monthData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stats = [
      _StatItem(
        label: 'Work Days',
        value: '${monthData?.workDays ?? 0}',
        icon: Icons.work_outline,
        color: LightThemeColors.primary,
        gradient: true,
      ),
      _StatItem(
        label: 'Off Days',
        value: '${monthData?.offDays ?? 0}',
        icon: Icons.nightlight_round,
        color: LightThemeColors.secondary,
        gradient: true,
      ),
      _StatItem(
        label: 'Overtime',
        value: '${monthData?.totalOvertimeHours.toStringAsFixed(0) ?? '0'}h',
        icon: Icons.timer_outlined,
        color: LightThemeColors.accent,
        gradient: true,
      ),
    ];

    return Row(
      children: stats.map((stat) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: stats.indexOf(stat) < stats.length - 1 ? 8 : 0,
            ),
            child: _buildStatCard(context, stat),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(BuildContext context, _StatItem stat) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: stat.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: stat.color.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(stat.icon, size: 18, color: stat.color),
          const SizedBox(height: 10),
          Text(
            stat.value,
            style: AppTypography.mediumNumber.copyWith(
              fontSize: 22,
              color: stat.color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: AppTypography.caption.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool gradient;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.gradient = false,
  });
}
