import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_labor_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';

class EvaluationServiceModel extends EvaluationServiceEntity {
  EvaluationServiceModel({
    super.hasSubscription,
    super.serviceCategoryId,
    super.serviceCategoryTitle,
    super.serviceId,
    super.serviceTitle,
    super.defectInfoId,
    super.defectInfoTitle,
    super.evaluationLabors,
    super.productId,
    super.productTitle,
    super.serviceCategoryCode,
    super.serviceCode,
    super.serviceType,
    super.serviceTypeTitle,
    super.subscriptionId,
    super.garantyStartDate,
    super.hasGaranty,
    super.isSubscribedByNationalCode,
    super.limitationDescription,
    super.defectInfoProblemOrEzharCode,
    super.isImageMandatory,
    super.needImage,
    super.isCustomerSelected,
  });

  factory EvaluationServiceModel.fromJson(Map<String, dynamic> json) {
    return EvaluationServiceModel(
      defectInfoId: json['defectInfoId'],
      defectInfoTitle: json['defectInfoTitle'],
      serviceType: json['serviceType'],
      serviceTypeTitle: json['serviceTypeTitle'],
      serviceCategoryId: json['serviceCategoryId'],
      serviceCategoryTitle: json['serviceCategoryTitle'],
      serviceCategoryCode: json['serviceCategoryCode'],
      serviceId: json['serviceId'],
      serviceCode: json['serviceCode'],
      serviceTitle: json['serviceTitle'],
      hasSubscription: json['hasSubscription'],
      subscriptionId: json['subscriptionId'],
      productId: json['productId'],
      productTitle: json['productTitle'],
      evaluationLabors: (json['evaluationLabors'] as List<dynamic>?)?.map((e) => EvaluationLaborResponseModel.fromJson(e)).toList(),
      garantyStartDate: json['garantyStartDate'],
      hasGaranty: json['hasGaranty'],
      isSubscribedByNationalCode: json['isSubscribedByNationalCode'],
      limitationDescription: json['limitationDescription'],
      defectInfoProblemOrEzharCode: json['defectInfoProblemOrEzharCode'],
      isImageMandatory: json['isImageMandatory'],
      needImage: json['needImage'],
      isCustomerSelected: (json['isCustomerSelected'] == null) ? true : json['isCustomerSelected'],

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'defectInfoId': defectInfoId,
      'defectInfoTitle': defectInfoTitle,
      'serviceType': serviceType,
      'serviceTypeTitle': serviceTypeTitle,
      'serviceCategoryId': serviceCategoryId,
      'serviceCategoryTitle': serviceCategoryTitle,
      'serviceCategoryCode': serviceCategoryCode,
      'serviceId': serviceId,
      'serviceCode': serviceCode,
      'serviceTitle': serviceTitle,
      'hasSubscription': hasSubscription,
      'subscriptionId': subscriptionId,
      'productId': productId,
      'productTitle': productTitle,
      'evaluationLabors': evaluationLabors?.map((e) => e.toModel().toJson()).toList(),
      'garantyStartDate': garantyStartDate,
      'hasGaranty': hasGaranty,
      'isSubscribedByNationalCode': isSubscribedByNationalCode,
      'limitationDescription': limitationDescription,
      'defectInfoProblemOrEzharCode': defectInfoProblemOrEzharCode,
      'needImage': needImage,
      'isImageMandatory': isImageMandatory,
      'isCustomerSelected': isCustomerSelected,
    };
  }
}