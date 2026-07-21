import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_detail_model.dart';

class GradePatternDetailEntity {
  const GradePatternDetailEntity({
    required this.gradeId,
    required this.gradeCode,
    required this.gradeTitle,
    required this.gradeCoefficient,
    required this.managmentCommisionPercent,
  });

  final int gradeId;
  final String gradeCode;
  final String gradeTitle;
  final num gradeCoefficient;
  final num managmentCommisionPercent;

  GradePatternDetailEntity copyWith({
    int? gradeId,
    String? gradeCode,
    String? gradeTitle,
    num? gradeCoefficient,
    num? managmentCommisionPercent,
  }) {
    return GradePatternDetailEntity(
      gradeId: gradeId ?? this.gradeId,
      gradeCode: gradeCode ?? this.gradeCode,
      gradeTitle: gradeTitle ?? this.gradeTitle,
      gradeCoefficient: gradeCoefficient ?? this.gradeCoefficient,
      managmentCommisionPercent:
          managmentCommisionPercent ?? this.managmentCommisionPercent,
    );
  }

  GradePatternDetailModel toModel() {
    return GradePatternDetailModel(
      gradeId: gradeId,
      gradeCode: gradeCode,
      gradeTitle: gradeTitle,
      gradeCoefficient: gradeCoefficient,
      managmentCommisionPercent: managmentCommisionPercent,
    );
  }
}
