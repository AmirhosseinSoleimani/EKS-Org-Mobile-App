import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_service_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_labor_response_entity.dart';

class EvaluationServiceEntity {
  int? defectInfoId;
  String? defectInfoTitle;
  int? serviceType;
  String? serviceTypeTitle;
  int? serviceCategoryId;
  String? serviceCategoryTitle;
  String? serviceCategoryCode;
  int? serviceId;
  String? serviceCode;
  String? serviceTitle;
  bool? hasSubscription;
  bool? isSubscribedByNationalCode;
  bool? hasGaranty;
  String? garantyStartDate;
  int? subscriptionId;
  int? productId;
  String? productTitle;
  String? limitationDescription;
  String? defectInfoProblemOrEzharCode;
  List<EvaluationLaborResponseEntity>? evaluationLabors;
  bool? needImage;
  bool? isImageMandatory;
  bool? isCustomerSelected = true;

  EvaluationServiceEntity({
    this.serviceId,
    this.serviceTitle,
    this.serviceCategoryId,
    this.serviceCategoryTitle,
    this.hasSubscription,
    this.serviceType,
    this.productId,
    this.defectInfoId,
    this.defectInfoTitle,
    this.evaluationLabors,
    this.productTitle,
    this.serviceCategoryCode,
    this.serviceCode,
    this.serviceTypeTitle,
    this.subscriptionId,
    this.hasGaranty,
    this.limitationDescription,
    this.garantyStartDate,
    this.isSubscribedByNationalCode,
    this.defectInfoProblemOrEzharCode,
    this.isImageMandatory,
    this.needImage,
    this.isCustomerSelected = true,
  });

  EvaluationServiceEntity copyWith({
    int? defectInfoId,
    String? defectInfoTitle,
    int? serviceType,
    String? serviceTypeTitle,
    int? serviceCategoryId,
    String? serviceCategoryTitle,
    String? serviceCategoryCode,
    int? serviceId,
    String? serviceCode,
    String? serviceTitle,
    bool? hasSubscription,
    bool? isSubscribedByNationalCode,
    bool? hasGaranty,
    String? garantyStartDate,
    int? subscriptionId,
    int? productId,
    String? productTitle,
    String? limitationDescription,
    List<EvaluationLaborResponseEntity>? evaluationLabors,
    String? defectInfoProblemOrEzharCode,
    bool? needImage,
    bool? isImageMandatory,
    bool? isServiceCustomer,
  }) {
    return EvaluationServiceEntity(
      defectInfoId: defectInfoId ?? this.defectInfoId,
      defectInfoTitle: defectInfoTitle ?? this.defectInfoTitle,
      serviceType: serviceType ?? this.serviceType,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceCategoryTitle: serviceCategoryTitle ?? this.serviceCategoryTitle,
      serviceCategoryCode: serviceCategoryCode ?? this.serviceCategoryCode,
      serviceId: serviceId ?? this.serviceId,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      evaluationLabors: evaluationLabors ?? this.evaluationLabors,
      limitationDescription:
          limitationDescription ?? this.limitationDescription,
      hasGaranty: hasGaranty ?? this.hasGaranty,
      isSubscribedByNationalCode:
          isSubscribedByNationalCode ?? this.isSubscribedByNationalCode,
      garantyStartDate: garantyStartDate ?? this.garantyStartDate,
      defectInfoProblemOrEzharCode:
          defectInfoProblemOrEzharCode ?? this.defectInfoProblemOrEzharCode,
      needImage: needImage ?? this.needImage,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
      isCustomerSelected: isServiceCustomer ?? true,
    );
  }

  EvaluationServiceModel toModel() {
    return EvaluationServiceModel(
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      serviceCategoryId: serviceCategoryId,
      serviceCategoryTitle: serviceCategoryTitle,
      serviceType: serviceType,
      hasSubscription: hasSubscription,
      productId: productId,
      defectInfoId: defectInfoId,
      defectInfoTitle: defectInfoTitle,
      evaluationLabors: evaluationLabors?.map((e) => e.toModel()).toList(),
      productTitle: productTitle,
      serviceCategoryCode: serviceCategoryCode,
      serviceCode: serviceCode,
      serviceTypeTitle: serviceTypeTitle,
      subscriptionId: subscriptionId,
      limitationDescription: limitationDescription,
      hasGaranty: hasGaranty,
      isSubscribedByNationalCode: isSubscribedByNationalCode,
      garantyStartDate: garantyStartDate,
      defectInfoProblemOrEzharCode: defectInfoProblemOrEzharCode,
      isCustomerSelected: isCustomerSelected,
      isImageMandatory: isImageMandatory,
    );
  }
}
