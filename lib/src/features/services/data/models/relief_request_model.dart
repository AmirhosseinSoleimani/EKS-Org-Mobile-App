import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';

class ReliefRequestListModel extends ReliefRequestListEntity {
  ReliefRequestListModel({
    required super.items,
    required super.totalCount,
  });

  factory ReliefRequestListModel.fromJson(Map<String, dynamic> json) {
    return ReliefRequestListModel(
      items: (json['records'] as List<dynamic>?)
              ?.map(
                (e) => ReliefRequestModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          <ReliefRequestEntity>[],
      totalCount: json['count'] ?? 0,
    );
  }
}

class ReliefRequestModel extends ReliefRequestEntity {
  const ReliefRequestModel({
    super.id,
    super.trackCode,
    super.firstName,
    super.lastName,
    super.latitude,
    super.longitude,
    super.aidAddress,
    super.cityId,
    super.cityName,
    super.provinceId,
    super.provinceName,
    super.carName,
    super.carProductionYear,
    super.licensePlate,
    super.requestStatus,
    super.requestStatusTitle,
    super.requestDateJalali,
    super.requestTime,
    super.customerMobileNumber,
    super.description,
    super.carColorTitle,
    super.carEngineNumber,
    super.genderTitle,
    super.personTypeTitle,
    super.chassisNumber,
    super.kilometer,
    super.nationalCode,
    super.emFullName,
    super.emMobileNumber1,
    super.emVehicleTypeTitle,
    super.emVehicleType,
    super.emVehicleSubTypeTitle,
    super.emVehicleSubType,
    super.emRepresentationName,
    super.emRepresentationCode,
    super.distanceToCustomer,
    super.isGuaranty,
    super.isSubscription,
    super.dispatcher,
    super.defectId,
    super.defectTitle,
    super.isUrgentRequest,
    super.isUrgentRequestCompleted,
    super.emdadServiceTitle,
    super.hamlReasonTitle,
    super.wheelQuestionTitle,
    super.emdadgarAssignDistanceTitle,
    super.emdadgarAssignDurationTitle,
    super.assignDate,
    super.assignTime,
    super.serviceType,
    super.agencyVehicleLabelCode,
    super.assignDateTimeJalali,
    super.callMobileNumber,
    super.carFactory,
    super.carFactoryTitle,
    super.carGroupTitle,
    super.carInfoGuid,
    super.carInfoId,
    super.carModelId,
    super.emdadgarId,
    super.garantyCarTipId,
    super.garantyDescription,
    super.garantyEndDate,
    super.garantyIsGaranty,
    super.garantyLastKilometer,
    super.garantyReceptionDate,
    super.garantySiteDescription,
    super.garantyStartDate,
    super.garantyStatusCode,
    super.hasEmdadgar,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.invoiceDocumentGuid,
    super.cancelReasonId,
    super.addressHasBeenSet,
    super.isSaipa,
    super.personType,
    super.planningId,
    super.requestDateTimeJalali,
    super.vehicleUsageId,
    super.vehicleUsageTitle,
    super.wageGroupType,
    super.weightGroupTitle,
    super.agencyCode,
    super.agencyName,
    super.requestDateTime,
    super.emdadServiceCategoryId,
    super.emdadServiceId,
  });
  factory ReliefRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ReliefRequestModel();

