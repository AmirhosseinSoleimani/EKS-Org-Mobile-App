import 'package:eks_sana_plus_org/src/features/evaluation/data/models/services_and_labors_and_parts_evaluation_payload_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/evaluation_service_entity.dart';

class ServicesAndLaborsAndPartsEvaluationPayloadEntity {
  final List<EvaluationServiceEntity>? evaluationServices;

  const ServicesAndLaborsAndPartsEvaluationPayloadEntity({
    this.evaluationServices,
  });

  ServicesAndLaborsAndPartsEvaluationPayloadEntity copyWith({
    List<EvaluationServiceEntity>? evaluationServices,
  }) {
    return ServicesAndLaborsAndPartsEvaluationPayloadEntity(
      evaluationServices: evaluationServices ?? this.evaluationServices,
    );
  }

  ServicesAndLaborsAndPartsEvaluationPayloadModel toModel() {
    return ServicesAndLaborsAndPartsEvaluationPayloadModel(
      evaluationServices: evaluationServices?.map((e) => e.toModel()).toList(),
    );
  }
}
