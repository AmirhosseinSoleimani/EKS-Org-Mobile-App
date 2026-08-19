import 'package:eks_sana_plus_org/src/features/evaluation/data/models/services_and_labors_and_parts_evaluation_payload_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';

class ServiceEvaluationParamModel extends ServiceEvaluationParamEntity {
  const ServiceEvaluationParamModel({
    super.assignDate,
    super.cancelReasonDetailId,
    super.cancelReasonId,
    super.customerKilometer,
    super.description,
    super.distanceToCustomer,
    super.endWorkDate,
    super.serviceRequestId,
    super.serviceType,
    super.productId,
    super.garantyStartDate,
    super.servicesAndLaborsAndPartsEvaluationPayload,
  });

  factory ServiceEvaluationParamModel.fromEntity(
    ServiceEvaluationParamEntity entity,
  ) {
    return ServiceEvaluationParamModel(
      assignDate: entity.assignDate,
      cancelReasonDetailId: entity.cancelReasonDetailId,
      cancelReasonId: entity.cancelReasonId,
      customerKilometer: entity.customerKilometer,
      description: entity.description,
      distanceToCustomer: entity.distanceToCustomer,
      endWorkDate: entity.endWorkDate,
      serviceRequestId: entity.serviceRequestId,
      serviceType: entity.serviceType,
      productId: entity.productId,
      garantyStartDate: entity.garantyStartDate,
      servicesAndLaborsAndPartsEvaluationPayload:
          entity.servicesAndLaborsAndPartsEvaluationPayload,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "assignDate": JalaliDateHelper.formatServerDateTime(assignDate),
      "cancelReasonDetailId": cancelReasonDetailId,
      "cancelReasonId": cancelReasonId,
      "customerKilometer": customerKilometer,
      "description": description ?? "",
      "distanceToCustomer": distanceToCustomer ?? "",
      "endWorkDate": JalaliDateHelper.formatServerDateTime(endWorkDate),
      "serviceRequestId": serviceRequestId,
      "serviceType": serviceType?.value,
      "productId": productId,
      "garantyStartDate": garantyStartDate,
      "servicesAndLaborsAndPartsEvaluationPayload":
          servicesAndLaborsAndPartsEvaluationPayload == null
              ? null
              : ServicesAndLaborsAndPartsEvaluationPayloadModel.fromEntity(
                  servicesAndLaborsAndPartsEvaluationPayload!,
                ).toJson(),
    };
  }
}