    return ReliefRequestModel(
      // Base fields
      id: json['serviceRequestId'] ?? json['id'],
      trackCode: json['trackCode'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      chassisNumber: json['chassisNumber'],
      kilometer: json['kilometer'],
      nationalCode: json['nationalNumber'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      aidAddress: json['aidAddress'],
      cityId: json['cityId'],
      cityName: json['cityName'],
      provinceId: json['provinceId'],
      provinceName: json['provinceName'],

      carName: json['carName'],
      carProductionYear: json['carProductionYear'],
      licensePlate: json['licensePlate'],

      requestStatus: json['requestStatus'],
      requestStatusTitle: json['requestStatusTitle'],

      requestDateJalali: json['requestDateJalali'],
      requestTime: json['requestTime'],

      customerMobileNumber: json['customerMobileNumber'],
      description: json['description'],
      carColorTitle: json['carColorTitle'],
      carEngineNumber: json['carEngineNumber'],
      genderTitle: json['genderTitle'],
      personTypeTitle: json['personTypeTitle'],

      dispatcher: json['dispatcher'],

      isGuaranty: json['isGuaranty'] ??
          json['isGaranty'] ??
          json['garanty_IsGaranty'],
      isSubscription: json['subscription'] ?? json['isSubscription'] ?? false,

      emFullName: json['emdadgarName'] ?? json['emFullName'],
      emMobileNumber1: json['emdadgarMobile'] ?? json['emMobileNumber1'],
      emVehicleTypeTitle: json['emdadgarNavganType'] ?? json['emVehicleTypeTitle'],
      emVehicleType: json['emVehicleType'],
      emVehicleSubTypeTitle: json['emdadgarKhodroType'] ?? json['emVehicleSubTypeTitle'],
      emVehicleSubType: json['emVehicleSubType'],
      emRepresentationName: json['emRepresentationName'],
      emRepresentationCode:  json['emRepresentationCode'],
      distanceToCustomer: (json['distanceToCustomer'] as num?)?.toDouble(),

      agencyVehicleLabelCode: json['agencyVehicleLabelCode'],

      callMobileNumber: json['callMobileNumber'],
      personType: json['personType'],

      carInfoId: json['carInfoId'],
      carModelId: json['carModelId'],
      carInfoGuid: json['carInfoGuid'],

      carGroupTitle: json['carGroupTitle'],
      carFactory: json['carFactory'],
      carFactoryTitle: json['carFactoryTitle'],
      isSaipa: json['isSaipa'],

      insertDateTime: json['insertDateTime'],
      insertDateTimeJalali: json['insertDateTimeJalali'],

      vehicleUsageId: json['vehicleUsageId'],
      vehicleUsageTitle: json['vehicleUsageTitle'],

      wageGroupType: json['wageGroupType'],
      weightGroupTitle: json['weightGroupTitle'],

      hasEmdadgar: json['hasEmdadgar'],
      planningId: json['planningId'],
      emdadgarId: json['emdadgarId'],

      assignDate: json['assignDate'],
      assignDateTimeJalali: json['assignDateTimeJalali'],

      // Garanty Fields
      garantyStartDate: json['garanty_StartDate'],
      garantyEndDate: json['garanty_EndDate'],
      garantyReceptionDate: json['garanty_ReceptionDate'],
      garantyLastKilometer: json['garanty_LastKilometer'],
      garantyStatusCode: json['garanty_StatusCode'],
      garantyIsGaranty: json['garanty_IsGaranty'],
      garantyDescription: json['garanty_Description'],
      garantyCarTipId: json['garanty_CarTipId'],
      garantySiteDescription: json['garanty_SiteDescription'],

      invoiceDocumentGuid: json['invoiceDocumentGuid'],
      cancelReasonId: json['cancelReasonId'],
      addressHasBeenSet: json['addressHasBeenSet'],
      requestDateTimeJalali: json['requestDateTimeJalali'],

      defectId: json['defectId'],
      defectTitle: json['defectTitle'],
      isUrgentRequest: json['isUrgentRequest'] ?? false,
      isUrgentRequestCompleted: json['isUrgentRequestCompleted'] ?? false,
      emdadServiceTitle: json['emdadServiceTitle'],
      hamlReasonTitle: json['hamlReasonTitle'],
      wheelQuestionTitle: json['wheelQuestionTitle'],

      emdadgarAssignDistanceTitle: json['emdadgarAssignDistanceTitle'],
      emdadgarAssignDurationTitle: json['emdadgarAssignDurationTitle'],

      assignTime: json['assignTime'],
      agencyCode: json['agencyCode'],
      agencyName: json['agencyName'],
      requestDateTime: json['requestDateTime'],
      emdadServiceCategoryId: json['emdadServiceCategoryId'],
      emdadServiceId: json['emdadServiceId'],

      serviceType: ServiceType.reliefService,
    );
  }

}
