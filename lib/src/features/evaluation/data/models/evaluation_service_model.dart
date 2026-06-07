import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/evaluation_service_entity.dart';

class EvaluationServiceModel extends EvaluationServiceEntity {
  EvaluationServiceModel({
    super.serviceId,
    super.serviceTypeId,
    super.serviceTitle,
    super.serviceCode,
    super.isCustomerSelected,
    super.isImageMandatory,
    super.serviceCategoryId,
    super.serviceCategoryTitle,
    super.serviceCategoryCode,
    super.serviceType,
    super.serviceTypeTitle,
    super.workOrderCode,
    super.defectInfoId,
    super.defectInfoTitle,
    super.evaluationId,
    super.subscriptionId,
    super.hasSubscription,
    super.productId,
    super.productTitle,
    super.product,
    super.hasGaranty,
    super.garantyStartDate,
    super.isDeleted,
    super.isSubscribedByNationalCode,
    super.evaluationLabors,
  });

  factory EvaluationServiceModel.fromJson(Map<String, dynamic> json) {
    return EvaluationServiceModel(
      serviceId: json['serviceId'],
      serviceTypeId: json['serviceTypeId'],
      serviceTitle: json['serviceTitle'],
      serviceCode: json['serviceCode'],
      isCustomerSelected: json['isCustomerSelected'],
      isImageMandatory: json['isImageMandatory'] ?? false,
      serviceCategoryId: json['serviceCategoryId'],
      serviceCategoryTitle: json['serviceCategoryTitle'],
      serviceCategoryCode: json['serviceCategoryCode'],
      serviceType: ServiceType.fromValue(json['serviceType']),
      serviceTypeTitle: json['serviceTypeTitle'],
      workOrderCode: json['workOrderCode'],
      defectInfoId: json['defectInfoId'],
      defectInfoTitle: json['defectInfoTitle'],
      evaluationId: json['evaluationId'],
      subscriptionId: json['subscriptionId'],
      hasSubscription: json['hasSubscription'] ?? false,
      productId: json['productId'],
      productTitle: json['productTitle'],
      product: json['product'],
      hasGaranty: json['hasGaranty'] ?? false,
      garantyStartDate: json['garantyStartDate'],
      isDeleted: json['isDeleted'] ?? false,
      isSubscribedByNationalCode: json['isSubscribedByNationalCode'] ?? false,
      evaluationLabors: json['evaluationLabors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "evaluationLabors": evaluationLabors,
      "serviceType": serviceType,
      "serviceTypeId": serviceTypeId,
      "serviceTypeTitle": serviceTypeTitle,
      "serviceId": serviceId,
      "serviceCode": serviceCode,
      "serviceTitle": serviceTitle,
      "serviceCategoryId": serviceCategoryId,
      "serviceCategoryCode": serviceCategoryCode,
      "serviceCategoryTitle": serviceCategoryTitle,
      "hasGaranty": hasGaranty,
      "garantyStartDate": garantyStartDate,
      "hasSubscription": hasSubscription,
      "isSubscribedByNationalCode": isSubscribedByNationalCode,
      "productId": productId,
      if (defectInfoId != null) "defectInfoId": defectInfoId,
    };
  }
}