import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_post_response_model.dart';

class EvaluationPostResponseEntity {
  final String? id;

  const EvaluationPostResponseEntity({this.id});

  EvaluationPostResponseEntity copyWith({final String? id}) {
    return EvaluationPostResponseEntity(id: id ?? this.id);
  }

  EvaluationPostResponseModel toModel() {
    return EvaluationPostResponseModel(id: id);
  }
}
