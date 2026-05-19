import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/typography.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                icon,
                size: 36,
                color: theme.colorScheme.primary,
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
            const SizedBox(height: 24),
            Text(
              title,
              style: AppTypography.titleLarge,
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
            ],
          ],
        ),
      ),
    );
  }
}
