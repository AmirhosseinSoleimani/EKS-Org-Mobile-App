import 'package:eks_sana_plus_org/src/features/agency_info/data/models/add_agency_contract_request_model.dart';

class AddAgencyContractParamEntity {
  const AddAgencyContractParamEntity({
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

  AddAgencyContractRequestModel toModel() {
    return AddAgencyContractRequestModel(
      agencyId: agencyId,
      title: title,
      contractNo: contractNo,
      startDate: startDate,
      expireDate: expireDate,
      fileBase64: fileBase64,
      fileType: fileType,
    );
  }
}
