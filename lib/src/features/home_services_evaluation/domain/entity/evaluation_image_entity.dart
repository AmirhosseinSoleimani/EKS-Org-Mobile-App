import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_image_model.dart';

class EvaluationImageEntity {
  final String? imageBase64;
  final int? type;

  EvaluationImageEntity({this.imageBase64, this.type});

  EvaluationImageEntity copyWith({String? imageBase64, int? type}) {
    return EvaluationImageEntity(
      imageBase64: imageBase64 ?? this.imageBase64,
      type: type ?? this.type,
    );
  }

  EvaluationImageModel toModel() {
    return EvaluationImageModel(imageBase64: imageBase64, type: type);
  }
}
