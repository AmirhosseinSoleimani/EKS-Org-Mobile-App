class SkillCertificateListEntity {
  final List<SkillCertificateEntity> items;
  final int totalCount;

  const SkillCertificateListEntity({
    required this.items,
    required this.totalCount,
  });
}

class SkillCertificateEntity {
  final int? id;
  final String? title;
  final bool isActive;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTimeJalali;
  final String? updateDateTimeJalali;

  const SkillCertificateEntity({
    this.id,
    this.title,
    this.isActive = false,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTimeJalali,
    this.updateDateTimeJalali,
  });

  String get displayTitle {
    final normalized = title?.trim();
    return normalized == null || normalized.isEmpty ? '---' : normalized;
  }
}
