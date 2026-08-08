class EmdadgarAssignmentEntity {
  const EmdadgarAssignmentEntity({
    this.id,
    this.startDateText,
    this.endDateText,
    this.shiftTypeText,
    this.shiftTypeId,
    this.planningId,
    this.shiftId,
    this.planId,
    this.planName,
    this.shiftName,
    this.agency,
    this.vehicle,
    this.contact,
    this.location,
    this.status,
    this.statusName,
    this.statusTitle,
    this.isDeleted,
    this.isActive,
    this.avlIsOnline,
    this.inShift,
    this.inVacation,
    this.shiftIsOffline,
    this.isDepotEnabled,
    this.isHomeService,
    this.isEmdadService,
    this.emdadgarCount,
    this.distanceKmToOrigin,
    this.emdadServiceId,
  });

  final int? id;
  final String? startDateText;
  final String? endDateText;
  final String? shiftTypeText;
  final int? shiftTypeId;
  final int? planningId;
  final int? shiftId;
  final int? planId;
  final String? planName;
  final String? shiftName;
  final EmdadgarAgencyEntity? agency;
  final EmdadgarVehicleEntity? vehicle;
  final EmdadgarContactEntity? contact;
  final EmdadgarLocationEntity? location;
  final int? status;
  final String? statusName;
  final String? statusTitle;
  final bool? isDeleted;
  final bool? isActive;
  final bool? avlIsOnline;
  final bool? inShift;
  final bool? inVacation;
  final bool? shiftIsOffline;
  final bool? isDepotEnabled;
  final bool? isHomeService;
  final bool? isEmdadService;
  final int? emdadgarCount;
  final double? distanceKmToOrigin;
  final int? emdadServiceId;
}

class EmdadgarAgencyEntity {
  const EmdadgarAgencyEntity({
    this.code,
    this.name,
    this.labelCode,
    this.provinceName,
    this.provinceCode,
    this.cityName,
    this.cityCode,
  });

  final String? code;
  final String? name;
  final String? labelCode;
  final String? provinceName;
  final String? provinceCode;
  final String? cityName;
  final String? cityCode;
}

class EmdadgarVehicleEntity {
  const EmdadgarVehicleEntity({
    this.agencyVehicleId,
    this.imei,
    this.plate,
    this.vehicleType,
    this.vehicleTypeId,
    this.navganType,
    this.navganTypeCode,
  });

  final int? agencyVehicleId;
  final String? imei;
  final String? plate;
  final String? vehicleType;
  final int? vehicleTypeId;
  final String? navganType;
  final int? navganTypeCode;
}

class EmdadgarContactEntity {
  const EmdadgarContactEntity({
    this.irancellMobile,
    this.mobile,
    this.nationalCode,
  });

  final String? irancellMobile;
  final String? mobile;
  final String? nationalCode;
}

class EmdadgarLocationEntity {
  const EmdadgarLocationEntity({
    this.lastLatitude,
    this.lastLongitude,
    this.latitude,
    this.longitude,
    this.locationId,
    this.locationCode,
    this.locationName,
  });

  final double? lastLatitude;
  final double? lastLongitude;
  final double? latitude;
  final double? longitude;
  final int? locationId;
  final String? locationCode;
  final String? locationName;
}
