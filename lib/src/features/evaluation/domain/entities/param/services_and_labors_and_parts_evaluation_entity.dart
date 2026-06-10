import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/services_and_labors_and_parts_evaluation_model.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/evaluation_service_entity.dart';

class ServicesAndLaborsAndPartsEvaluationEntity {
  final List<EvaluationServiceEntity> evaluationServices;

  const ServicesAndLaborsAndPartsEvaluationEntity({
    this.evaluationServices = const [],
  });

  ServicesAndLaborsAndPartsEvaluationEntity copyWith({
    List<EvaluationServiceEntity>? evaluationServices,
  }) {
    return ServicesAndLaborsAndPartsEvaluationEntity(
      evaluationServices: evaluationServices ?? this.evaluationServices,
    );
  }

  ServicesAndLaborsAndPartsEvaluationModel toModel() {
    return ServicesAndLaborsAndPartsEvaluationModel(
      evaluationServices:
      evaluationServices.map((item) => item.toModel()).toList(),
    );
  }
}