import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_detail_and_check_subscription_response_entity.dart';

class ServiceDetailAndCheckSubscriptionResponseModel extends ServiceDetailAndCheckSubscriptionResponseEntity {
  ServiceDetailAndCheckSubscriptionResponseModel({
    super.defectInfoId,
    super.defectInfoProblemOrEzharCode,
    super.defectInfoTitle,
    super.hasGaranty,
    super.hasSubscription,
    super.isSubscribedByNationalCode,
    super.limitationDescription,
    super.productId,
    super.productTitle,
    super.serviceCategoryCode,
    super.serviceCategoryId,
    super.serviceCategoryTitle,
    super.serviceCode,
    super.serviceId,
    super.serviceTitle,
    super.serviceType,
    super.serviceTypeTitle,
    super.subscriptionId,
    super.garantyStartDate,
    super.isImageMandatory,
    super.needImage
  });

  factory ServiceDetailAndCheckSubscriptionResponseModel.fromJson(dynamic json) {
    return ServiceDetailAndCheckSubscriptionResponseModel(
      limitationDescription: json['limitationDescription'],
      serviceType: json['serviceType'],
      serviceTypeTitle: json['serviceTypeTitle'],
      serviceCategoryId: json['serviceCategoryId'],
      serviceCategoryCode: json['serviceCategoryCode'],
      serviceCategoryTitle: json['serviceCategoryTitle'],
      serviceId: json['serviceId'],
      serviceCode: json['serviceCode'],
      serviceTitle: json['serviceTitle'],
      hasSubscription: json['hasSubscription'],
      hasGaranty: json['hasGaranty'],
      isSubscribedByNationalCode: json['isSubscribedByNationalCode'],
      defectInfoId: json['defectInfoId'],
      productId: json['productId'],
      productTitle: json['productTitle'],
      subscriptionId: json['subscriptionId'],
      defectInfoTitle: json['defectInfoTitle'],
      defectInfoProblemOrEzharCode: json['defectInfoProblemOrEzharCode'],
      garantyStartDate: json['garantyStartDate'],
      isImageMandatory: json['isImageMadatory'],
      needImage: json['needImage'],
    );
  }

}
