class GradePatternReferenceParamEntity {
  const GradePatternReferenceParamEntity({
    required this.gradePatternId,
    required this.serviceTypeId,
    required this.refType,
    required this.refId,
    this.isActive = true,
  });

  final int gradePatternId;
  final int serviceTypeId;
  final int refType;
  final int refId;
  final bool isActive;

  Map<String, dynamic> toJson() {
    return {
      'gradePatternId': gradePatternId,
      'serviceTypeId': serviceTypeId,
      'ref_Type': refType,
      'ref_Id': refId,
      'isActive': isActive,
    };
  }
}
