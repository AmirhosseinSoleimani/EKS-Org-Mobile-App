class ChangeAgencyStatusRequestModel {
  const ChangeAgencyStatusRequestModel({
    this.agencyInfoId,
    this.status,
  });

  final int? agencyInfoId;
  final bool? status;

  factory ChangeAgencyStatusRequestModel.fromJson(Map<String, dynamic> json) {
    return ChangeAgencyStatusRequestModel(
      agencyInfoId: json['AgencyInfoId'] is int
          ? json['AgencyInfoId'] as int
          : int.tryParse(json['AgencyInfoId']?.toString() ?? ''),
      status: json['Status'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'Status': status};
  }

  Map<String, dynamic> toQueryParameters() {
    return {'AgencyInfoId': agencyInfoId};
  }
}
