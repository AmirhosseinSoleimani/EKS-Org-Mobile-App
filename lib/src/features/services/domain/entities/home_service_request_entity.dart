import 'package:eks_sana_plus_org/src/features/services/data/models/home_service_request_model.dart';

import 'abstract/base_request_entity.dart';


class HomeServiceRequestListEntity {
  final List<HomeServiceRequestEntity> items;
  final int totalCount;

  const HomeServiceRequestListEntity({
    required this.items,
    required this.totalCount,
  });

  HomeServiceRequestListEntity copyWith({
    List<HomeServiceRequestEntity>? items,
    int? totalCount,
  }) {
    return HomeServiceRequestListEntity(
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  HomeServiceRequestListModel toModel() {
    return HomeServiceRequestListModel(
      items: items,
      totalCount: totalCount,
    );
  }
}

class HomeServiceRequestEntity extends BaseRequestEntity {
  final String? requestDay;
  final String? bookedDateTimeJalali;

  final String? emdadServiceCategoryTitle;
  final String? emdadgarName;

  @override
  final String? agencyName;
  @override
  final String? agencyCode;

  @override
  final String? requestDateTime;
  final String? requestDayTime;
  final String? emdadProductTitle;

  const HomeServiceRequestEntity({
    super.id,
    super.trackCode,
    super.firstName,
    super.lastName,
    super.latitude,
    super.longitude,
    super.aidAddress,
    super.cityName,
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
    this.requestDay,
    this.bookedDateTimeJalali,
    this.emdadServiceCategoryTitle,
    this.emdadgarName,
    this.agencyName,
    this.agencyCode,
    this.requestDateTime,
    this.requestDayTime,
    this.emdadProductTitle,
    super.serviceType,
    super.agencyVehicleLabelCode,
    super.assignDate,
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
    super.cityId,
    super.provinceId,
  });

  HomeServiceRequestModel toModel() {
    return HomeServiceRequestModel(
      id: id,
      trackCode: trackCode,
      firstName: firstName,
      lastName: lastName,
      latitude: latitude,
      longitude: longitude,
      aidAddress: aidAddress,
      cityName: cityName,
      provinceName: provinceName,
      carName: carName,
      carProductionYear: carProductionYear,
      licensePlate: licensePlate,
      requestStatus: requestStatus,
      requestStatusTitle: requestStatusTitle,
      requestDateJalali: requestDateJalali,
      requestTime: requestTime,
      requestDay: requestDay,
      bookedDateTimeJalali: bookedDateTimeJalali,
      emdadServiceCategoryTitle: emdadServiceCategoryTitle,
      emdadgarName: emdadgarName,
      agencyName: agencyName,
      agencyCode: agencyCode,
      customerMobileNumber: customerMobileNumber,
      description: description,
      carColorTitle: carColorTitle,
      carEngineNumber: carEngineNumber,
      genderTitle: genderTitle,
      personTypeTitle: personTypeTitle,
      chassisNumber: chassisNumber,
      kilometer: kilometer,
      nationalCode: nationalCode,
      dispatcher: dispatcher,
      emFullName: emFullName,
      emMobileNumber1: emMobileNumber1,
      emVehicleTypeTitle: emVehicleTypeTitle,
      emVehicleType: emVehicleType,
      emVehicleSubTypeTitle: emVehicleSubTypeTitle,
      emVehicleSubType: emVehicleSubType,
      emRepresentationName: emRepresentationName,
      emRepresentationCode: emRepresentationCode,
      isGuaranty: isGuaranty,
      isSubscription: isSubscription,
      requestDateTime: requestDateTime,
      requestDayTime: requestDayTime,
      emdadProductTitle: emdadProductTitle,
      serviceType: serviceType,
      cancelReasonId: cancelReasonId,
      addressHasBeenSet: addressHasBeenSet,
      invoiceDocumentGuid: invoiceDocumentGuid,
      distanceToCustomer: distanceToCustomer,
      emdadgarPriority: emdadgarPriority,
      emdadgarEvaluationDescription: emdadgarEvaluationDescription,
      emdadgarEvaluationKilometer: emdadgarEvaluationKilometer,
      isNewCar: isNewCar,
      vip: vip,
      vipConditionTitle: vipConditionTitle,
      hasTrafficOrPollutionPlan: hasTrafficOrPollutionPlan,
      hasSpecialPlan: hasSpecialPlan,
      specialPlanTitle: specialPlanTitle,
      specialPlanZoneTitle: specialPlanZoneTitle,
      hamlAzad: hamlAzad,
      reasonHamlAzadId: reasonHamlAzadId,
      reasonHamlAzadTitle: reasonHamlAzadTitle,
      reasonHamlAzadDesc: reasonHamlAzadDesc,
      foreigner: foreigner,
      insertUserName: insertUserName,
      updateUserName: updateUserName,
      cancelReasonTitle: cancelReasonTitle,
      cancelReasonDetailTitle: cancelReasonDetailTitle,
      cancelReasonDescription: cancelReasonDescription,
      cancelAssignDescription: cancelAssignDescription,
      nightOrHoliday: nightOrHoliday,
      nightOrHolidayDescription: nightOrHolidayDescription,
      customerDisability: customerDisability,
      customerDisabilityDesc: customerDisabilityDesc,
    );
  }
}
