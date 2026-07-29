class DeploymentLocationFormRequestModel {
  const DeploymentLocationFormRequestModel({
    this.id,
    required this.title,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.cityId,
    required this.isActive,
  });

  final int? id;
  final String title;
  final String address;
  final double latitude;
  final double longitude;
  final int cityId;
  final bool isActive;

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'cityId': cityId,
      'isActive': isActive,
    };
  }
}
