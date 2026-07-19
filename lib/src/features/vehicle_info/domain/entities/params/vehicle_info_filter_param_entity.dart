import 'package:eks_sana_plus_org/src/features/vehicle_info/data/models/vehicle_info_filter_request_model.dart';

class VehicleInfoFilterParamEntity {
  const VehicleInfoFilterParamEntity({
    this.vehicleModelId,
    this.isDepotEnabled,
    this.tashimType,
    this.chassisNumber,
    this.engineNumber,
    this.imeiSerial,
    this.licensePlate,
    this.isTroubleShooter,
    this.isActive,
    this.skip = 0,
    this.pageSize = 10,
  });

  final int? vehicleModelId;
  final bool? isDepotEnabled;
  final int? tashimType;
  final String? chassisNumber;
  final String? engineNumber;
  final String? imeiSerial;
  final String? licensePlate;
  final bool? isTroubleShooter;
  final bool? isActive;
  final int skip;
  final int pageSize;

  VehicleInfoFilterRequestModel toModel() {
    final filters = <VehicleInfoFilterModel>[];

    void addText(String field, String? value) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) {
        filters.add(VehicleInfoFilterModel(field: field, value: trimmed));
      }
    }

    if (vehicleModelId != null && vehicleModelId! > 0) {
      filters.add(VehicleInfoFilterModel(
        field: 'vehicleModelId',
        value: vehicleModelId.toString(),
        operator: 'eq',
      ));
    }
    if (isDepotEnabled != null) {
      filters.add(VehicleInfoFilterModel(
        field: 'isDepotEnabled',
        value: isDepotEnabled.toString(),
        operator: 'eq',
      ));
    }
    if (tashimType != null && tashimType! > 0) {
      filters.add(VehicleInfoFilterModel(
        field: 'tashimType',
        value: tashimType.toString(),
        operator: 'eq',
      ));
    }
    if (isTroubleShooter != null) {
      filters.add(VehicleInfoFilterModel(
        field: 'isTroubleShooter',
        value: isTroubleShooter.toString(),
        operator: 'eq',
      ));
    }
    if (isActive != null) {
      filters.add(VehicleInfoFilterModel(
        field: 'isActive',
        value: isActive.toString(),
        operator: 'eq',
      ));
    }

    addText('chassisNumber', chassisNumber);
    addText('engineNumber', engineNumber);
    addText('imeiSerial', imeiSerial);
    addText('licensePlate', licensePlate);

    return VehicleInfoFilterRequestModel(
      skip: skip,
      pageSize: pageSize,
      filters: filters,
    );
  }

  VehicleInfoFilterParamEntity copyWith({
    int? vehicleModelId,
    bool clearVehicleModelId = false,
    bool? isDepotEnabled,
    bool clearIsDepotEnabled = false,
    int? tashimType,
    bool clearTashimType = false,
    String? chassisNumber,
    String? engineNumber,
    String? imeiSerial,
    String? licensePlate,
    bool? isTroubleShooter,
    bool clearIsTroubleShooter = false,
    bool? isActive,
    bool clearIsActive = false,
    int? skip,
    int? pageSize,
  }) {
    return VehicleInfoFilterParamEntity(
      vehicleModelId: clearVehicleModelId ? null : vehicleModelId ?? this.vehicleModelId,
      isDepotEnabled: clearIsDepotEnabled ? null : isDepotEnabled ?? this.isDepotEnabled,
      tashimType: clearTashimType ? null : tashimType ?? this.tashimType,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      engineNumber: engineNumber ?? this.engineNumber,
      imeiSerial: imeiSerial ?? this.imeiSerial,
      licensePlate: licensePlate ?? this.licensePlate,
      isTroubleShooter: clearIsTroubleShooter ? null : isTroubleShooter ?? this.isTroubleShooter,
      isActive: clearIsActive ? null : isActive ?? this.isActive,
      skip: skip ?? this.skip,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
