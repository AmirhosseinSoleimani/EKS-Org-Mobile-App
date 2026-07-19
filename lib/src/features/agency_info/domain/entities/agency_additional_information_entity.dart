import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_additional_information_model.dart';

class AgencyAdditionalInformationEntity {
  const AgencyAdditionalInformationEntity({
    this.agencyNationalId,
    this.trackingNumber,
    this.detailedCode,
    this.taxFileCompleted,
  });

  final String? agencyNationalId;
  final String? trackingNumber;
  final String? detailedCode;
  final bool? taxFileCompleted;

  AgencyAdditionalInformationModel toModel() {
    return AgencyAdditionalInformationModel(
      agencyNationalId: agencyNationalId,
      trackingNumber: trackingNumber,
      detailedCode: detailedCode,
      taxFileCompleted: taxFileCompleted,
    );
  }

  AgencyAdditionalInformationEntity copyWith({
    String? agencyNationalId,
    String? trackingNumber,
    String? detailedCode,
    bool? taxFileCompleted,
  }) {
    return AgencyAdditionalInformationEntity(
      agencyNationalId: agencyNationalId ?? this.agencyNationalId,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      detailedCode: detailedCode ?? this.detailedCode,
      taxFileCompleted: taxFileCompleted ?? this.taxFileCompleted,
    );
  }
}
