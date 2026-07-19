class AgencyInfoIdRequestModel {
  const AgencyInfoIdRequestModel({this.agencyInfoId});

  final int? agencyInfoId;

  factory AgencyInfoIdRequestModel.fromJson(Map<String, dynamic> json) {
    return AgencyInfoIdRequestModel(
      agencyInfoId: json['AgencyInfoId'] is int
          ? json['AgencyInfoId'] as int
          : int.tryParse(json['AgencyInfoId']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {'AgencyInfoId': agencyInfoId};
  }

  Map<String, dynamic> toFilterJson() {
    return {
      'Sort': <dynamic>[],
      'Filter': {
        'Logic': 'and',
        'Filters': [
          {
            'Field': 'AgencyInfoId',
            'Operator': 'eq',
            'Value': agencyInfoId?.toString(),
          },
        ],
      },
    };
  }
}
