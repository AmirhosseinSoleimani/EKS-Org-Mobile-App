class ServiceRequestCompactEntity {
  const ServiceRequestCompactEntity({
    required this.customer,
    required this.vehicle,
    required this.assignment,
    this.serviceRequestId,
    this.trackCode,
    this.description,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.requestDateTime,
    this.requestDateTimeJalali,
    this.requestStatus,
    this.requestStatusTitle,
    this.subscription,
    this.dispatcher,
    this.defectId,
    this.defectTitle,
    this.invoiceDocumentGuid,
  });

  final int? serviceRequestId;
  final int? trackCode;
  final String? description;
  final DateTime? insertDateTime;
  final String? insertDateTimeJalali;
  final DateTime? requestDateTime;
  final String? requestDateTimeJalali;
  final int? requestStatus;
  final String? requestStatusTitle;
  final bool? subscription;
  final String? dispatcher;
  final int? defectId;
  final String? defectTitle;
  final String? invoiceDocumentGuid;
  final ServiceRequestCustomerEntity customer;
  final ServiceRequestVehicleEntity vehicle;
  final ServiceRequestAssignmentEntity assignment;
}

class ServiceRequestCustomerEntity {
  const ServiceRequestCustomerEntity({
    this.firstName,
    this.lastName,
    this.callMobileNumber,
    this.customerMobileNumber,
    this.personType,
    this.nationalNumber,
    this.aidAddress,
  });

  final String? firstName;
  final String? lastName;
  final String? callMobileNumber;
  final String? customerMobileNumber;
  final int? personType;
  final String? nationalNumber;
  final String? aidAddress;
}

class ServiceRequestVehicleEntity {
  const ServiceRequestVehicleEntity({
    this.agencyVehicleLabelCode,
    this.chassisNumber,
    this.licensePlate,
    this.kilometer,
    this.carInfoId,
    this.carModelId,
    this.carInfoGuid,
    this.carName,
    this.carEngineNumber,
    this.carGroupTitle,
    this.carFactory,
    this.carFactoryTitle,
    this.isSaipa,
    this.carProductionYear,
    this.vehicleUsageId,
    this.vehicleUsageTitle,
    this.wageGroupType,
    this.weightGroupTitle,
    this.isGaranty,
  });

  final String? agencyVehicleLabelCode;
  final String? chassisNumber;
  final String? licensePlate;
  final int? kilometer;
  final int? carInfoId;
  final int? carModelId;
  final String? carInfoGuid;
  final String? carName;
  final String? carEngineNumber;
  final String? carGroupTitle;
  final int? carFactory;
  final String? carFactoryTitle;
  final bool? isSaipa;
  final int? carProductionYear;
  final int? vehicleUsageId;
  final String? vehicleUsageTitle;
  final int? wageGroupType;
  final String? weightGroupTitle;
  final bool? isGaranty;
}

class ServiceRequestAssignmentEntity {
  const ServiceRequestAssignmentEntity({
    this.hasEmdadgar,
    this.planningId,
    this.emdadgarId,
    this.emdadgarName,
    this.emdadgarMobile,
    this.emdadgarNavganType,
    this.emdadgarVehicleType,
    this.agencyName,
    this.agencyCode,
    this.assignDate,
    this.assignDateTimeJalali,
  });

  final bool? hasEmdadgar;
  final int? planningId;
  final int? emdadgarId;
  final String? emdadgarName;
  final String? emdadgarMobile;
  final String? emdadgarNavganType;
  final String? emdadgarVehicleType;
  final String? agencyName;
  final String? agencyCode;
  final DateTime? assignDate;
  final String? assignDateTimeJalali;
}
