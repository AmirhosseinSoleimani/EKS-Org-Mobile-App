import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_json_helper.dart';
import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/agency_additional_information_entity.dart';

class AgencyAdditionalInformationModel extends AgencyAdditionalInformationEntity {
  const AgencyAdditionalInformationModel({
    super.agencyNationalId,
    super.trackingNumber,
    super.detailedCode,
    super.taxFileCompleted,
  });

  factory AgencyAdditionalInformationModel.fromJson(Map<String, dynamic> json) {
    return AgencyAdditionalInformationModel(
      agencyNationalId: AgencyInfoJsonHelper.string(json['agencyNationalId']),
      trackingNumber: AgencyInfoJsonHelper.string(json['trackingNumber']),
      detailedCode: AgencyInfoJsonHelper.string(json['detailedCode']),
      taxFileCompleted: AgencyInfoJsonHelper.boolean(json['taxFileCompleted']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'agencyNationalId': agencyNationalId,
      'trackingNumber': trackingNumber,
      'detailedCode': detailedCode,
      'taxFileCompleted': taxFileCompleted,
    };
  }
}
