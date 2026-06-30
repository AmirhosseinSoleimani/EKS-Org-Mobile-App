
import 'package:eks_sana_plus_org/src/features/services/data/models/base_service_request_model.dart';

import 'subscription_info_entity.dart';

class BaseServiceRequestEntity {
  const BaseServiceRequestEntity({
    this.customerDisability,
    this.customerDisabilityDesc,
    this.customerMobileNumber,
    this.carInfoId,
    this.carModelId,
    this.trackCode,
    this.carColor,
    this.carName,
    this.carEngineNumber,
    this.carInfoGuid,
    this.carGroupId,
    this.carGroupTitle,
    this.carFactory,
    this.carProductionYear,
    this.vehicleUsageId,
    this.vehicleUsageTitle,
    this.foreigner,
    this.requestStatus,
    this.requestState,
    this.subscription,
    this.subscriptionFactorNo,
    this.vip,
    this.vipConditionId,
    this.vipConditionTitle,
    this.emdadServiceCategoryTitle,
    this.emdadServiceCategoryGivenTitle,
    this.planningId,
    this.emdadgarId,
    this.emdadgarName,
    this.modifyAddressToken,
    this.addressHasBeenSet,
    this.cancelReasonId,
    this.cancelReasonTitle,
    this.cancelReasonDescription,
    this.trafficPlan,
    this.pollutionPlan,
    this.dispatcher,
    this.assignRecordId,
    this.assignDate,
    this.reserver,
    this.reserveRecordId,
    this.reserveDate,
    this.etmamRequestAuthor,
    this.etmamRequestDate,
    this.completeDate,
    this.subscriptionId,
    this.emdadProductId,
    this.emdadProductTitle,
    this.garantyStartDate,
    this.garantyEndDate,
    this.garantySiteDescription,
    this.garantyReceptionDate,
    this.garantyLastKilometer,
    this.garantyStatusCode,
    this.garantyIsGaranty = false,
    this.garantyDescription,
    this.garantyCarTipId,
    this.notSendSms,
    this.emdadgarAssignLatitude,
    this.emdadgarAssignLongitude,
    this.copyReason,
    this.copyReasonTitle,
    this.copyDesc,
    this.cancelReasonDetailId,
    this.cancelReasonDetailTitle,
    this.isNewCar,
    this.isNight,
    this.isHoliday,
    this.nightOrHoliday,
    this.nightOrHolidayDescription,
    this.invoiceDocumentGuid,
    this.entryPageDateTime,
    this.trackGuid,
    this.agencyCode,
    this.agencyName,
    this.dispatchType,
    this.isUrgentRequest,
    this.requestDateTime,
    this.isCopy,
    this.limitationMessage,
    this.extraData = const {},
    this.customerUserInfo,
    this.emdadgarNotificationHasBeenSent,
    this.hasSpecialPlan,
    this.specialPlanId,
    this.specialPlanTitle,
    this.specialPlanZoneId,
    this.specialPlanZoneTitle,
    this.isSubscribedBySpecialPlanProduct = false,
    this.subscriptionInfo,
    this.operationFenceId,
    this.operationFenceTitle,
    this.operationFenceZoneId,
    this.operationFenceZoneTitle,
    this.services = const [],
    this.serviceIds = const [],
    this.serviceGivenIds = const [],
  });

  final int? customerDisability;
  final String? customerDisabilityDesc;
  final String? customerMobileNumber;
  final int? carInfoId;
  final int? carModelId;
  final int? trackCode;
  final int? carColor;
  final String? carName;
  final String? carEngineNumber;
  final String? carInfoGuid;
  final int? carGroupId;
  final String? carGroupTitle;
  final int? carFactory;
  final int? carProductionYear;
  final int? vehicleUsageId;
  final String? vehicleUsageTitle;
  final bool? foreigner;
  final int? requestStatus;
  final int? requestState;
  final bool? subscription;
  final String? subscriptionFactorNo;
  final bool? vip;
  final int? vipConditionId;
  final String? vipConditionTitle;
  final String? emdadServiceCategoryTitle;
  final String? emdadServiceCategoryGivenTitle;
  final int? planningId;
  final int? emdadgarId;
  final String? emdadgarName;
  final String? modifyAddressToken;
  final bool? addressHasBeenSet;
  final int? cancelReasonId;
  final String? cancelReasonTitle;
  final String? cancelReasonDescription;
  final bool? trafficPlan;
  final bool? pollutionPlan;
  final String? dispatcher;
  final int? assignRecordId;
  final DateTime? assignDate;
  final String? reserver;
  final int? reserveRecordId;
  final DateTime? reserveDate;
  final String? etmamRequestAuthor;
  final DateTime? etmamRequestDate;
  final DateTime? completeDate;
  final int? subscriptionId;
  final int? emdadProductId;
  final String? emdadProductTitle;
  final String? garantyStartDate;
  final String? garantyEndDate;
  final String? garantySiteDescription;
  final String? garantyReceptionDate;
  final String? garantyLastKilometer;
  final int? garantyStatusCode;
  final bool garantyIsGaranty;
  final String? garantyDescription;
  final int? garantyCarTipId;
  final bool? notSendSms;
  final double? emdadgarAssignLatitude;
  final double? emdadgarAssignLongitude;
  final int? copyReason;
  final String? copyReasonTitle;
  final String? copyDesc;
  final int? cancelReasonDetailId;
  final String? cancelReasonDetailTitle;
  final bool? isNewCar;
  final bool? isNight;
  final bool? isHoliday;
  final bool? nightOrHoliday;
  final String? nightOrHolidayDescription;
  final String? invoiceDocumentGuid;
  final DateTime? entryPageDateTime;
  final String? trackGuid;
  final String? agencyCode;
  final String? agencyName;
  final int? dispatchType;
  final bool? isUrgentRequest;
  final DateTime? requestDateTime;
  final bool? isCopy;
  final String? limitationMessage;
  final Map<String, String> extraData;
  // TODO
  final dynamic customerUserInfo;
  final bool? emdadgarNotificationHasBeenSent;
  final bool? hasSpecialPlan;
  final int? specialPlanId;
  final String? specialPlanTitle;
  final int? specialPlanZoneId;
  final String? specialPlanZoneTitle;
  final bool? isSubscribedBySpecialPlanProduct;
  final SubscriptionInfoEntity? subscriptionInfo;
  final int? operationFenceId;
  final String? operationFenceTitle;
  final int? operationFenceZoneId;
  final String? operationFenceZoneTitle;
  final List<dynamic> services;
  final List<int> serviceIds;
  final List<int> serviceGivenIds;

