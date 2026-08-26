import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_post_response_entity.dart';

class EvaluationPostResponseModel extends EvaluationPostResponseEntity {
  const EvaluationPostResponseModel({super.id});

  factory EvaluationPostResponseModel.fromValue(dynamic value) {
    if (value == null) {
      return const EvaluationPostResponseModel();
    }

    if (value is Map) {
      final json = Map<String, dynamic>.from(value);
      final rawId = json['id'] ?? json['Id'];
      return EvaluationPostResponseModel(id: rawId?.toString());
    }

    return EvaluationPostResponseModel(id: value.toString());
  }

  factory EvaluationPostResponseModel.fromJson(Map<String, dynamic> json) {
    return EvaluationPostResponseModel.fromValue(json);
  }
}
