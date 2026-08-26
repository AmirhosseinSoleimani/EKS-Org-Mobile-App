import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/post_evaluation_response_entity.dart';

class PostEvaluationResponseModel extends PostEvaluationResponseEntity {
  PostEvaluationResponseModel({super.id});

  factory PostEvaluationResponseModel.fromValue(dynamic value) {
    if (value == null) {
      return PostEvaluationResponseModel();
    }

    if (value is Map) {
      final json = Map<String, dynamic>.from(value);
      final rawId = json['id'] ?? json['Id'];
      return PostEvaluationResponseModel(id: rawId?.toString());
    }

    return PostEvaluationResponseModel(id: value.toString());
  }

  factory PostEvaluationResponseModel.fromJson(Map<String, dynamic> json) {
    return PostEvaluationResponseModel.fromValue(json);
  }
}
