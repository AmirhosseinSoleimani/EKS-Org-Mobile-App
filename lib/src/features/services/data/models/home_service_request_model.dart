import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';

class HomeServiceRequestListModel extends HomeServiceRequestListEntity {
  HomeServiceRequestListModel({
    required super.items,
    required super.totalCount,
  });

  factory HomeServiceRequestListModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceRequestListModel(
      items: (json['records'] as List<dynamic>?)
              ?.map(
                (e) => HomeServiceRequestModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          <HomeServiceRequestEntity>[],
      totalCount: json['count'] ?? 0,
    );
  }
}

class HomeServiceRequestModel extends HomeServiceRequestEntity {
  const HomeServiceRequestModel({
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
    super.requestDay,
    super.bookedDateTimeJalali,
    super.emdadServiceCategoryTitle,
    super.emdadgarName,
    super.agencyName,
    super.agencyCode,
    super.customerMobileNumber,
    super.description,
    super.carColorTitle,
    super.carEngineNumber,
    super.genderTitle,
    super.personTypeTitle,
    super.chassisNumber,
    super.kilometer,
    super.nationalCode,
    super.dispatcher,
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
    super.requestDateTime,
    super.requestDayTime,
    super.vip,
    super.vipConditionTitle,
    super.emdadProductTitle,
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
  });
  factory HomeServiceRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const HomeServiceRequestModel();

    return HomeServiceRequestModel(
      id: json['serviceRequestId'] ?? json['id'],
      trackCode: json['trackCode'],
      firstName: json['firstName'],
      lastName: json['lastName'],

      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,

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
      requestDay: json['requestDay'],

      bookedDateTimeJalali: json['bookedDateTimeJalali'],

      emdadServiceCategoryTitle: json['emdadServiceCategoryTitle'],
      emdadgarName: json['emdadgarName'],

      agencyName: json['agencyName'],
      agencyCode: json['agencyCode'],

      customerMobileNumber: json['customerMobileNumber'],
      description: json['description'],

      carColorTitle: json['carColorTitle'],
      carEngineNumber: json['carEngineNumber'],

      genderTitle: json['genderTitle'],
      personTypeTitle: json['personTypeTitle'],

      chassisNumber: json['chassisNumber'],
      kilometer: json['kilometer'],
      nationalCode: json['nationalNumber'],

      dispatcher: json['dispatcher'],

      emFullName: json['emdadgarName'] ?? json['emFullName'],
      emMobileNumber1: json['emdadgarMobile'] ?? json['emMobileNumber1'],
      emVehicleTypeTitle:
          json['emdadgarNavganType'] ?? json['emVehicleTypeTitle'],
      emVehicleType: json['emVehicleType'],
      emVehicleSubTypeTitle:
          json['emdadgarKhodroType'] ?? json['emVehicleSubTypeTitle'],
      emVehicleSubType: json['emVehicleSubType'],
      emRepresentationName:  json['emRepresentationName'],
      emRepresentationCode: json['emRepresentationCode'],
      distanceToCustomer: (json['distanceToCustomer'] as num?)?.toDouble(),
      emdadgarPriority: (json['emdadgarPriority'] as num?)?.toInt(),
      emdadgarEvaluationDescription: json['emdadgarEvaluationDescription'],
      emdadgarEvaluationKilometer:
          (json['emdadgarEvaluationKilometer'] as num?)?.toInt(),
      isNewCar: json['isNewCar'] ?? false,
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

      isGuaranty: json['isGuaranty'] ??
          json['isGaranty'] ??
          json['garanty_IsGaranty'],
      isSubscription: json['subscription'] ?? json['isSubscription'],

      requestDateTime: json['requestDateTime'],
      requestDayTime: json['requestDayTime'],

      vip: json['vip'] ?? false,
      vipConditionTitle: json['vipConditionTitle'],
      emdadProductTitle: json['emdadProductTitle'] ?? _extractSelectedServiceTitle(json),

      // ===== NEW BASE FIELDS =====

      agencyVehicleLabelCode: json['agencyVehicleLabelCode'],
      callMobileNumber: json['callMobileNumber'],
      personType: json['personType'],

      carInfoId: json['carInfoId'],
      carModelId: json['carModelId'],
      carInfoGuid: json['carGuid'],

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
      assignDateTimeJalali: json['assignDateTimeJalali'],

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
      cancelReasonId: json['cancelReasonId'],
      addressHasBeenSet: json['addressHasBeenSet'],

      requestDateTimeJalali: json['requestDateTimeJalali'],

      serviceType: ServiceType.homeService,
    );
  }
  static String? _extractSelectedServiceTitle(Map<String, dynamic> json) {
    final rawCategories = json['serviceCategories'] ?? json['services'];
    if (rawCategories is! List) {
      return json['emdadServiceCategoryTitle']?.toString();
    }

    final categoryTexts = <String>[];

    for (final rawCategory in rawCategories) {
      if (rawCategory is! Map) continue;
      final category = Map<String, dynamic>.from(rawCategory);
      final categoryTitle = category['serviceCategoryTitle']?.toString().trim();
      final rawServices = category['services'] ?? category['packageServices'];

      final serviceTitles = <String>[];
      if (rawServices is List) {
        for (final rawService in rawServices) {
          if (rawService is! Map) continue;
          final title = rawService['serviceTitle']?.toString().trim();
          if (title != null && title.isNotEmpty) {
            serviceTitles.add(title);
          }
        }
      }

      if (serviceTitles.isNotEmpty) {
        categoryTexts.add(
          categoryTitle != null && categoryTitle.isNotEmpty
              ? '$categoryTitle: ${serviceTitles.join('، ')}'
              : serviceTitles.join('، '),
        );
      } else if (categoryTitle != null && categoryTitle.isNotEmpty) {
        categoryTexts.add(categoryTitle);
      }
    }

    if (categoryTexts.isNotEmpty) {
      return categoryTexts.join(' | ');
    }

    return json['emdadServiceCategoryTitle']?.toString();
  }

}
