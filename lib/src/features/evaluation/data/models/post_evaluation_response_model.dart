import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/post_evaluation_response_entity.dart';

class PostEvaluationResponseModel extends PostEvaluationResponseEntity {
  PostEvaluationResponseModel({super.id});

  PostEvaluationResponseModel.fromJson(dynamic json) {
    id = json;
  }
}
