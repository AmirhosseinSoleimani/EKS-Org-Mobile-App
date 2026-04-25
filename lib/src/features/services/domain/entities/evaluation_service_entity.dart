import 'package:eks_sana_plus_org/src/features/services/data/models/evaluation_service_model.dart';

class EvaluationServiceEntity {
  const EvaluationServiceEntity({
    this.serviceId,
    this.serviceTitle,
    this.serviceCode,
    this.isCustomerSelected,
    this.isImageMandatory = false,
    this.serviceCategoryId,
    this.serviceCategoryTitle,
    this.serviceCategoryCode,
    this.serviceType,
    this.serviceTypeTitle,
    this.workOrderCode,
    this.defectInfoId,
    this.defectInfoTitle,
    this.evaluationId,
    this.subscriptionId,
    this.hasSubscription = false,
    this.productId,
    this.productTitle,
    this.product,
    this.hasGaranty = false,
    this.garantyStartDate,
    this.isDeleted = false,
  });

  final int? serviceId;
  final String? serviceTitle;
  final String? serviceCode;
  final bool? isCustomerSelected;
  final bool isImageMandatory;
  final int? serviceCategoryId;
  final String? serviceCategoryTitle;
  final String? serviceCategoryCode;
  final int? serviceType;
  final String? serviceTypeTitle;
  final String? workOrderCode;
  final int? defectInfoId;
  final String? defectInfoTitle;
  final int? evaluationId;
  final int? subscriptionId;
  final bool hasSubscription;
  final int? productId;
  final String? productTitle;
  final dynamic product;
  final bool hasGaranty;
  final String? garantyStartDate;
  final bool isDeleted;

  EvaluationServiceEntity copyWith({
    int? serviceId,
    String? serviceTitle,
    String? serviceCode,
    bool? isCustomerSelected,
    bool? isImageMandatory,
    int? serviceCategoryId,
    String? serviceCategoryTitle,
    String? serviceCategoryCode,
    int? serviceType,
    String? serviceTypeTitle,
    String? workOrderCode,
    int? defectInfoId,
    String? defectInfoTitle,
    int? evaluationId,
    int? subscriptionId,
    bool? hasSubscription,
    int? productId,
    String? productTitle,
    dynamic product,
    bool? hasGaranty,
    String? garantyStartDate,
    bool? isDeleted,
  }) {
    return EvaluationServiceEntity(
      serviceId: serviceId ?? this.serviceId,
      serviceTitle: serviceTitle ?? this.serviceTitle,
      serviceCode: serviceCode ?? this.serviceCode,
      isCustomerSelected: isCustomerSelected ?? this.isCustomerSelected,
      isImageMandatory: isImageMandatory ?? this.isImageMandatory,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceCategoryTitle: serviceCategoryTitle ?? this.serviceCategoryTitle,
      serviceCategoryCode: serviceCategoryCode ?? this.serviceCategoryCode,
      serviceType: serviceType ?? this.serviceType,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
      workOrderCode: workOrderCode ?? this.workOrderCode,
      defectInfoId: defectInfoId ?? this.defectInfoId,
      defectInfoTitle: defectInfoTitle ?? this.defectInfoTitle,
      evaluationId: evaluationId ?? this.evaluationId,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      hasSubscription: hasSubscription ?? this.hasSubscription,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      product: product ?? this.product,
      hasGaranty: hasGaranty ?? this.hasGaranty,
      garantyStartDate: garantyStartDate ?? this.garantyStartDate,
    );
  }

  EvaluationServiceModel toModel() {
    return EvaluationServiceModel(
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      serviceCode: serviceCode,
      isCustomerSelected: isCustomerSelected,
      isImageMandatory: isImageMandatory,
      serviceCategoryId: serviceCategoryId,
      serviceCategoryTitle: serviceCategoryTitle,
      serviceCategoryCode: serviceCategoryCode,
      serviceType: serviceType,
      serviceTypeTitle: serviceTypeTitle,
      workOrderCode: workOrderCode,
      defectInfoId: defectInfoId,
      defectInfoTitle: defectInfoTitle,
      evaluationId: evaluationId,
      subscriptionId: subscriptionId,
      hasSubscription: hasSubscription,
      productId: productId,
      productTitle: productTitle,
      product: product,
      hasGaranty: hasGaranty,
      garantyStartDate: garantyStartDate,
      isDeleted: isDeleted,
    );
  }
}