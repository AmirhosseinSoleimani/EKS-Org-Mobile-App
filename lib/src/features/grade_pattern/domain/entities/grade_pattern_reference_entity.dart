class GradePatternReferenceEntity {
  const GradePatternReferenceEntity({
    this.id,
    this.gradePatternId,
    this.gradePatternCode,
    this.gradePatternName,
    this.serviceTypeId,
    this.serviceTypeTitle,
    this.refType,
    this.refId,
    this.isActive = true,
  });

  final int? id;
  final int? gradePatternId;
  final int? gradePatternCode;
  final String? gradePatternName;
  final int? serviceTypeId;
  final String? serviceTypeTitle;
  final int? refType;
  final int? refId;
  final bool isActive;
}
