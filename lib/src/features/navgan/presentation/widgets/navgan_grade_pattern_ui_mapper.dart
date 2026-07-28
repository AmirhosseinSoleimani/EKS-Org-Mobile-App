import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_ui_model.dart';

extension NavganGradePatternUiMapper on GradePatternEntity {
  GradePatternUiModel toUiModel() {
    return GradePatternUiModel(
      id: id ?? gradeId,
      title: name ?? gradeTitle ?? gradeCode ?? code?.toString() ?? '---',
      details: details.map((item) => item.toUiLevelModel()).toList(),
      isActive: isActive ?? true,
    );
  }

  GradePatternLevelUiModel toUiLevelModel() {
    return GradePatternLevelUiModel(
      title: gradeTitle ?? name ?? gradeCode ?? '---',
      coefficient: gradeCoefficient ?? 0,
      managementCommissionPercent: managmentCommisionPercent ?? 0,
    );
  }
}
