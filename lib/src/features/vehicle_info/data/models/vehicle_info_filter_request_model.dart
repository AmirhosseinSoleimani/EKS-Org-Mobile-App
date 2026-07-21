class VehicleInfoFilterRequestModel {
  const VehicleInfoFilterRequestModel({
    this.skip = 0,
    this.pageSize = 10,
    this.filters = const [],
  });

  final int skip;
  final int pageSize;
  final List<VehicleInfoFilterModel> filters;

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

class VehicleInfoFilterModel {
  const VehicleInfoFilterModel({
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
