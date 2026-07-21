class PersonInfoSearchRequestModel {
  const PersonInfoSearchRequestModel({this.searchValue});

  final String? searchValue;

  factory PersonInfoSearchRequestModel.fromJson(Map<String, dynamic> json) {
    final filter = json['Filter'];
    final filters = filter is Map ? filter['Filters'] : null;
    String? searchValue;

    if (filters is List && filters.isNotEmpty && filters.first is Map) {
      searchValue = (filters.first as Map)['Value']?.toString();
    }

    return PersonInfoSearchRequestModel(searchValue: searchValue);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> filter(String field) {
      return {
        'Logic': 'and',
        'Filters': <dynamic>[],
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
          filter('firstName'),
          filter('lastName'),
          filter('nationalNumber'),
          filter('mobile'),
        ],
      },
      'Skip': 0,
      'PageSize': 0,
    };
  }
}
