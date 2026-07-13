class PlanFilterParamModel {
  final int skip;
  final int pageSize;
  final String? title;
  final bool? isActive;
  final String? emdadUnitName;
  final String? shiftTitle;
  final String? specialPlanTitle;
  final int? seatType;
  final String? locationTitle;
  final String? fromDate;
  final String? toDate;

  const PlanFilterParamModel({
    required this.skip,
    required this.pageSize,
    this.title,
    this.isActive,
    this.emdadUnitName,
    this.shiftTitle,
    this.specialPlanTitle,
    this.seatType,
    this.locationTitle,
    this.fromDate,
    this.toDate,
  });

  Map<String, dynamic> toJson() {
    final filters = <Map<String, dynamic>>[];

    void addTextFilter(String field, String? value) {
      final normalized = value?.trim();
      if (normalized == null || normalized.isEmpty) return;

      filters.add({
        'Field': field,
        'Operator': 'contains',
        'Value': normalized,
      });
    }

    void addEqFilter(String field, Object? value) {
      if (value == null) return;

      filters.add({
        'Field': field,
        'Operator': 'eq',
        'Value': value.toString(),
      });
    }

    addTextFilter('title', title);
    addEqFilter('isActive', isActive);
    addTextFilter('emdadUnitName', emdadUnitName);
    addTextFilter('shiftTitle', shiftTitle);
    addTextFilter('specialPlanTitle', specialPlanTitle);
    addEqFilter('seatType', seatType);
    addTextFilter('locationTitle', locationTitle);
    addTextFilter('fromDate', fromDate);
    addTextFilter('toDate', toDate);

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
