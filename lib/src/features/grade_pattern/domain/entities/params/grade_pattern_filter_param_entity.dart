import 'package:eks_sana_plus_org/src/features/grade_pattern/data/models/grade_pattern_filter_request_model.dart';

class GradePatternFilterParamEntity {
  const GradePatternFilterParamEntity({
    this.name,
    this.isActive,
    this.skip = 0,
    this.pageSize = 10,
  });

  final String? name;
  final bool? isActive;
  final int skip;
  final int pageSize;

  bool get hasActiveFilters {
    return name?.trim().isNotEmpty == true || isActive != null;
  }

  GradePatternFilterRequestModel toModel() {
    final filters = <GradePatternFilterModel>[];
    final trimmedName = name?.trim();
    if (trimmedName != null && trimmedName.isNotEmpty) {
      filters.add(GradePatternFilterModel(field: 'name', value: trimmedName));
    }

    if (isActive != null) {
      filters.add(GradePatternFilterModel(
        field: 'isActive',
        operator: 'eq',
        value: isActive.toString(),
      ));
    }

    return GradePatternFilterRequestModel(
      skip: skip,
      pageSize: pageSize,
      filters: filters,
    );
  }

  GradePatternFilterParamEntity copyWith({
    String? name,
    bool? isActive,
    bool clearIsActive = false,
    int? skip,
    int? pageSize,
  }) {
    return GradePatternFilterParamEntity(
      name: name ?? this.name,
      isActive: clearIsActive ? null : isActive ?? this.isActive,
      skip: skip ?? this.skip,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
