class AgencyContractFilterRequestModel {
  const AgencyContractFilterRequestModel({
    this.pageSize,
    this.agencyId,
  });

  final int? pageSize;
  final int? agencyId;

  factory AgencyContractFilterRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final filter = json['Filter'];
    final filters = filter is Map ? filter['Filters'] : null;
    int? agencyId;

    if (filters is List) {
      for (final item in filters.whereType<Map>()) {
        if (item['Field']?.toString().toLowerCase() == 'agencyid') {
          agencyId = int.tryParse(item['Value']?.toString() ?? '');
          break;
        }
      }
    }

    return AgencyContractFilterRequestModel(
      pageSize: json['PageSize'] is int
          ? json['PageSize'] as int
          : int.tryParse(json['PageSize']?.toString() ?? ''),
      agencyId: agencyId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Sort': <dynamic>[],
      'Filter': {
        'Logic': 'and',
        'Filters': [
          {
            'Field': 'agencyId',
            'Operator': 'eq',
            'Value': agencyId?.toString(),
          },
        ],
      },
      'Skip': 0,
      'PageSize': pageSize,
    };
  }
}
