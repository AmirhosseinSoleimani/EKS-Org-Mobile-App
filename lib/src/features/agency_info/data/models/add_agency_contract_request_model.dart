class AddAgencyContractRequestModel {
  const AddAgencyContractRequestModel({
    required this.agencyId,
    required this.title,
    required this.contractNo,
    required this.startDate,
    required this.expireDate,
    this.fileBase64,
    this.fileType,
  });

  final int agencyId;
  final String title;
  final String contractNo;
  final String startDate;
  final String expireDate;
  final String? fileBase64;
  final String? fileType;

  Map<String, dynamic> toJson() {
    return {
      'fileBase64': fileBase64,
      'fileType': fileType,
      'agencyId': agencyId,
      'title': title,
      'contractNo': contractNo,
      'startDate': startDate,
      'expireDate': expireDate,
    };
  }
}
