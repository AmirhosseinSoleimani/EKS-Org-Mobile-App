

import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_post_response_entity.dart';

class EvaluationPostResponseModel extends EvaluationPostResponseEntity {
  const EvaluationPostResponseModel({
    super.id,
  });

  factory EvaluationPostResponseModel.fromJson(Map<String, dynamic> json) {
    return EvaluationPostResponseModel(
      id: json['id'].toString(),
    );
  }
}