import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_response_model.dart';

class ServiceResponseEntity {
  ServiceResponseEntity({
    this.id,
    this.carModelId,
    this.guid,
    this.name,
    this.chassisNo,
    this.emdadServices,
    this.defectInfo,
    this.imageBase64,
    this.imageMandatory,
  });

  final int? id;
  final int? carModelId;
  final String? guid;
  final String? name;
  final String? chassisNo;
  final String? imageBase64;
  final List<EmdadServiceResultEntity>? emdadServices;
  final DefectCostAndTimeEntity? defectInfo;
  final bool? imageMandatory;

  ServiceResponseEntity copyWith({
    int? id,
    int? carModelId,
    String? guid,
    String? name,
    String? chassisNo,
    List<EmdadServiceResultEntity>? emdadServices,
    DefectCostAndTimeEntity? defectInfo,
    String? imageBase64,
    bool? imageMandatory,
  }) {
    return ServiceResponseEntity(
      id: id ?? this.id,
      carModelId: carModelId ?? this.carModelId,
      guid: guid ?? this.guid,
      name: name ?? this.name,
      imageBase64: imageBase64 ?? this.imageBase64,
      chassisNo: chassisNo ?? this.chassisNo,
      emdadServices: emdadServices ?? this.emdadServices,
      defectInfo: defectInfo ?? this.defectInfo,
      imageMandatory: imageMandatory ?? this.imageMandatory,
    );
  }

  ServiceResponseModel toModel() {
    return ServiceResponseModel(
      id: id,
      carModelId: carModelId,
      guid: guid,
      name: name,
      chassisNo: chassisNo,
      emdadServices: emdadServices?.map((e) => e.toModel()).toList(),
      defectInfo: defectInfo?.toModel(),
      imageBase64: imageBase64,
      imageMandatory: imageMandatory,
    );
  }
}

class EmdadServiceResultEntity {
  EmdadServiceResultEntity({
    this.serviceType,
    this.serviceCategoryId,
    this.serviceCategoryCode,
    this.serviceCategoryTitle,
    this.serviceId,
    this.serviceCode,
    this.serviceTitle,
    this.serviceFromKilometer,
    this.serviceToKilometer,
    this.productId,
    this.productTitle,
    this.hasSubscription,
    this.fromDateStr,
    this.toDateStr,
    this.fromKilometerStr,
    this.toKilometerStr,
    this.isSelectable,
    this.isLimited,
    this.limitedDescription,
    this.kilometerLimitation,
    this.usageLimitation,
    this.imageGuid,
    this.imageBase64,
    this.workOrderCode,
    this.serviceTypeTitle,
    this.subscriptionId,
    this.isSubscribedByNationalCode,
    this.imageMandatory,
  });

  final int? serviceType;
  final int? serviceCategoryId;
  final String? serviceCategoryCode;
  final String? serviceCategoryTitle;
  final int? serviceId;
  final String? serviceCode;
  final String? serviceTitle;
  final int? serviceFromKilometer;
  final int? serviceToKilometer;
  final int? productId;
  final String? productTitle;
  final bool? hasSubscription;
  final String? fromDateStr;
  final String? toDateStr;
  final String? fromKilometerStr;
  final String? toKilometerStr;
  final bool? isSelectable;
  final bool? isLimited;
  final String? limitedDescription;
  final int? kilometerLimitation;
  final int? usageLimitation;
  final String? imageGuid;
  final String? imageBase64;
  final String? workOrderCode;
  final int? subscriptionId;
  final bool? isSubscribedByNationalCode;
  final String? serviceTypeTitle;
  final bool? imageMandatory;

