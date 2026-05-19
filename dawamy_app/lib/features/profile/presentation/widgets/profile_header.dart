import 'package:flutter/material.dart';
import '../../../../core/theme/typography.dart';

class ProfileHeader extends StatelessWidget {
  final bool isPro;
  final VoidCallback onUpgrade;

  const ProfileHeader({
    super.key,
    required this.isPro,
    required this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'D',
                style: AppTypography.displayMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dawamy User',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isPro
                            ? const Color(0xFF00B894).withOpacity(0.1)
                            : theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isPro ? 'Pro' : 'Free Plan',
                        style: AppTypography.labelSmall.copyWith(
                          color: isPro
                              ? const Color(0xFF00B894)
                              : theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (!isPro) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onUpgrade,
                        child: Text(
                          'Upgrade',
                          style: AppTypography.labelSmall.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
