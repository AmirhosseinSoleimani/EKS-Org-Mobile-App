import 'package:eks_sana_plus_org/src/features/general_content/data/models/general_content_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_target_entity.dart';

class GeneralContentTargetModel extends GeneralContentTargetEntity {
  const GeneralContentTargetModel({
    super.targetType,
    super.operatorType,
    super.operatorText,
    super.targetTitle,
    super.targetCategoryTitle,
    super.targetBoundaryType,
    super.targetBoundaryTypeText,
    super.targetCategoryId,
    super.parentId,
    super.id,
  });

  factory GeneralContentTargetModel.fromJson(Map<String, dynamic> json) {
    return GeneralContentTargetModel(
      targetType: GeneralContentJsonHelper.integer(
        json['targetType'] ?? json['TargetType'],
      ),
      operatorType: GeneralContentJsonHelper.integer(
        json['operatorType'] ?? json['OperatorType'],
      ),
      operatorText: GeneralContentJsonHelper.string(
        json['operatorText'] ?? json['OperatorText'],
      ),
      targetTitle: GeneralContentJsonHelper.string(
        json['targetTitle'] ?? json['TargetTitle'],
      ),
      targetCategoryTitle: GeneralContentJsonHelper.string(
        json['targetCategoryTitle'] ?? json['TargetCategoryTitle'],
      ),
      targetBoundaryType: GeneralContentJsonHelper.integer(
        json['targetBoundaryType'] ?? json['TargetBoundaryType'],
      ),
      targetBoundaryTypeText: GeneralContentJsonHelper.string(
        json['targetBoundaryTypeText'] ?? json['TargetBoundaryTypeText'],
      ),
      targetCategoryId: GeneralContentJsonHelper.integer(
        json['targetCategoryId'] ?? json['TargetCategoryId'],
      ),
      parentId: GeneralContentJsonHelper.integer(
        json['parentId'] ?? json['ParentId'],
      ),
      id: GeneralContentJsonHelper.integer(json['id'] ?? json['Id']),
    );
  }
}
