class AgencyInfoFilterRequestModel {
  const AgencyInfoFilterRequestModel({
    this.skip = 0,
    this.pageSize = 10,
    this.filters = const [],
  });

  final int skip;
  final int pageSize;
  final List<AgencyInfoFilterModel> filters;

  factory AgencyInfoFilterRequestModel.fromJson(Map<String, dynamic> json) {
    final filter = json['Filter'];
    final filtersJson = filter is Map ? filter['Filters'] : null;

    return AgencyInfoFilterRequestModel(
      skip: json['Skip'] is int
          ? json['Skip'] as int
          : int.tryParse(json['Skip']?.toString() ?? '') ?? 0,
      pageSize: json['PageSize'] is int
          ? json['PageSize'] as int
          : int.tryParse(json['PageSize']?.toString() ?? '') ?? 10,
      filters: filtersJson is List
          ? filtersJson
              .whereType<Map>()
              .map(
                (item) => AgencyInfoFilterModel.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList()
          : const [],
    );
  }

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

  factory AgencyInfoFilterModel.fromJson(Map<String, dynamic> json) {
    return AgencyInfoFilterModel(
      field: json['Field']?.toString() ?? '',
      value: json['Value']?.toString() ?? '',
      operator: json['Operator']?.toString() ?? 'contains',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Field': field,
      'Operator': operator,
      'Value': value,
    };
  }
}
