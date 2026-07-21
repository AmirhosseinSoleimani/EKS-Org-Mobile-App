import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';

class GradePatternDetailModel extends GradePatternDetailEntity {
  const GradePatternDetailModel({
    required super.gradeId,
    required super.gradeCode,
    required super.gradeTitle,
    required super.gradeCoefficient,
    required super.managmentCommisionPercent,
  });

  factory GradePatternDetailModel.fromJson(Map<String, dynamic> json) {
    return GradePatternDetailModel(
      gradeId: _toInt(json['gradeId']) ?? 0,
      gradeCode: json['gradeCode']?.toString() ?? '',
      gradeTitle: json['gradeTitle']?.toString() ?? '',
      gradeCoefficient: _toNum(json['gradeCoefficient']) ?? 0,
      managmentCommisionPercent:
          _toNum(json['managmentCommisionPercent']) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gradeId': gradeId,
      'gradeCode': gradeCode,
      'gradeTitle': gradeTitle,
      'gradeCoefficient': gradeCoefficient,
      'managmentCommisionPercent': managmentCommisionPercent,
    };
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static num? _toNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    return num.tryParse(value.toString());
  }
}
