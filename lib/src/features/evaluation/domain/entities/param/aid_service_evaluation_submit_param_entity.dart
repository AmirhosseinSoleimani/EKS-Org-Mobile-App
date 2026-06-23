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
  final int? defectInfoId;
  final String? description;

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
    required this.servicesAndLaborsAndPartsEvaluationPayload,
  });

  AidServiceEvaluationSubmitParamEntity copyWith({
    int? serviceRequestId,
    ServiceType? serviceType,
    int? emdadgarId,
    int? serviceCategoryId,
    int? customerKilometer,
    int? distanceToCustomer,
    String? assignDate,
    String? arriveDate,
    String? endWorkDate,
    bool? confirmValidation,
    int? defectInfoId,
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
      confirmValidation: confirmValidation,
      defectInfoId: defectInfoId,
      description: description,
      servicesAndLaborsAndPartsEvaluationPayload:
          servicesAndLaborsAndPartsEvaluationPayload,
    );
  }
}