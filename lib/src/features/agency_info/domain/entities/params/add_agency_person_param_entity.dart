import 'package:eks_sana_plus_org/src/features/agency_info/data/models/add_agency_person_request_model.dart';

class AddAgencyPersonParamEntity {
  const AddAgencyPersonParamEntity({
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

  AddAgencyPersonRequestModel toModel() {
    return AddAgencyPersonRequestModel(
      agencyInfoId: agencyInfoId,
      personInfoId: personInfoId,
      contractStartDate: contractStartDate,
      contractEndDate: contractEndDate,
      aidPersonMobile: aidPersonMobile,
      jobPosition: jobPosition,
      issuanceOnIdCard: issuanceOnIdCard,
      description: description,
      activityType: activityType,
      isActive: isActive,
    );
  }
}
