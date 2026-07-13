class AgencyInfoFilterRequestModel {
  const AgencyInfoFilterRequestModel({
    this.skip = 0,
    this.pageSize = 10,
    this.filters = const [],
  });

  final int skip;
  final int pageSize;
  final List<AgencyInfoFilterModel> filters;

  Map<String, dynamic> toJson() {
    return {
      'Skip': skip,
      'PageSize': pageSize,
      'Filter': {
        'Logic': 'and',
        'Filters': filters.map((item) => item.toJson()).toList(),
      },
    };
  }
}

class AgencyInfoFilterModel {
  const AgencyInfoFilterModel({
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