  BaseServiceRequestModel toModel() {
    return BaseServiceRequestModel(
      customerDisability: customerDisability,
      customerDisabilityDesc: customerDisabilityDesc,
      customerMobileNumber: customerMobileNumber,
      carInfoId: carInfoId,
      carModelId: carModelId,
      trackCode: trackCode,
      carColor: carColor,
      carName: carName,
      carEngineNumber: carEngineNumber,
      carInfoGuid: carInfoGuid,
      carGroupId: carGroupId,
      carGroupTitle: carGroupTitle,
      carFactory: carFactory,
      carProductionYear: carProductionYear,
      vehicleUsageId: vehicleUsageId,
      vehicleUsageTitle: vehicleUsageTitle,
      foreigner: foreigner,
      requestStatus: requestStatus,
      requestState: requestState,
      subscription: subscription,
      subscriptionFactorNo: subscriptionFactorNo,
      vip: vip,
      vipConditionId: vipConditionId,
      vipConditionTitle: vipConditionTitle,
      emdadServiceCategoryTitle: emdadServiceCategoryTitle,
      emdadServiceCategoryGivenTitle: emdadServiceCategoryGivenTitle,
      planningId: planningId,
      emdadgarId: emdadgarId,
      emdadgarName: emdadgarName,
      modifyAddressToken: modifyAddressToken,
      addressHasBeenSet: addressHasBeenSet,
      cancelReasonId: cancelReasonId,
      cancelReasonTitle: cancelReasonTitle,
      cancelReasonDescription: cancelReasonDescription,
      trafficPlan: trafficPlan,
      pollutionPlan: pollutionPlan,
      dispatcher: dispatcher,
      assignRecordId: assignRecordId,
      assignDate: assignDate,
      reserver: reserver,
      reserveRecordId: reserveRecordId,
      reserveDate: reserveDate,
      etmamRequestAuthor: etmamRequestAuthor,
      etmamRequestDate: etmamRequestDate,
      completeDate: completeDate,
      subscriptionId: subscriptionId,
      emdadProductId: emdadProductId,
      emdadProductTitle: emdadProductTitle,
      garantyStartDate: garantyStartDate,
      garantyEndDate: garantyEndDate,
      garantySiteDescription: garantySiteDescription,
      garantyReceptionDate: garantyReceptionDate,
      garantyLastKilometer: garantyLastKilometer,
      garantyStatusCode: garantyStatusCode,
      garantyIsGaranty: garantyIsGaranty,
      garantyDescription: garantyDescription,
      garantyCarTipId: garantyCarTipId,
      notSendSms: notSendSms,
      emdadgarAssignLatitude: emdadgarAssignLatitude,
      emdadgarAssignLongitude: emdadgarAssignLongitude,
      copyReason: copyReason,
      copyReasonTitle: copyReasonTitle,
      copyDesc: copyDesc,
      cancelReasonDetailId: cancelReasonDetailId,
      cancelReasonDetailTitle: cancelReasonDetailTitle,
      isNewCar: isNewCar,
      isNight: isNight,
      isHoliday: isHoliday,
      nightOrHoliday: nightOrHoliday,
      nightOrHolidayDescription: nightOrHolidayDescription,
      invoiceDocumentGuid: invoiceDocumentGuid,
      entryPageDateTime: entryPageDateTime,
      trackGuid: trackGuid,
      agencyCode: agencyCode,
      agencyName: agencyName,
      dispatchType: dispatchType,
      isUrgentRequest: isUrgentRequest,
      requestDateTime: requestDateTime,
      isCopy: isCopy,
      limitationMessage: limitationMessage,
      extraData: extraData,
      customerUserInfo: customerUserInfo,
      emdadgarNotificationHasBeenSent: emdadgarNotificationHasBeenSent,
      hasSpecialPlan: hasSpecialPlan,
      specialPlanId: specialPlanId,
      specialPlanTitle: specialPlanTitle,
      specialPlanZoneId: specialPlanZoneId,
      specialPlanZoneTitle: specialPlanZoneTitle,
      isSubscribedBySpecialPlanProduct: isSubscribedBySpecialPlanProduct,
      subscriptionInfo: subscriptionInfo?.toModel(),
      operationFenceId: operationFenceId,
      operationFenceTitle: operationFenceTitle,
      operationFenceZoneId: operationFenceZoneId,
      operationFenceZoneTitle: operationFenceZoneTitle,
      services: services,
      serviceIds: serviceIds,
      serviceGivenIds: serviceGivenIds,
    );
  }
}