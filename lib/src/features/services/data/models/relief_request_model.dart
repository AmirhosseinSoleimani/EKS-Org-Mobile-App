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
    super.emdadgarPriority,
    super.emdadgarEvaluationDescription,
    super.emdadgarEvaluationKilometer,
    super.isNewCar,
    super.vip,
    super.vipConditionTitle,
    super.hasTrafficOrPollutionPlan,
    super.hasSpecialPlan,
    super.specialPlanTitle,
    super.specialPlanZoneTitle,
    super.hamlAzad,
    super.reasonHamlAzadId,
    super.reasonHamlAzadTitle,
    super.reasonHamlAzadDesc,
    super.foreigner,
    super.insertUserName,
    super.updateUserName,
    super.cancelReasonTitle,
    super.cancelReasonDetailTitle,
    super.cancelReasonDescription,
    super.cancelAssignDescription,
    super.nightOrHoliday,
    super.nightOrHolidayDescription,
    super.customerDisability,
    super.customerDisabilityDesc,
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
    super.distanceHamlCustomer,
    super.emdadServiceCategoryGivenTitle,
    super.emdadServiceGivenTitle,
    super.emdadgarEvaluationDefectTitle,
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
    super.hasDocuments,
    super.requestState,
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
      emdadgarPriority: (json['emdadgarPriority'] as num?)?.toInt(),
      emdadgarEvaluationDescription: json['emdadgarEvaluationDescription'],
      emdadgarEvaluationKilometer:
      _toInt(json['emdadgarEvaluationKilometer']),
      isNewCar: json['isNewCar'] ?? false,
      vip: json['vip'] ?? false,
      vipConditionTitle: json['vipConditionTitle'],
      hasTrafficOrPollutionPlan: json['hasTrafficOrPollutionPlan'] ?? false,
      hasSpecialPlan: json['hasSpecialPlan'] ?? false,
      specialPlanTitle: json['specialPlanTitle'],
      specialPlanZoneTitle: json['specialPlanZoneTitle'],
      hamlAzad: json['hamlAzad'] ?? false,
      reasonHamlAzadId: json['reasonHamlAzadId'],
      reasonHamlAzadTitle: json['reasonHamlAzadTitle'],
      reasonHamlAzadDesc: json['reasonHamlAzadDesc'],
      foreigner: json['foreigner'],
      insertUserName: json['insertUserName'],
      updateUserName: json['updateUserName'],
      cancelReasonTitle: json['cancelReasonTitle'],
      cancelReasonDetailTitle: json['cancelReasonDetailTitle'],
      cancelReasonDescription: json['cancelReasonDescription'],
      cancelAssignDescription: json['cancelAssignDescription'],
      nightOrHoliday: json['nightOrHoliday'] ?? false,
      nightOrHolidayDescription: json['nightOrHolidayDescription'],
      customerDisability: (json['customerDisability'] as num?)?.toInt(),
      customerDisabilityDesc: json['customerDisabilityDesc'],

      agencyVehicleLabelCode: json['agencyVehicleLabelCode'],

      callMobileNumber: json['callMobileNumber'],
      personType: json['personType'],

      carInfoId: json['carInfoId'],
      carModelId: json['carModelId'],
      carInfoGuid: json['carInfoGuid'] ?? json['carGuid'],

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
      garantyStartDate: json['garanty_StartDate'] ?? json['garantyStartDate'],
      garantyEndDate: json['garanty_EndDate'] ?? json['garantyEndDate'],
      garantyReceptionDate: json['garanty_ReceptionDate'] ?? json['garantyReceptionDate'],
      garantyLastKilometer: json['garanty_LastKilometer'] ?? json['garantyLastKilometer'],
      garantyStatusCode: json['garanty_StatusCode'] ?? json['garantyStatusCode'],
      garantyIsGaranty: json['garanty_IsGaranty'] ?? json['isGaranty'],
      garantyDescription: json['garanty_Description'] ?? json['garantyDescription'],
      garantyCarTipId: json['garanty_CarTipId'] ?? json['garantyCarTipId'],
      garantySiteDescription: json['garanty_SiteDescription'] ?? json['garantySiteDescription'],

      invoiceDocumentGuid: json['invoiceDocumentGuid'],
      hasDocuments: json['hasDocuments'] == true ||
          json['hasDocuments'] == 1 ||
          json['hasDocuments']?.toString().toLowerCase() == 'true',
      requestState: (json['requestState'] as num?)?.toInt(),
      cancelReasonId: json['cancelReasonId'],
      addressHasBeenSet: json['addressHasBeenSet'],
      requestDateTimeJalali: json['requestDateTimeJalali'],

      defectId: json['defectId'],
      defectTitle: _firstNonBlank([json['defectTitle'], json['defectInfoTitle']]),
      isUrgentRequest: json['isUrgentRequest'] ?? false,
      isUrgentRequestCompleted: json['isUrgentRequestCompleted'] ?? false,
      emdadServiceTitle: _firstNonBlank([json['emdadServiceTitle'], json['serviceTitle']]),
      hamlReasonTitle: json['hamlReasonTitle'],
      wheelQuestionTitle: json['wheelQuestionTitle'],

      emdadgarAssignDistanceTitle: json['emdadgarAssignDistanceTitle'],
      emdadgarAssignDurationTitle: json['emdadgarAssignDurationTitle'],
      distanceHamlCustomer: (json['distanceHamlCustomer'] as num?)?.toDouble(),
      emdadServiceCategoryGivenTitle: json['emdadServiceCategoryGivenTitle'],
      emdadServiceGivenTitle: json['emdadServiceGivenTitle'],
      emdadgarEvaluationDefectTitle: json['emdadgarEvaluationDefectTitle'],

      assignTime: json['assignTime'],
      agencyCode: json['agencyCode'],
      agencyName: json['agencyName'],
      requestDateTime: json['requestDateTime'],
      emdadServiceCategoryId: json['emdadServiceCategoryId'],
      emdadServiceId: json['emdadServiceId'],

      serviceType: ServiceType.reliefService,
    );

  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;

    if (value is int) return value;

    if (value is num) {
      return value.toInt();
    }

    if (value is String) {
      return int.tryParse(value);
    }

    return null;
  }

  static String? _firstNonBlank(Iterable<dynamic> values) {
    for (final value in values) {
      final text = value?.toString().trim();
      if (text != null && text.isNotEmpty && text.toLowerCase() != 'null') {
        return text;
      }
    }
    return null;
  }


}
