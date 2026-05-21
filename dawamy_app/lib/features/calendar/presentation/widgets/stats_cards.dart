import 'package:flutter/material.dart';
import '../../../../core/theme/typography.dart';
import '../../domain/models/month_data.dart';

class StatsCards extends StatelessWidget {
  final MonthData? monthData;

  const StatsCards({super.key, this.monthData});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final stats = [
      _StatData(
        label: 'Work Days',
        value: monthData?.workDays ?? 0,
        suffix: '',
        icon: Icons.work_outline,
        color: const Color(0xFF6C5CE7),
        darkColor: const Color(0xFFA29BFE),
      ),
      _StatData(
        label: 'Off Days',
        value: monthData?.offDays ?? 0,
        suffix: '',
        icon: Icons.nightlight_round,
        color: const Color(0xFF00CEC9),
        darkColor: const Color(0xFF55EFC4),
      ),
      _StatData(
        label: 'Overtime',
        value: (monthData?.totalOvertimeHours ?? 0).toInt(),
        suffix: 'h',
        icon: Icons.timer_outlined,
        color: const Color(0xFFE17055),
        darkColor: const Color(0xFFFAB1A0),
      ),
    ];

    return Row(
      children: List.generate(stats.length, (i) {
        final stat = stats[i];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < stats.length - 1 ? 8 : 0),
            child: _StatCard(stat: stat, isDark: isDark),
          ),
        );
      }),
    );
  }
}

class _StatData {
  final String label;
  final int value;
  final String suffix;
  final IconData icon;
  final Color color;
  final Color darkColor;
  const _StatData({
    required this.label,
    required this.value,
    required this.suffix,
    required this.icon,
    required this.color,
    required this.darkColor,
  });
}

class _StatCard extends StatelessWidget {
  final _StatData stat;
  final bool isDark;

  const _StatCard({required this.stat, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isDark ? stat.darkColor : stat.color;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            effectiveColor.withOpacity(isDark ? 0.12 : 0.08),
            effectiveColor.withOpacity(isDark ? 0.06 : 0.03),
          ],
        ),
        border: Border.all(
          color: effectiveColor.withOpacity(isDark ? 0.2 : 0.12),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: effectiveColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(stat.icon, size: 16, color: effectiveColor),
          ),
          const SizedBox(height: 12),
          AnimatedCount(
            value: stat.value,
            suffix: stat.suffix,
            color: effectiveColor,
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: AppTypography.caption.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedCount extends StatefulWidget {
  final int value;
  final String suffix;
  final Color color;

  const AnimatedCount({
    super.key,
    required this.value,
    required this.suffix,
    required this.color,
  });

  @override
  State<AnimatedCount> createState() => _AnimatedCountState();
}

class _AnimatedCountState extends State<AnimatedCount>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final display = (_animation.value * widget.value).round();
        return Text(
          '$display${widget.suffix}',
          style: AppTypography.mediumNumber.copyWith(
            fontSize: 22,
            color: widget.color,
          ),
        );
      },
    );
  }
}
