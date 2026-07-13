class LookupEntity {
  const LookupEntity({
    required this.id,
    required this.title,
    this.latitude,
    this.longitude,
    this.address,
    this.extra,
  });

  final int id;
  final String title;
  final double? latitude;
  final double? longitude;
  final String? address;
  final Map<String, dynamic>? extra;
}
