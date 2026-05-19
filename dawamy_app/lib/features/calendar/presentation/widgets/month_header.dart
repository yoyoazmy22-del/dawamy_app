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
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onPrevious,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: theme.colorScheme.onSurface,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onToday,
              child: Text(
                AppDateUtils.formatMonth(currentMonth),
                style: AppTypography.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onNext,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurface,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
