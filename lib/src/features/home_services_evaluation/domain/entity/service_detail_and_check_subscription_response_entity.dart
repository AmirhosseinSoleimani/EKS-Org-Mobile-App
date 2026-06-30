import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_detail_and_check_subscription_response_model.dart';

class ServiceDetailAndCheckSubscriptionResponseEntity {
  ServiceDetailAndCheckSubscriptionResponseEntity({
    this.limitationDescription,
    this.serviceType,
    this.serviceTypeTitle,
    this.serviceCategoryId,
    this.serviceCategoryCode,
    this.serviceCategoryTitle,
    this.serviceId,
    this.serviceCode,
    this.serviceTitle,
    this.hasSubscription,
    this.hasGaranty,
    this.isSubscribedByNationalCode,
    this.defectInfoId,
    this.productId,
    this.productTitle,
    this.subscriptionId,
    this.defectInfoTitle,
    this.defectInfoProblemOrEzharCode,
    this.garantyStartDate,
    this.needImage,
    this.isImageMandatory,
  });

  String? limitationDescription;
  int? serviceType;
  String? serviceTypeTitle;
  int? serviceCategoryId;
  String? serviceCategoryCode;
  String? serviceCategoryTitle;
  int? serviceId;
  String? serviceCode;
  String? serviceTitle;
  bool? hasSubscription;
  bool? hasGaranty;
  bool? isSubscribedByNationalCode;
  int? defectInfoId;
  int? productId;
  String? productTitle;
  int? subscriptionId;
  String? defectInfoTitle;
  String? defectInfoProblemOrEzharCode;
  String? garantyStartDate;
  bool? needImage;
  bool? isImageMandatory;

  ServiceDetailAndCheckSubscriptionResponseEntity copyWith({
    String? limitationDescription,
    int? serviceType,
    String? serviceTypeTitle,
    int? serviceCategoryId,
    String? serviceCategoryCode,
    String? serviceCategoryTitle,
    int? serviceId,
    String? serviceCode,
    String? serviceTitle,
    bool? hasSubscription,
    bool? hasGaranty,
    bool? isSubscribedByNationalCode,
    int? defectInfoId,
    int? productId,
    String? productTitle,
    int? subscriptionId,
    String? defectInfoTitle,
    String? defectInfoProblemOrEzharCode,
    String? garantyStartDate,
    bool? needImage,
    bool? isImageMandatory,
  }) {
    return ServiceDetailAndCheckSubscriptionResponseEntity(
      limitationDescription:
          limitationDescription ?? this.limitationDescription,
      serviceType: serviceType ?? this.serviceType,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceCategoryCode: serviceCategoryCode ?? this.serviceCategoryCode,
      serviceCategoryTitle: serviceCategoryTitle ?? this.serviceCategoryTitle,
      serviceId: serviceId ?? this.serviceId,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      hasGaranty: hasGaranty ?? this.hasGaranty,
      isSubscribedByNationalCode:
          isSubscribedByNationalCode ?? this.isSubscribedByNationalCode,
      defectInfoId: defectInfoId ?? this.defectInfoId,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      defectInfoTitle: defectInfoTitle ?? this.defectInfoTitle,
      defectInfoProblemOrEzharCode:
          defectInfoProblemOrEzharCode ?? this.defectInfoProblemOrEzharCode,
      garantyStartDate: garantyStartDate ?? this.garantyStartDate,
      needImage: needImage ?? this.needImage,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
    );
  }

  ServiceDetailAndCheckSubscriptionResponseModel toModel() {
    return ServiceDetailAndCheckSubscriptionResponseModel(
      limitationDescription: limitationDescription,
      serviceType: serviceType,
      serviceTypeTitle: serviceTypeTitle,
      serviceCategoryId: serviceCategoryId,
      serviceCategoryCode: serviceCategoryCode,
      serviceCategoryTitle: serviceCategoryTitle,
      serviceId: serviceId,
      serviceCode: serviceCode,
      serviceTitle: serviceTitle,
      hasSubscription: hasSubscription,
      hasGaranty: hasGaranty,
      isSubscribedByNationalCode: isSubscribedByNationalCode,
      defectInfoId: defectInfoId,
      productId: productId,
      productTitle: productTitle,
      subscriptionId: subscriptionId,
      defectInfoTitle: defectInfoTitle,
      defectInfoProblemOrEzharCode: defectInfoProblemOrEzharCode,
      garantyStartDate: garantyStartDate,
      needImage: needImage,
      isImageMandatory: isImageMandatory,
    );
  }
}
