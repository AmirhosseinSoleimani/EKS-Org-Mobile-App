class GeneralContentTargetEntity {
  const GeneralContentTargetEntity({
    this.targetType,
    this.operatorType,
    this.operatorText,
    this.targetTitle,
    this.targetCategoryTitle,
    this.targetBoundaryType,
    this.targetBoundaryTypeText,
    this.targetCategoryId,
    this.parentId,
    this.id,
  });

  final int? targetType;
  final int? operatorType;
  final String? operatorText;
  final String? targetTitle;
  final String? targetCategoryTitle;
  final int? targetBoundaryType;
  final String? targetBoundaryTypeText;
  final int? targetCategoryId;
  final int? parentId;
  final int? id;

  bool get isIncluded => targetBoundaryType != 2;
}
