import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_reference_entity.dart';

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
      id: _toInt(json['id'] ?? json['Id']),
      gradePatternId: _toInt(
        json['gradePatternId'] ?? json['GradePatternId'],
      ),
      gradePatternCode: _toInt(
        json['gradePatternCode'] ?? json['GradePatternCode'],
      ),
      gradePatternName: json['gradePatternName']?.toString() ??
          json['GradePatternName']?.toString() ??
          json['name']?.toString() ??
          json['Name']?.toString(),
      serviceTypeId: _toInt(json['serviceTypeId'] ?? json['ServiceTypeId']),
      serviceTypeTitle: json['serviceTypeTitle']?.toString() ??
          json['ServiceTypeTitle']?.toString() ??
          json['typeTitle']?.toString(),
      refType: _toInt(json['ref_Type'] ?? json['refType'] ?? json['RefType']),
      refId: _toInt(json['ref_Id'] ?? json['refId'] ?? json['RefId']),
      isActive: _toBool(json['isActive'] ?? json['IsActive']) ?? true,
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  static bool? _toBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    switch (value?.toString().toLowerCase()) {
      case 'true':
      case '1':
        return true;
      case 'false':
      case '0':
        return false;
    }
    return null;
  }
}
