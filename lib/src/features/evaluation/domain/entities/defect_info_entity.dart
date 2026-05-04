
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/defect_info_model.dart';

class DefectInfoEntity {
  final int id;
  final int minCost;
  final int maxCost;
  final int estimatedTime;

  const DefectInfoEntity({
    required this.id,
    required this.minCost,
    required this.maxCost,
    required this.estimatedTime,
  });

  DefectInfoEntity copyWith({
    int? id,
    int? minCost,
    int? maxCost,
    int? estimatedTime,
  }) {

    return DefectInfoEntity(
      id: id ?? this.id,
      minCost: minCost ?? this.minCost,
      maxCost: maxCost ?? this.maxCost,
      estimatedTime: estimatedTime ?? this.estimatedTime,
    );

  }

  DefectInfoModel toModel() => DefectInfoModel(
    id: id,
    minCost: minCost,
    maxCost: maxCost,
    estimatedTime: estimatedTime,
  );

}