import 'package:flutter/material.dart';
import '../../domain/models/subscription.dart';
import '../../../../core/theme/typography.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final VoidCallback onUpgrade;

  const SubscriptionCard({
    super.key,
    required this.subscription,
    required this.onUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPro = subscription.isPro;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isPro
            ? LinearGradient(
                colors: [
                  const Color(0xFF6C5CE7),
                  const Color(0xFFA29BFE).withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  theme.cardColor,
                  theme.cardColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(16),
        border: isPro
            ? null
            : Border.all(color: theme.dividerColor.withOpacity(0.5)),
        boxShadow: isPro
            ? [
                BoxShadow(
                  color: const Color(0xFF6C5CE7).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isPro ? Icons.star_rounded : Icons.person_outline,
                    color: isPro ? Colors.white : theme.colorScheme.onSurface,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isPro ? 'Pro Plan' : 'Free Plan',
                    style: AppTypography.titleSmall.copyWith(
                      color: isPro ? Colors.white : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (!isPro)
                GestureDetector(
                  onTap: onUpgrade,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Upgrade',
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          ...(isPro ? PremiumFeatures.proFeatures : PremiumFeatures.freeFeatures)
              .take(3)
              .map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: isPro ? Colors.white70 : const Color(0xFF00B894),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          feature,
                          style: AppTypography.bodySmall.copyWith(
                            color: isPro
                                ? Colors.white70
                                : theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }
}
