class CreateEmdadUnitParamEntity {
  const CreateEmdadUnitParamEntity({
    this.parentId,
    required this.grade,
    required this.name,
    required this.agencyInfoId,
    required this.agencyPersonId,
    required this.agencyVehicleId,
    this.seatType,
    required this.score,
    this.imageBase64,
    required this.latitude,
    required this.longitude,
    required this.locationId,
    required this.address,
    required this.isActive,
  });

  final int? parentId;
  final int grade;
  final String name;
  final int agencyInfoId;
  final int agencyPersonId;
  final int agencyVehicleId;
  final int? seatType;
  final int score;
  final String? imageBase64;
  final double latitude;
  final double longitude;
  final int locationId;
  final String address;
  final bool isActive;

  Map<String, dynamic> toJson() {
    return {
      'parentId': parentId,
      'type': 1,
      'grade': grade,
      'name': name,
      'agencyInfoId': agencyInfoId,
      'agencyPersonId': agencyPersonId,
      'agencyVehicleId': agencyVehicleId,
      if (seatType != null) 'seatType': seatType,
      'score': score,
      'imageBase64': imageBase64 ?? '',
      'latitude': latitude,
      'longitude': longitude,
      'locationId': locationId,
      'address': address,
      'isActive': isActive,
    };
  }
}
