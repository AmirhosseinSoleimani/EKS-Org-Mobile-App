import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/accept_evaluation_response_entity.dart';

class AcceptEvaluationResponseModel extends AcceptEvaluationResponseEntity {
  AcceptEvaluationResponseModel({super.id});

  AcceptEvaluationResponseModel.fromJson(dynamic json) {
    id = json;
  }
}
