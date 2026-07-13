import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_reference_entity.dart';

class GradePatternReferenceModel extends GradePatternReferenceEntity {
  const GradePatternReferenceModel({
    super.id,
    super.gradePatternId,
    super.gradePatternCode,
    super.gradePatternName,
    super.serviceTypeId,
    super.serviceTypeTitle,
    super.refType,
    super.refId,
    super.isActive,
  });

  factory GradePatternReferenceModel.fromJson(Map<String, dynamic> json) {
    return GradePatternReferenceModel(
      id: _toInt(json['id']),
      gradePatternId: _toInt(json['gradePatternId']),
      gradePatternCode: _toInt(json['gradePatternCode']),
      gradePatternName:
          json['gradePatternName']?.toString() ?? json['name']?.toString(),
      serviceTypeId: _toInt(json['serviceTypeId']),
      serviceTypeTitle:
          json['serviceTypeTitle']?.toString() ?? json['typeTitle']?.toString(),
      refType: _toInt(json['ref_Type'] ?? json['refType']),
      refId: _toInt(json['ref_Id'] ?? json['refId']),
      isActive: json['isActive'] is bool ? json['isActive'] as bool : true,
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }
}
