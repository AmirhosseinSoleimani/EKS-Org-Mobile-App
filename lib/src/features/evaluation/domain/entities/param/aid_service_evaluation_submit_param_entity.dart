import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/aid_service_evaluation_submit_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/services_and_labors_and_parts_evaluation_entity.dart';

class AidServiceEvaluationSubmitParamEntity {
  final int? serviceRequestId;
  final ServiceType serviceType;
  final int? emdadgarId;
  final int? serviceCategoryId;
  final int? customerKilometer;
  final int? distanceToCustomer;

  final String? assignDate;
  final String? arriveDate;
  final String? endWorkDate;
  final bool confirmValidation;
  final bool representation;
  final int? defectInfoId;
  final String? description;
  final int? representaionCode;
  final int? distanceHamlCustomer;
  final int? acceptanceCode;
  final int? emdadgarEvaluationId;
  final int? emdadServiceCategoryId;
  final int? representationId;
  final bool? payAvarezi;


  final ServicesAndLaborsAndPartsEvaluationEntity
  servicesAndLaborsAndPartsEvaluationPayload;

  const AidServiceEvaluationSubmitParamEntity({
    required this.serviceType,
    this.serviceRequestId,
    this.emdadgarId,
    this.serviceCategoryId,
    this.customerKilometer,
    this.distanceToCustomer,
    this.assignDate,
    this.arriveDate,
    this.endWorkDate,
    this.confirmValidation = false,
    this.defectInfoId,
    this.description,
    this.representaionCode,
    this.acceptanceCode,
    this.representationId,
    this.representation= false,
    this.distanceHamlCustomer,
    this.emdadServiceCategoryId,
    this.emdadgarEvaluationId,
    this.payAvarezi,
    required this.servicesAndLaborsAndPartsEvaluationPayload,
  });

  AidServiceEvaluationSubmitParamEntity copyWith({
    int? serviceRequestId,
    ServiceType? serviceType,
    int? emdadgarId,
    int? serviceCategoryId,
    int? distanceHamlCustomer,
    int? customerKilometer,
    int? distanceToCustomer,
    String? assignDate,
    String? arriveDate,
    String? endWorkDate,
    bool? confirmValidation,
    bool? representation,
    int? defectInfoId,
    int? representaionCode,
    int? acceptanceCode,
    int? emdadServiceCategoryId,
    int? emdadgarEvaluationId,
    int? representationId,
    bool? payAvarezi,
    String? description,
    ServicesAndLaborsAndPartsEvaluationEntity?
    servicesAndLaborsAndPartsEvaluationPayload,
  }) {
    return AidServiceEvaluationSubmitParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
      emdadgarId: emdadgarId ?? this.emdadgarId,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      customerKilometer: customerKilometer ?? this.customerKilometer,
      distanceToCustomer: distanceToCustomer ?? this.distanceToCustomer,
      assignDate: assignDate ?? this.assignDate,
      arriveDate: arriveDate ?? this.arriveDate,
      endWorkDate: endWorkDate ?? this.endWorkDate,
      confirmValidation: confirmValidation ?? this.confirmValidation,
      defectInfoId: defectInfoId ?? this.defectInfoId,
      description: description ?? this.description,
      acceptanceCode: acceptanceCode ?? this.acceptanceCode,
      representaionCode: representaionCode ?? this.representaionCode,
      emdadServiceCategoryId: emdadServiceCategoryId ?? this.emdadServiceCategoryId,
      representation: representation ?? this.representation,
      representationId: representationId ?? this.representationId,
      distanceHamlCustomer: distanceHamlCustomer ?? this.distanceHamlCustomer,
      emdadgarEvaluationId: emdadgarEvaluationId ?? this.emdadgarEvaluationId,
      payAvarezi: payAvarezi ?? this.payAvarezi,
      servicesAndLaborsAndPartsEvaluationPayload:
      servicesAndLaborsAndPartsEvaluationPayload ??
          this.servicesAndLaborsAndPartsEvaluationPayload,
    );
  }

  AidServiceEvaluationSubmitParamModel toModel() {
    return AidServiceEvaluationSubmitParamModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      emdadgarId: emdadgarId,
      serviceCategoryId: serviceCategoryId,
      customerKilometer: customerKilometer,
      distanceToCustomer: distanceToCustomer,
      assignDate: assignDate,
      arriveDate: arriveDate,
      endWorkDate: endWorkDate,
      acceptanceCode: acceptanceCode,
      representationId: representationId,
      confirmValidation: confirmValidation,
      defectInfoId: defectInfoId,
      description: description,
      emdadServiceCategoryId: emdadServiceCategoryId,
      representation: representation,
      representaionCode: representaionCode,
      distanceHamlCustomer: distanceHamlCustomer,
      emdadgarEvaluationId: emdadgarEvaluationId,
      payAvarezi: payAvarezi,
      servicesAndLaborsAndPartsEvaluationPayload:
          servicesAndLaborsAndPartsEvaluationPayload,
    );
  }
}