import 'package:eks_sana_plus_org/src/features/evaluation/data/models/post_evaluation_response_model.dart';

class PostEvaluationResponseEntity {
  PostEvaluationResponseEntity({this.id});

  String? id;

  PostEvaluationResponseEntity copyWith({String? id}) {
    return PostEvaluationResponseEntity(id: id ?? this.id);
  }

  PostEvaluationResponseModel toModel() {
    return PostEvaluationResponseModel(id: id);
  }
}
