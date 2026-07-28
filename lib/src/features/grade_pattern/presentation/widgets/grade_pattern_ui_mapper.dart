import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_ui_model.dart';

extension GradePatternUiMapper on GradePatternEntity {
  GradePatternUiModel toUiModel() {
    return GradePatternUiModel(
      id: id,
      title: name ?? '---',
      details: details.map((item) => item.toUiModel()).toList(),
      insertDateTimeJalali: insertDateTimeJalali,
      insertUserFullName: insertUserFullName,
      isActive: isActive,
    );
  }
}

extension GradePatternDetailUiMapper on GradePatternDetailEntity {
  GradePatternLevelUiModel toUiModel() {
    return GradePatternLevelUiModel(
      title: gradeTitle,
      coefficient: gradeCoefficient,
      managementCommissionPercent: managmentCommisionPercent,
    );
  }
}
