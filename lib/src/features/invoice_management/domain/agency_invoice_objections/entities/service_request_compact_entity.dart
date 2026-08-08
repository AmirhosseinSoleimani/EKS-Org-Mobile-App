import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_compact_model.dart';

class ServiceRequestCompactEntity {
  const ServiceRequestCompactEntity({
    this.customer,
    this.vehicle,
    this.assignment,
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
  final ServiceRequestCustomerEntity? customer;
  final ServiceRequestVehicleEntity? vehicle;
  final ServiceRequestAssignmentEntity? assignment;

  ServiceRequestCompactModel toModel() {
    return ServiceRequestCompactModel(
      customer: customer?.toModel(),
      vehicle: vehicle?.toModel(),
      assignment: assignment?.toModel(),
      serviceRequestId: serviceRequestId,
      trackCode: trackCode,
      description: description,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      requestDateTime: requestDateTime,
      requestDateTimeJalali: requestDateTimeJalali,
      requestStatus: requestStatus,
      requestStatusTitle: requestStatusTitle,
      subscription: subscription,
      dispatcher: dispatcher,
      defectId: defectId,
      defectTitle: defectTitle,
      invoiceDocumentGuid: invoiceDocumentGuid,
    );
  }
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

  ServiceRequestCustomerModel toModel() {
    return ServiceRequestCustomerModel(
      firstName: firstName,
      lastName: lastName,
      callMobileNumber: callMobileNumber,
      customerMobileNumber: customerMobileNumber,
      personType: personType,
      nationalNumber: nationalNumber,
      aidAddress: aidAddress,
    );
  }
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

  ServiceRequestVehicleModel toModel() {
    return ServiceRequestVehicleModel(
      agencyVehicleLabelCode: agencyVehicleLabelCode,
      chassisNumber: chassisNumber,
      licensePlate: licensePlate,
      kilometer: kilometer,
      carInfoId: carInfoId,
      carModelId: carModelId,
      carInfoGuid: carInfoGuid,
      carName: carName,
      carEngineNumber: carEngineNumber,
      carGroupTitle: carGroupTitle,
      carFactory: carFactory,
      carFactoryTitle: carFactoryTitle,
      isSaipa: isSaipa,
      carProductionYear: carProductionYear,
      vehicleUsageId: vehicleUsageId,
      vehicleUsageTitle: vehicleUsageTitle,
      wageGroupType: wageGroupType,
      weightGroupTitle: weightGroupTitle,
      isGaranty: isGaranty,
    );
  }
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

  ServiceRequestAssignmentModel toModel() {
    return ServiceRequestAssignmentModel(
      hasEmdadgar: hasEmdadgar,
      planningId: planningId,
      emdadgarId: emdadgarId,
      emdadgarName: emdadgarName,
      emdadgarMobile: emdadgarMobile,
      emdadgarNavganType: emdadgarNavganType,
      emdadgarVehicleType: emdadgarVehicleType,
      agencyName: agencyName,
      agencyCode: agencyCode,
      assignDate: assignDate,
      assignDateTimeJalali: assignDateTimeJalali,
    );
  }
}
