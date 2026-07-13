class ChangeEmdadUnitLocationParamEntity {
  const ChangeEmdadUnitLocationParamEntity({
    required this.emdadUnitId,
    required this.agencyPersonId,
    required this.agencyVehicleId,
    required this.locationId,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final int emdadUnitId;
  final int agencyPersonId;
  final int agencyVehicleId;
  final int locationId;
  final double latitude;
  final double longitude;
  final String address;

  Map<String, dynamic> toJson() {
    return {
      'emdadUnitId': emdadUnitId,
      'agencyPersonId': agencyPersonId,
      'agencyVehicleId': agencyVehicleId,
      'locationId': locationId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}
