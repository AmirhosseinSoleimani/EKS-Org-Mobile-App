import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_model.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';

class GradePatternEntity {
  const GradePatternEntity({
    this.id,
    this.code,
    this.name,
    this.details = const [],
    this.isActive = true,
  });

  final int? id;
  final int? code;
  final String? name;
  final List<GradePatternDetailEntity> details;
  final bool isActive;

  GradePatternEntity copyWith({
    int? id,
    int? code,
    String? name,
    List<GradePatternDetailEntity>? details,
    bool? isActive,
  }) {
    return GradePatternEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      details: details ?? this.details,
      isActive: isActive ?? this.isActive,
    );
  }

  GradePatternModel toModel() {
    return GradePatternModel(
      id: id,
      code: code,
      name: name,
      details: details.map((item) => item.toModel()).toList(),
      isActive: isActive,
    );
  }
}
