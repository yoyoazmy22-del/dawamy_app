class StoreLink {
  final String id;
  final String url;
  final String? name;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StoreLink({
    required this.id,
    required this.url,
    this.name,
    this.isSynced = false,
    required this.createdAt,
    required this.updatedAt,
  });

  StoreLink copyWith({
    String? id,
    String? url,
    String? name,
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreLink(
      id: id ?? this.id,
      url: url ?? this.url,
      name: name ?? this.name,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  factory StoreLink.fromJson(Map<String, dynamic> json) => StoreLink(
        id: json['id'] as String,
        url: json['url'] as String,
        name: json['name'] as String?,
        isSynced: json['isSynced'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'name': name,
        'isSynced': isSynced,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
