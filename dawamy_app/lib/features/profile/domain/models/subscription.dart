enum SubscriptionTier { free, pro }

class Subscription {
  final SubscriptionTier tier;
  final bool isActive;
  final DateTime? startDate;
  final DateTime? expiryDate;
  final String? platform;
  final String? productId;

  const Subscription({
    required this.tier,
    this.isActive = false,
    this.startDate,
    this.expiryDate,
    this.platform,
    this.productId,
  });

  bool get isPro => tier == SubscriptionTier.pro && isActive;

  static const free = Subscription(
    tier: SubscriptionTier.free,
    isActive: true,
  );

  Map<String, dynamic> toJson() => {
        'tier': tier.name,
        'isActive': isActive,
        'startDate': startDate?.toIso8601String(),
        'expiryDate': expiryDate?.toIso8601String(),
        'platform': platform,
        'productId': productId,
      };

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        tier: SubscriptionTier.values.firstWhere(
          (e) => e.name == json['tier'],
          orElse: () => SubscriptionTier.free,
        ),
        isActive: json['isActive'] as bool? ?? false,
        startDate: json['startDate'] != null
            ? DateTime.parse(json['startDate'] as String)
            : null,
        expiryDate: json['expiryDate'] != null
            ? DateTime.parse(json['expiryDate'] as String)
            : null,
        platform: json['platform'] as String?,
        productId: json['productId'] as String?,
      );
}

class PremiumFeatures {
  static const List<String> freeFeatures = [
    'Monthly calendar view',
    'Basic shift scheduling',
    'Local storage',
    'Store link saving',
    'Basic profile',
  ];

  static const List<String> proFeatures = [
    'Everything in Free',
    'Cloud sync across devices',
    'Backup & restore',
    'Shift analytics',
    'Priority support',
    'Advanced statistics',
    'Multi-device access',
    'Data export',
  ];
}
