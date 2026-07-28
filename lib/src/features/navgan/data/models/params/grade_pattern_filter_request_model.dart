class GradePatternFilterRequestModel {
  const GradePatternFilterRequestModel({
    this.skip = 0,
    this.pageSize,
    this.filters = const [
      GradePatternFilterModel(
        field: 'isActive',
        operator: 'eq',
        value: 'true',
      ),
    ],
  });

  final int skip;
  final int? pageSize;
  final List<GradePatternFilterModel> filters;

  Map<String, dynamic> toJson() {
    return {
      'Sort': const [],
      if (pageSize != null) 'PageSize': pageSize,
      if (skip > 0) 'Skip': skip,
      'Filter': {
        'Logic': 'and',
        'Filters': filters.map((item) => item.toJson()).toList(),
      },
    };
  }
}

class GradePatternFilterModel {
  const GradePatternFilterModel({
    required this.field,
    required this.value,
    this.operator = 'contains',
  });

  final String field;
  final String value;
  final String operator;

  Map<String, dynamic> toJson() {
    return {
      'Field': field,
      'Operator': operator,
      'Value': value,
    };
  }
}
