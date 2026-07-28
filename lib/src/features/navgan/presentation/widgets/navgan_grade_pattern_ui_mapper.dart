import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_reference_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart'
    as grade_pattern_detail;
import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart'
    as grade_pattern_entity;
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

  grade_pattern_entity.GradePatternEntity toGradePatternFormEntity() {
    return grade_pattern_entity.GradePatternEntity(
      id: id ?? gradeId,
      code: code,
      name: name ?? gradeTitle,
      details: details.map((item) => item.toGradePatternDetail()).toList(),
      isActive: isActive ?? true,
    );
  }

  grade_pattern_detail.GradePatternDetailEntity toGradePatternDetail() {
    return grade_pattern_detail.GradePatternDetailEntity(
      gradeId: gradeId ?? id ?? 0,
      gradeCode: gradeCode ?? code?.toString() ?? '',
      gradeTitle: gradeTitle ?? name ?? '---',
      gradeCoefficient: gradeCoefficient ?? 0,
      managmentCommisionPercent: managmentCommisionPercent ?? 0,
    );
  }
}

extension NavganGradePatternReferenceUiMapper on GradePatternReferenceEntity {
  GradePatternUiModel toUiModel() {
    return GradePatternUiModel(
      id: id,
      title: gradePatternName ?? gradePatternCode?.toString() ?? '---',
      details: const [],
      isActive: isActive,
    );
  }
}
