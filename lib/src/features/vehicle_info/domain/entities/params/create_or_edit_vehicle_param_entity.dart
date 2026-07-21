class CreateOrEditVehicleParamEntity {
  const CreateOrEditVehicleParamEntity({
    this.id,
    required this.imeiId,
    required this.licensePlate,
    required this.chassisNumber,
    required this.engineNumber,
    required this.isActive,
    this.productYear,
    required this.vehicleModelId,
    required this.installTypeDate,
    required this.isTroubleShooter,
    this.isDeleted = false,
    required this.isDepotEnabled,
    this.tashimType,
  });

  final int? id;
  final int imeiId;
  final String licensePlate;
  final String chassisNumber;
  final String engineNumber;
  final bool isActive;
  final String? productYear;
  final int vehicleModelId;
  final String installTypeDate;
  final bool isTroubleShooter;
  final bool isDeleted;
  final bool isDepotEnabled;
  final int? tashimType;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imeiid': imeiId,
      'licensePlate': licensePlate,
      'chassisNumber': chassisNumber.toUpperCase(),
      'engineNumber': engineNumber,
      'isActive': isActive,
      'productYear': productYear,
      'vehicleModelId': vehicleModelId,
      'installTypeDate': installTypeDate,
      'isTroubleShooter': isTroubleShooter,
      'isDeleted': isDeleted,
      'isDepotEnabled': isDepotEnabled,
      'tashimType': tashimType,
    };
  }
}
