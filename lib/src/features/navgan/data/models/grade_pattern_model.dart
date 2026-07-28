import 'package:eks_sana_plus_org/src/features/navgan/data/models/navgan_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';

class GradePatternModel extends GradePatternEntity {
  const GradePatternModel({
    super.id,
    super.code,
    super.name,
    super.gradeId,
    super.gradeCode,
    super.gradeTitle,
    super.gradeCoefficient,
    super.managmentCommisionPercent,
    super.details,
    super.detailsJson,
    super.isActive,
    super.serviceTypeId,
    super.serviceTypeTitle,
    super.referenceId,
  });

  factory GradePatternModel.fromJson(Map<String, dynamic> json) {
    final details = NavganJsonHelper.mapList(json['details'] ?? json['Details'])
        .map(GradePatternModel.fromJson)
        .toList();

    return GradePatternModel(
      id: NavganJsonHelper.integer(json['id'] ?? json['Id']),
      code: NavganJsonHelper.integer(json['code'] ?? json['Code']),
      name: NavganJsonHelper.string(json['name'] ?? json['Name']),
      gradeId: NavganJsonHelper.integer(json['gradeId'] ?? json['GradeId']),
      gradeCode: NavganJsonHelper.string(json['gradeCode'] ?? json['GradeCode']),
      gradeTitle:
          NavganJsonHelper.string(json['gradeTitle'] ?? json['GradeTitle']),
      gradeCoefficient: NavganJsonHelper.decimal(
        json['gradeCoefficient'] ?? json['GradeCoefficient'],
      ),
      managmentCommisionPercent: NavganJsonHelper.decimal(
        json['managmentCommisionPercent'] ??
            json['ManagmentCommisionPercent'],
      ),
      details: details,
      detailsJson:
          NavganJsonHelper.string(json['detailsJson'] ?? json['DetailsJson']),
      isActive: NavganJsonHelper.boolean(json['isActive'] ?? json['IsActive']),
      serviceTypeId: NavganJsonHelper.integer(
        json['serviceTypeId'] ?? json['ServiceTypeId'],
      ),
      serviceTypeTitle: NavganJsonHelper.string(
        json['serviceTypeTitle'] ?? json['ServiceTypeTitle'],
      ),
      referenceId: NavganJsonHelper.integer(
        json['referenceId'] ??
            json['ReferenceId'] ??
            json['gradePatternReferenceId'] ??
            json['GradePatternReferenceId'],
      ),
    );
  }
}