  EmdadServiceResultEntity copyWith({
    int? serviceType,
    int? serviceCategoryId,
    String? serviceCategoryCode,
    String? serviceCategoryTitle,
    int? serviceId,
    String? serviceCode,
    String? serviceTitle,
    int? serviceFromKilometer,
    int? serviceToKilometer,
    int? productId,
    String? productTitle,
    bool? hasSubscription,
    String? fromDateStr,
    String? toDateStr,
    String? fromKilometerStr,
    String? toKilometerStr,
    bool? isSelectable,
    bool? isLimited,
    String? limitedDescription,
    int? kilometerLimitation,
    int? usageLimitation,
    String? imageGuid,
    String? imageBase64,
    String? workOrderCode,
    int? subscriptionId,
    bool? isSubscribedByNationalCode,
    String? serviceTypeTitle,
    bool? imageMandatory,
  }) {
    return EmdadServiceResultEntity(
      serviceType: serviceType ?? this.serviceType,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceCategoryCode: serviceCategoryCode ?? this.serviceCategoryCode,
      serviceCategoryTitle: serviceCategoryTitle ?? this.serviceCategoryTitle,
      serviceId: serviceId ?? this.serviceId,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      serviceFromKilometer: serviceFromKilometer ?? this.serviceFromKilometer,
      serviceToKilometer: serviceToKilometer ?? this.serviceToKilometer,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      fromDateStr: fromDateStr ?? this.fromDateStr,
      toDateStr: toDateStr ?? this.toDateStr,
      fromKilometerStr: fromKilometerStr ?? this.fromKilometerStr,
      toKilometerStr: toKilometerStr ?? this.toKilometerStr,
      isSelectable: isSelectable ?? this.isSelectable,
      isLimited: isLimited ?? this.isLimited,
      limitedDescription: limitedDescription ?? this.limitedDescription,
      kilometerLimitation: kilometerLimitation ?? this.kilometerLimitation,
      usageLimitation: usageLimitation ?? this.usageLimitation,
      imageGuid: imageGuid ?? this.imageGuid,
      imageBase64: imageBase64 ?? this.imageBase64,
      workOrderCode: workOrderCode ?? this.workOrderCode,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
      isSubscribedByNationalCode:
          isSubscribedByNationalCode ?? this.isSubscribedByNationalCode,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      imageMandatory: imageMandatory ?? this.imageMandatory,
    );
  }

  EmdadServiceResultModel toModel() {
    return EmdadServiceResultModel(
      subscriptionId: subscriptionId,
      isSubscribedByNationalCode: isSubscribedByNationalCode,
      serviceTypeTitle: serviceTypeTitle,
      serviceType: serviceType,
      serviceCategoryId: serviceCategoryId,
      serviceCategoryCode: serviceCategoryCode,
      serviceCategoryTitle: serviceCategoryTitle,
      serviceId: serviceId,
      serviceCode: serviceCode,
      serviceTitle: serviceTitle,
      serviceFromKilometer: serviceFromKilometer,
      serviceToKilometer: serviceToKilometer,
      productId: productId,
      productTitle: productTitle,
      hasSubscription: hasSubscription,
      fromDateStr: fromDateStr,
      toDateStr: toDateStr,
      fromKilometerStr: fromKilometerStr,
      toKilometerStr: toKilometerStr,
      isSelectable: isSelectable,
      isLimited: isLimited,
      limitedDescription: limitedDescription,
      kilometerLimitation: kilometerLimitation,
      usageLimitation: usageLimitation,
      imageGuid: imageGuid,
      imageBase64: imageBase64,
      workOrderCode: workOrderCode,
      imageMandatory: imageMandatory,
    );
  }
}

class DefectCostAndTimeEntity {
  DefectCostAndTimeEntity({
    this.id,
    this.minCost,
    this.maxCost,
    this.estimatedTime,
  });

  final int? id;
  final int? minCost;
  final int? maxCost;
  final int? estimatedTime;

  DefectCostAndTimeEntity copyWith({
    int? id,
    int? minCost,
    int? maxCost,
    int? estimatedTime,
  }) {
    return DefectCostAndTimeEntity(
      id: id ?? this.id,
      minCost: minCost ?? this.minCost,
      maxCost: maxCost ?? this.maxCost,
      estimatedTime: estimatedTime ?? this.estimatedTime,
    );
  }

  DefectCostAndTimeModel toModel() {
    return DefectCostAndTimeModel(
      id: id,
      minCost: minCost,
      maxCost: maxCost,
      estimatedTime: estimatedTime,
    );
  }
}
