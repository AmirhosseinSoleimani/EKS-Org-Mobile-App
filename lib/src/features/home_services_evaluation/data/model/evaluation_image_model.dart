

import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_image_entity.dart';

class EvaluationImageModel extends EvaluationImageEntity {
  EvaluationImageModel({
    super.imageBase64,
    super.type,
  });
  factory EvaluationImageModel.fromJson(Map<String, dynamic> json) {
    return EvaluationImageModel(
      imageBase64: json['imageBase64'],
      type: json['Type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageBase64': imageBase64,
      'Type': type,
    };
  }
}