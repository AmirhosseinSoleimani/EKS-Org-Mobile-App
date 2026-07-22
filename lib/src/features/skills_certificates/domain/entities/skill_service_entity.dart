class SkillServiceEntity {
  final int? id;
  final String? title;
  final int? type;

  /// Selection flag returned by the current API contract.
  final bool? selected;

  /// Kept for compatibility with older responses that used selectable.
  final bool? selectable;

  final String? insertDateTimeJalali;
  final String? updateDateTimeJalali;
  final String? insertUserFullName;
  final String? updateUserFullName;

  const SkillServiceEntity({
    this.id,
    this.title,
    this.type,
    this.selected,
    this.selectable,
    this.insertDateTimeJalali,
    this.updateDateTimeJalali,
    this.insertUserFullName,
    this.updateUserFullName,
  });

  bool get isSelected => selected ?? selectable ?? false;

  String get displayTitle {
    final normalized = title?.trim();
    return normalized == null || normalized.isEmpty ? '---' : normalized;
  }
}
