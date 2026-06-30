import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/service_evaluation_param_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/services_and_labors_and_parts_evaluation_payload_entity.dart';

class ServiceEvaluationParamEntity {
  final DateTime? assignDate;
  final int? cancelReasonDetailId;
  final int? cancelReasonId;
  final int? customerKilometer;
  final String? description;
  final double? distanceToCustomer;
  final DateTime? endWorkDate;
  final int? serviceRequestId;
  final ServiceType? serviceType;
  final int? productId;
  final String? garantyStartDate;

  final ServicesAndLaborsAndPartsEvaluationPayloadEntity?
  servicesAndLaborsAndPartsEvaluationPayload;

  const ServiceEvaluationParamEntity({
    this.serviceRequestId,
    this.cancelReasonId,
    this.cancelReasonDetailId,
    this.serviceType,
    this.assignDate,
    this.endWorkDate,
    this.customerKilometer,
    this.description,
    this.distanceToCustomer,
    this.servicesAndLaborsAndPartsEvaluationPayload,
    this.productId,
    this.garantyStartDate,
  });

  ServiceEvaluationParamEntity copyWith({
    int? serviceRequestId,
    int? cancelReasonId,
    int? cancelReasonDetailId,
    ServiceType? serviceType,
    DateTime? assignDate,
    DateTime? endWorkDate,
    int? customerKilometer,
    String? description,
    double? distanceToCustomer,
    ServicesAndLaborsAndPartsEvaluationPayloadEntity?
    servicesAndLaborsAndPartsEvaluationPayload,
    int? productId,
    String? garantyStartDate,
  }) {
    return ServiceEvaluationParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      cancelReasonId: cancelReasonId ?? this.cancelReasonId,
      cancelReasonDetailId: cancelReasonDetailId ?? this.cancelReasonDetailId,
      serviceType: serviceType ?? this.serviceType,
      assignDate: assignDate ?? this.assignDate,
      endWorkDate: endWorkDate ?? this.endWorkDate,
      customerKilometer: customerKilometer ?? this.customerKilometer,
      description: description ?? this.description,
      distanceToCustomer: distanceToCustomer ?? this.distanceToCustomer,
      servicesAndLaborsAndPartsEvaluationPayload:
          servicesAndLaborsAndPartsEvaluationPayload ??
          this.servicesAndLaborsAndPartsEvaluationPayload,
      productId: productId ?? this.productId,
      garantyStartDate: garantyStartDate ?? this.garantyStartDate,
    );
  }

  ServiceEvaluationParamModel toModel() =>
      ServiceEvaluationParamModel.fromEntity(this);
}