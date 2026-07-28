import 'package:eks_sana_plus_org/src/features/general_content/data/models/params/general_content_target_request_model.dart';

class GeneralContentTargetParamEntity {
  const GeneralContentTargetParamEntity({
    required this.generalContentId,
    required this.operatorType,
    required this.targetCategoryIds,
    required this.targetBoundaryType,
    required this.targetType,
    this.parentId,
  });

  final int generalContentId;
  final int operatorType;
  final List<int> targetCategoryIds;
  final int targetBoundaryType;
  final int targetType;
  final int? parentId;

  GeneralContentTargetRequestModel toModel() {
    return GeneralContentTargetRequestModel(
      generalContentId: generalContentId,
      operatorType: operatorType,
      targetCategoryIds: targetCategoryIds,
      targetBoundaryType: targetBoundaryType,
      targetType: targetType,
      parentId: parentId,
    );
  }
}
