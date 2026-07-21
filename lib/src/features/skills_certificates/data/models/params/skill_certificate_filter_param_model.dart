class SkillCertificateFilterParamModel {
  final int skip;
  final int pageSize;
  final String? title;
  final bool? isActive;

  const SkillCertificateFilterParamModel({
    required this.skip,
    required this.pageSize,
    this.title,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    final filters = <Map<String, dynamic>>[];

    final normalizedTitle = title?.trim();
    if (normalizedTitle != null && normalizedTitle.isNotEmpty) {
      filters.add({
        'Field': 'title',
        'Operator': 'contains',
        'Value': normalizedTitle,
      });
    }

    if (isActive != null) {
      filters.add({
        'Field': 'isActive',
        'Operator': 'eq',
        'Value': isActive.toString(),
      });
    }

    return {
      'Skip': skip,
      'Take': pageSize,
      'PageSize': pageSize,
      'Filter': {
        'Logic': 'and',
        'Filters': filters,
      },
    };
  }
}
