class PlanLookupEntity {
  final int? id;
  final int? value;
  final String? title;
  final String? name;
  final double? latitude;
  final double? longitude;
  final String? address;

  const PlanLookupEntity({
    this.id,
    this.value,
    this.title,
    this.name,
    this.latitude,
    this.longitude,
    this.address,
  });

  int? get resolvedId => id ?? value;

  String get displayTitle {
    final normalizedTitle = title?.trim();
    if (normalizedTitle != null && normalizedTitle.isNotEmpty) {
      return normalizedTitle;
    }

    final normalizedName = name?.trim();
    if (normalizedName != null && normalizedName.isNotEmpty) {
      return normalizedName;
    }

    return '---';
  }
}
