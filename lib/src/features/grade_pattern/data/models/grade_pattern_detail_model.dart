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
      gradeId: _toInt(_read(json, 'gradeId', 'GradeId')) ?? 0,
      gradeCode: _read(json, 'gradeCode', 'GradeCode')?.toString() ?? '',
      gradeTitle: _read(json, 'gradeTitle', 'GradeTitle')?.toString() ?? '',
      gradeCoefficient:
          _toNum(_read(json, 'gradeCoefficient', 'GradeCoefficient')) ?? 0,
      managmentCommisionPercent:
          _toNum(_read(
                json,
                'managmentCommisionPercent',
                'ManagmentCommisionPercent',
              )) ??
              0,
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

  static dynamic _read(
    Map<String, dynamic> json,
    String camelCaseKey,
    String pascalCaseKey,
  ) {
    return json[camelCaseKey] ?? json[pascalCaseKey];
  }
}
