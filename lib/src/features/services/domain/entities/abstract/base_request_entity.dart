import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';

abstract class BaseRequestEntity {
  final ServiceType? serviceType;
  final int? id;
  final int? trackCode;
  final String? firstName;
  final String? lastName;
  final String? chassisNumber;
  final int? kilometer;
  final String? nationalCode;
  final double? latitude;
  final double? longitude;
  final String? aidAddress;
  final int? cityId;
  final String? cityName;
  final int? provinceId;
  final String? provinceName;
  final String? carName;
  final int? carProductionYear;
  final String? licensePlate;
  final int? requestStatus;
  final String? requestStatusTitle;
  final String? requestDateJalali;
  final String? requestTime;
  final String? customerMobileNumber;
  final String? description;
  final String? carColorTitle;
  final String? carEngineNumber;
  final String? genderTitle;
  final String? personTypeTitle;
  final String? dispatcher;
  final bool? isGuaranty;
  final bool? isSubscription;
  final String? agencyVehicleLabelCode;
  final String? callMobileNumber;
  final int? personType;
  final int? carInfoId;
  final int? carModelId;
  final String? carInfoGuid;
  final String? carGroupTitle;
  final int? carFactory;
  final String? carFactoryTitle;
  final bool? isSaipa;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final int? vehicleUsageId;
  final String? vehicleUsageTitle;
  final int? wageGroupType;
  final String? weightGroupTitle;
  final bool? hasEmdadgar;
  final int? planningId;
  final int? emdadgarId;
  final String? agencyName;
  final String? agencyCode;
  final String? assignDate;
  final String? assignDateTimeJalali;
  final String? garantyStartDate;
  final String? garantyEndDate;
  final String? garantyReceptionDate;
  final String? garantyLastKilometer;
  final int? garantyStatusCode;
  final bool? garantyIsGaranty;
  final String? garantyDescription;
  final int? garantyCarTipId;
  final String? garantySiteDescription;
  final String? invoiceDocumentGuid;
  final String? requestDateTime;
  final String? requestDateTimeJalali;
  final String? emFullName;
  final String? emMobileNumber1;
  final String? emVehicleTypeTitle;
  final int? emVehicleType;
  final String? emVehicleSubTypeTitle;
  final int? emVehicleSubType;
  final String? emRepresentationName;
  final String? emRepresentationCode;

  bool get isHomeService => serviceType == ServiceType.homeService;

  const BaseRequestEntity({
    this.serviceType,
    this.id,
    this.trackCode,
    this.firstName,
    this.lastName,
    this.chassisNumber,
    this.kilometer,
    this.nationalCode,
    this.latitude,
    this.longitude,
    this.aidAddress,
    this.cityId,
    this.cityName,
    this.provinceId,
    this.provinceName,
    this.carName,
    this.carProductionYear,
    this.licensePlate,
    this.requestStatus,
    this.requestStatusTitle,
    this.requestDateJalali,
    this.requestTime,
    this.customerMobileNumber,
    this.description,
    this.carColorTitle,
    this.carEngineNumber,
    this.genderTitle,
    this.personTypeTitle,
    this.dispatcher,
    this.isGuaranty,
    this.isSubscription,
    this.agencyVehicleLabelCode,
    this.callMobileNumber,
    this.personType,
    this.carInfoId,
    this.carModelId,
    this.carInfoGuid,
    this.carGroupTitle,
    this.carFactory,
    this.carFactoryTitle,
    this.isSaipa,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.vehicleUsageId,
    this.vehicleUsageTitle,
    this.wageGroupType,
    this.weightGroupTitle,
    this.hasEmdadgar,
    this.planningId,
    this.emdadgarId,
    this.agencyName,
    this.agencyCode,
    this.assignDate,
    this.assignDateTimeJalali,
    this.garantyStartDate,
    this.garantyEndDate,
    this.garantyReceptionDate,
    this.garantyLastKilometer,
    this.garantyStatusCode,
    this.garantyIsGaranty,
    this.garantyDescription,
    this.garantyCarTipId,
    this.garantySiteDescription,
    this.invoiceDocumentGuid,
    this.requestDateTime,
    this.requestDateTimeJalali,
    this.emFullName,
    this.emMobileNumber1,
    this.emVehicleTypeTitle,
    this.emVehicleType,
    this.emVehicleSubTypeTitle,
    this.emVehicleSubType,
    this.emRepresentationName,
    this.emRepresentationCode,
  });
}
