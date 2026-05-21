import 'package:flutter/material.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/utils/date_utils.dart';

class MonthHeader extends StatelessWidget {
  final DateTime currentMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToday;

  const MonthHeader({
    super.key,
    required this.currentMonth,
    required this.onPrevious,
    required this.onNext,
    required this.onToday,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isCurrentMonth = AppDateUtils.isSameMonth(currentMonth, DateTime.now());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _NavButton(
              icon: Icons.chevron_left_rounded,
              onTap: onPrevious,
              cs: cs,
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onToday,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withOpacity(isCurrentMonth ? 0.5 : 0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      AppDateUtils.formatMonth(currentMonth),
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    if (!isCurrentMonth) ...[
                      const SizedBox(width: 6),
                      Icon(Icons.today_rounded, size: 14, color: cs.primary),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            _NavButton(
              icon: Icons.chevron_right_rounded,
              onTap: onNext,
              cs: cs,
            ),
          ],
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final ColorScheme cs;

  const _NavButton({
    required this.icon,
    required this.onTap,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cs.surfaceContainerHighest.withOpacity(0.5),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: cs.onSurface, size: 22),
        ),
      ),
    );
  }
}
