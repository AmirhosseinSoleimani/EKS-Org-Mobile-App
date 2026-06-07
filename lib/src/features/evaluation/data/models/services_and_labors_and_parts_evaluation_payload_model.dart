import 'package:eks_sana_plus_org/src/features/evaluation/data/models/evaluation_service_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/services_and_labors_and_parts_evaluation_payload_entity.dart';

class ServicesAndLaborsAndPartsEvaluationPayloadModel
    extends ServicesAndLaborsAndPartsEvaluationPayloadEntity {
  const ServicesAndLaborsAndPartsEvaluationPayloadModel({
    super.evaluationServices,
  });

  factory ServicesAndLaborsAndPartsEvaluationPayloadModel.fromEntity(
    ServicesAndLaborsAndPartsEvaluationPayloadEntity entity,
  ) {
    return ServicesAndLaborsAndPartsEvaluationPayloadModel(
      evaluationServices: entity.evaluationServices
          ?.map((e) => e.toModel())
          .toList(),
    );
  }

  factory ServicesAndLaborsAndPartsEvaluationPayloadModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return ServicesAndLaborsAndPartsEvaluationPayloadModel(
      evaluationServices: (json['evaluationServices'] as List?)
          ?.map((e) => EvaluationServiceModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "evaluationServices": evaluationServices
          ?.map((element) => element.toModel().toJson())
          .toList(),
    };
  }
}
