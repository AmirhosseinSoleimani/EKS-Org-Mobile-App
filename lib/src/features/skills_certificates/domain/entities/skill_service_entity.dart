class SkillServiceEntity {
  final int? id;
  final String? title;
  final int? type;
  final bool? selectable;
  final String? insertDateTimeJalali;
  final String? updateDateTimeJalali;
  final String? insertUserFullName;
  final String? updateUserFullName;

  const SkillServiceEntity({
    this.id,
    this.title,
    this.type,
    this.selectable,
    this.insertDateTimeJalali,
    this.updateDateTimeJalali,
    this.insertUserFullName,
    this.updateUserFullName,
  });

  bool get isSelected => selectable  ?? false;

  String get displayTitle {
    final normalized = title?.trim();
    return normalized == null || normalized.isEmpty ? '---' : normalized;
  }
}
