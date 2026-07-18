import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_contract_entity.dart';

class AgencyContractModel extends AgencyContractEntity {
  const AgencyContractModel({
    super.id,
    super.agencyId,
    super.title,
    super.contractNo,
    super.contractGuid,
    super.fileBase64,
    super.fileType,
    super.fileTypeTitle,
    super.startDate,
    super.startDateJalali,
    super.expireDate,
    super.expireDateJalali,
  });

  factory AgencyContractModel.fromJson(Map<String, dynamic> json) {
    return AgencyContractModel(
      id: AgencyInfoJsonHelper.integer(json['id']),
      agencyId: AgencyInfoJsonHelper.integer(json['agencyId']),
      title: AgencyInfoJsonHelper.string(json['title']),
      contractNo: AgencyInfoJsonHelper.string(json['contractNo']),
      contractGuid: AgencyInfoJsonHelper.string(json['contractGuid']),
      fileBase64: AgencyInfoJsonHelper.string(json['fileBase64']),
      fileType: AgencyInfoJsonHelper.integer(json['fileType']),
      fileTypeTitle: AgencyInfoJsonHelper.string(json['fileTypeTitle']),
      startDate: AgencyInfoJsonHelper.string(json['startDate']),
      startDateJalali: AgencyInfoJsonHelper.string(json['startDateJalali']),
      expireDate: AgencyInfoJsonHelper.string(json['expireDate']),
      expireDateJalali: AgencyInfoJsonHelper.string(json['expireDateJalali']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'agencyId': agencyId,
      'title': title,
      'contractNo': contractNo,
      'contractGuid': contractGuid,
      'fileBase64': fileBase64,
      'fileType': fileType,
      'fileTypeTitle': fileTypeTitle,
      'startDate': startDate,
      'startDateJalali': startDateJalali,
      'expireDate': expireDate,
      'expireDateJalali': expireDateJalali,
    };
  }
}
