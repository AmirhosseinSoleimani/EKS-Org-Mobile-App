class AddAgencyPersonRequestModel {
  const AddAgencyPersonRequestModel({
    required this.agencyInfoId,
    required this.personInfoId,
    required this.contractStartDate,
    this.contractEndDate,
    this.aidPersonMobile,
    required this.jobPosition,
    required this.issuanceOnIdCard,
    this.description,
    required this.activityType,
    required this.isActive,
  });

  final int agencyInfoId;
  final int personInfoId;
  final String contractStartDate;
  final String? contractEndDate;
  final String? aidPersonMobile;
  final String jobPosition;
  final bool issuanceOnIdCard;
  final String? description;
  final String activityType;
  final bool isActive;

  Map<String, dynamic> toJson() {
    return {
      'agencyInfoId': agencyInfoId,
      'personInfoId': personInfoId,
      'contractStartDate': contractStartDate,
      'contractEndDate': contractEndDate,
      'aidPersonMobile': aidPersonMobile,
      'jobPosition': jobPosition,
      'issuanceOnIdCard': false,
      'description': description,
      'activityType': activityType,
      'isActive': isActive,
    };
  }
}
