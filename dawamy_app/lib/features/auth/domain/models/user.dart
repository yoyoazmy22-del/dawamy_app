class AppUser {
  final String uid;
  final String? email;
  final String? username;
  final String? photoUrl;
  final String subscriptionPlan;
  final DateTime? lastSyncAt;
  final DateTime createdAt;

  const AppUser({
    required this.uid,
    this.email,
    this.username,
    this.photoUrl,
    this.subscriptionPlan = 'free',
    this.lastSyncAt,
    required this.createdAt,
  });

  bool get isPro => subscriptionPlan == 'pro';

  AppUser copyWith({
    String? uid,
    String? email,
    String? username,
    String? photoUrl,
    String? subscriptionPlan,
    DateTime? lastSyncAt,
    DateTime? createdAt,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      photoUrl: photoUrl ?? this.photoUrl,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'photoUrl': photoUrl,
        'subscriptionPlan': subscriptionPlan,
        'lastSyncAt': lastSyncAt?.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        uid: json['uid'] as String,
        email: json['email'] as String?,
        username: json['username'] as String?,
        photoUrl: json['photoUrl'] as String?,
        subscriptionPlan: json['subscriptionPlan'] as String? ?? 'free',
        lastSyncAt: json['lastSyncAt'] != null
            ? DateTime.parse(json['lastSyncAt'] as String)
            : null,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
