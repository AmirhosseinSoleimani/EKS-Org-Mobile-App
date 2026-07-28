class GradePatternUiModel {
  const GradePatternUiModel({
    this.id,
    required this.title,
    required this.details,
    this.insertDateTimeJalali,
    this.insertUserFullName,
    this.isActive = true,
  });

  final int? id;
  final String title;
  final List<GradePatternLevelUiModel> details;
  final String? insertDateTimeJalali;
  final String? insertUserFullName;
  final bool isActive;
}

class GradePatternLevelUiModel {
  const GradePatternLevelUiModel({
    required this.title,
    required this.coefficient,
    required this.managementCommissionPercent,
  });

  final String title;
  final num coefficient;
  final num managementCommissionPercent;
}
