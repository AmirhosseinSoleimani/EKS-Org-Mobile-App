import 'package:eks_sana_plus_org/src/features/evaluation/data/models/evaluation_service_model.dart';

class ServicesAndLaborsAndPartsEvaluationModel {
  final List<EvaluationServiceModel> evaluationServices;

  const ServicesAndLaborsAndPartsEvaluationModel({
    this.evaluationServices = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'evaluationServices': evaluationServices
          .map((item) => item.toJson())
          .toList(),
    };
  }
}
