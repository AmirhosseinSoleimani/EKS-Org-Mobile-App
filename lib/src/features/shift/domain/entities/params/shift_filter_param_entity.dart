import 'package:eks_sana_plus_org/src/features/shift/data/models/shift_filter_request_model.dart';

class ShiftFilterParamEntity {
  const ShiftFilterParamEntity({
    this.title,
    this.type,
    this.startTime,
    this.endTime,
    this.isActive,
    this.skip = 0,
    this.pageSize = 10,
  });

  final String? title;
  final int? type;
  final String? startTime;
  final String? endTime;
  final bool? isActive;
  final int skip;
  final int pageSize;

  bool get hasActiveFilters {
    return title?.trim().isNotEmpty == true ||
        type != null ||
        startTime?.trim().isNotEmpty == true ||
        endTime?.trim().isNotEmpty == true ||
        isActive != null;
  }

  bool get hasSearchFilters {
    return title?.trim().isNotEmpty == true ||
        type != null ||
        startTime?.trim().isNotEmpty == true ||
        endTime?.trim().isNotEmpty == true;
  }

  ShiftFilterRequestModel toModel() {
    final filters = <ShiftFilterModel>[];
    final normalizedTitle = title?.trim();
    final normalizedStartTime = startTime?.trim();
    final normalizedEndTime = endTime?.trim();

    if (normalizedTitle != null && normalizedTitle.isNotEmpty) {
      filters.add(ShiftFilterModel(field: 'title', value: normalizedTitle));
    }
    if (type != null) {
      filters.add(ShiftFilterModel(
        field: 'type',
        operator: 'eq',
        value: type.toString(),
      ));
    }
    if (normalizedStartTime != null && normalizedStartTime.isNotEmpty) {
      filters.add(ShiftFilterModel(
        field: 'startTime',
        operator: 'gte',
        value: normalizedStartTime,
      ));
    }
    if (normalizedEndTime != null && normalizedEndTime.isNotEmpty) {
      filters.add(ShiftFilterModel(
        field: 'endTime',
        operator: 'lte',
        value: normalizedEndTime,
      ));
    }
    if (isActive != null) {
      filters.add(ShiftFilterModel(
        field: 'isActive',
        operator: 'eq',
        value: isActive.toString(),
      ));
    }

    return ShiftFilterRequestModel(
      skip: skip,
      pageSize: pageSize,
      filters: filters,
    );
  }

  ShiftFilterParamEntity copyWith({
    String? title,
    int? type,
    String? startTime,
    String? endTime,
    bool? isActive,
    bool clearType = false,
    bool clearIsActive = false,
    int? skip,
    int? pageSize,
  }) {
    return ShiftFilterParamEntity(
      title: title ?? this.title,
      type: clearType ? null : type ?? this.type,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isActive: clearIsActive ? null : isActive ?? this.isActive,
      skip: skip ?? this.skip,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
