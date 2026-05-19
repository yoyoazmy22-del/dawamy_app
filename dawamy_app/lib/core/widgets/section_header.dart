import 'package:flutter/material.dart';
import '../theme/typography.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry? padding;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: AppTypography.labelLarge.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
