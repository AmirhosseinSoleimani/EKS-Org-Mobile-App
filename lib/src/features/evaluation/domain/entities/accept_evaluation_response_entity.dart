import 'package:eks_sana_plus_org/src/features/evaluation/data/models/accept_evaluation_response_model.dart';

class AcceptEvaluationResponseEntity {
  AcceptEvaluationResponseEntity({this.id});

  int? id;

  AcceptEvaluationResponseEntity copyWith({int? id}) {
    return AcceptEvaluationResponseEntity(id: id ?? this.id);
  }

  AcceptEvaluationResponseModel toModel() {
    return AcceptEvaluationResponseModel(id: id);
  }
}
