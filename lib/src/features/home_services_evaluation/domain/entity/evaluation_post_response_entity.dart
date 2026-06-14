import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_post_response_model.dart';

class EvaluationPostResponseEntity {
  final int? id;

  const EvaluationPostResponseEntity({this.id});

  EvaluationPostResponseEntity copyWith({final int? id}) {
    return EvaluationPostResponseEntity(id: id ?? this.id);
  }

  EvaluationPostResponseModel toModel() {
    return EvaluationPostResponseModel(id: id);
  }
}
