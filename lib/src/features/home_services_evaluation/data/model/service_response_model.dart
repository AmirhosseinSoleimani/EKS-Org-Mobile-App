import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';


class ServiceResponseModel extends ServiceResponseEntity {
  ServiceResponseModel({
    super.id,
    super.carModelId,
    super.guid,
    super.name,
    super.chassisNo,
    super.serviceList,
    super.defectInfo,
    super.imageBase64,
    super.imageMandatory,
  });

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceResponseModel(
      id: json['id'],
      carModelId: json['carModelId'],
      guid: json['guid'],
      name: json['name'],
      imageBase64: json['imageBase64'],
      chassisNo: json['chassisNo'],
      serviceList: (json['emdadServices'] as List).map((e) => EmdadServiceResultModel.fromJson(e)).toList(),
      defectInfo: json['defectInfo'] != null ? DefectCostAndTimeModel.fromJson(json['defectInfo']) : null,
      imageMandatory: json['isImageMandatory']
    );
  }
}


class EmdadServiceResultModel extends EmdadServiceResultEntity {
  EmdadServiceResultModel({
    super.serviceType,
    super.serviceCategoryId,
    super.serviceCategoryCode,
    super.serviceCategoryTitle,
    super.serviceId,
    super.serviceCode,
    super.serviceTitle,
    super.serviceFromKilometer,
    super.serviceToKilometer,
    super.productId,
    super.productTitle,
    super.hasSubscription,
    super.fromDateStr,
    super.toDateStr,
    super.fromKilometerStr,
    super.toKilometerStr,
    super.isSelectable,
    super.isLimited,
    super.limitedDescription,
    super.kilometerLimitation,
    super.usageLimitation,
    super.imageGuid,
    super.imageBase64,
    super.workOrderCode,
    super.isSubscribedByNationalCode,
    super.serviceTypeTitle,
    super.subscriptionId,
    super.imageMandatory,
  });

  factory EmdadServiceResultModel.fromJson(Map<String, dynamic> json) {
    return EmdadServiceResultModel(
      isSubscribedByNationalCode: json['isSubscribedByNationalCode'],
      serviceTypeTitle: json['serviceTypeTitle'],
      subscriptionId: json['subscriptionId'],
      serviceType: json['serviceType'],
      serviceCategoryId: json['serviceCategoryId'],
      serviceCategoryCode: json['serviceCategoryCode'],
      serviceCategoryTitle: json['serviceCategoryTitle'],
      serviceId: json['serviceId'],
      serviceCode: json['serviceCode'],
      serviceTitle: json['serviceTitle'],
      serviceFromKilometer: json['serviceFromKilometer'],
      serviceToKilometer: json['serviceToKilometer'],
      productId: json['productId'],
      productTitle: json['productTitle'],
      hasSubscription: json['hasSubscription'],
      fromDateStr: json['fromDateStr'],
      toDateStr: json['toDateStr'],
      fromKilometerStr: json['fromKilometerStr'],
      toKilometerStr: json['toKilometerStr'],
      isSelectable: json['isSelectable'],
      isLimited: json['isLimited'],
      limitedDescription: json['limitedDescription'],
      kilometerLimitation: json['kilometerLimitation'],
      usageLimitation: json['usageLimitation'],
      imageGuid: json['imageGuid'],
      imageBase64: json['imageBase64'],
      workOrderCode: json['workOrderCode'],
      imageMandatory: json['isImageMandatory'],
    );
  }
}


class DefectCostAndTimeModel extends DefectCostAndTimeEntity {
  DefectCostAndTimeModel({
    super.id,
    super.minCost,
    super.maxCost,
    super.estimatedTime,
  });

  factory DefectCostAndTimeModel.fromJson(Map<String, dynamic> json) {
    return DefectCostAndTimeModel(
      id: json['id'],
      minCost: json['minCost'],
      maxCost: json['maxCost'],
      estimatedTime: json['estimatedTime'],
    );
  }
}