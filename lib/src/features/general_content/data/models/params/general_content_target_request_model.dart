class GeneralContentTargetRequestModel {
  const GeneralContentTargetRequestModel({
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

  Map<String, dynamic> toJson() {
    return {
      'generalContentId': generalContentId,
      'target': {
        'operatorType': operatorType,
        if (parentId != null) 'parentId': parentId,
        'targetCategoryId': targetCategoryIds,
        'targetBoundaryType': targetBoundaryType,
        'targetType': targetType,
      },
    };
  }
}
