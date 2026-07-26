class AddAgencyVehicleRequestModel {
  const AddAgencyVehicleRequestModel({
    required this.agencyInfoId,
    required this.vehicleInfoId,
    required this.contractCode,
    required this.contractType,
    required this.contractStartDate,
    this.contractEndDate,
    this.startBimeDate,
    this.endBimeDate,
    this.replacementDate,
    required this.isActive,
    required this.labelAgencyCode,
  });

  final int agencyInfoId;
  final int vehicleInfoId;
  final String contractCode;
  final int contractType;
  final String contractStartDate;
  final String? contractEndDate;
  final String? startBimeDate;
  final String? endBimeDate;
  final String? replacementDate;
  final bool isActive;
  final String labelAgencyCode;

  Map<String, dynamic> toJson() {
    return {
      'agencyInfoId': agencyInfoId,
      'vehicleInfoId': vehicleInfoId,
      'contractCode': contractCode,
      'contractType': contractType,
      'contractStartDate': contractStartDate,
      'contractEndDate': contractEndDate,
      'startBimeDate': startBimeDate,
      'endBimeDate': endBimeDate,
      'replacementDate': replacementDate,
      'isActive': isActive,
      'labelAgencyCode': labelAgencyCode,
    };
  }
}