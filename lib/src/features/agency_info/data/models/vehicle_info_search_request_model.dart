class VehicleInfoSearchRequestModel {
  const VehicleInfoSearchRequestModel({this.searchValue});

  final String? searchValue;

  factory VehicleInfoSearchRequestModel.fromJson(Map<String, dynamic> json) {
    final filter = json['Filter'];
    final filters = filter is Map ? filter['Filters'] : null;
    String? searchValue;

    if (filters is List && filters.isNotEmpty && filters.first is Map) {
      searchValue = (filters.first as Map)['Value']?.toString();
    }

    return VehicleInfoSearchRequestModel(searchValue: searchValue);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> filter(String field) {
      return {
        'Field': field,
        'Operator': 'contains',
        'Value': searchValue,
      };
    }

    return {
      'Sort': <dynamic>[],
      'Filter': {
        'Logic': 'or',
        'Filters': [
          filter('chassisNumber'),
          filter('engineNumber'),
          filter('licensePlate'),
        ],
      },
      'Skip': 0,
      'PageSize': 0,
    };
  }
}
