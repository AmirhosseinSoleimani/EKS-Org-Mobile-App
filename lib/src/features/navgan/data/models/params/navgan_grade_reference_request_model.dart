class NavganGradeReferenceRequestModel {
  const NavganGradeReferenceRequestModel({
    required this.gradePatternId,
    required this.serviceTypeId,
    required this.refType,
    required this.refId,
    required this.isActive,
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
