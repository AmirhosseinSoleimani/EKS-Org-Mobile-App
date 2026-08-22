import 'package:eks_sana_plus_org/src/features/services/data/models/relief_request_model.dart';

import 'abstract/base_request_entity.dart';

class ReliefRequestListEntity {
  final List<ReliefRequestEntity> items;
  final int totalCount;

  const ReliefRequestListEntity({
    required this.items,
    required this.totalCount,
  });

  ReliefRequestListEntity copyWith({
    List<ReliefRequestEntity>? items,
    int? totalCount,
  }) {
    return ReliefRequestListEntity(
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  ReliefRequestListModel toModel() {
    return ReliefRequestListModel(
      items: items,
      totalCount: totalCount,
    );
  }
}

class ReliefRequestEntity extends BaseRequestEntity {
  final int? defectId;
  final String? defectTitle;

  final bool? isUrgentRequest;
  final bool? isUrgentRequestCompleted;

  final String? emdadServiceTitle;
  final int? emdadServiceCategoryId;
  final int? emdadServiceId;
  final String? hamlReasonTitle;
  final String? wheelQuestionTitle;

  final String? emdadgarAssignDistanceTitle;
  final String? emdadgarAssignDurationTitle;
  final double? distanceHamlCustomer;
  final String? emdadServiceCategoryGivenTitle;
  final String? emdadServiceGivenTitle;
  final String? emdadgarEvaluationDefectTitle;

  @override
  final String? assignDate;
  final String? assignTime;

  const ReliefRequestEntity({
    super.id,
    super.trackCode,
    super.firstName,
    super.lastName,
    super.latitude,
    super.longitude,
    super.aidAddress,
    super.cityId,
    super.provinceId,
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
    this.defectId,
    this.defectTitle,
    this.isUrgentRequest,
    this.isUrgentRequestCompleted,
    this.emdadServiceTitle,
    this.hamlReasonTitle,
    this.wheelQuestionTitle,
    this.emdadgarAssignDistanceTitle,
    this.emdadgarAssignDurationTitle,
    this.distanceHamlCustomer,
    this.emdadServiceCategoryGivenTitle,
    this.emdadServiceGivenTitle,
    this.emdadgarEvaluationDefectTitle,
    this.assignDate,
    this.assignTime,
    this.emdadServiceCategoryId,
    this.emdadServiceId,
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
  });

  ReliefRequestModel toModel() {
    return ReliefRequestModel(
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
      defectId: defectId,
      defectTitle: defectTitle,
      isUrgentRequest: isUrgentRequest,
      isUrgentRequestCompleted: isUrgentRequestCompleted,
      emdadServiceTitle: emdadServiceTitle,
      customerMobileNumber: customerMobileNumber,
      description: description,
      carColorTitle: carColorTitle,
      carEngineNumber: carEngineNumber,
      genderTitle: genderTitle,
      personTypeTitle: personTypeTitle,
      assignDate: assignDate,
      assignTime: assignTime,
      chassisNumber: chassisNumber,
      kilometer: kilometer,
      isGuaranty: isGuaranty,
      dispatcher: dispatcher,
      emFullName: emFullName,
      emRepresentationCode: emRepresentationCode,
      emVehicleTypeTitle: emVehicleTypeTitle,
      nationalCode: nationalCode,
      isSubscription: isSubscription,
      emVehicleSubTypeTitle: emVehicleSubTypeTitle,
      emMobileNumber1: emMobileNumber1,
      emdadgarAssignDistanceTitle: emdadgarAssignDistanceTitle,
      emVehicleType: emVehicleType,
      emRepresentationName: emRepresentationName,
      emVehicleSubType: emVehicleSubType,
      emdadgarAssignDurationTitle: emdadgarAssignDurationTitle,
      distanceHamlCustomer: distanceHamlCustomer,
      emdadServiceCategoryGivenTitle: emdadServiceCategoryGivenTitle,
      emdadServiceGivenTitle: emdadServiceGivenTitle,
      emdadgarEvaluationDefectTitle: emdadgarEvaluationDefectTitle,
      hamlReasonTitle: hamlReasonTitle,
      wheelQuestionTitle: wheelQuestionTitle,
      serviceType: serviceType,
      cancelReasonId: cancelReasonId,
      addressHasBeenSet: addressHasBeenSet,
      invoiceDocumentGuid: invoiceDocumentGuid,
      agencyCode: agencyCode,
      agencyName:agencyName,
      requestDateTime:requestDateTime,
      emdadServiceCategoryId: emdadServiceCategoryId,
      emdadServiceId: emdadServiceId,
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
