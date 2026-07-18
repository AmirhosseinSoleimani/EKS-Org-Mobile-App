import 'package:eks_sana_plus_org/src/features/agency_info/data/models/change_agency_status_request_model.dart';

class ChangeAgencyStatusParamEntity {
  const ChangeAgencyStatusParamEntity({
    this.agencyInfoId,
    this.status,
  });

  final int? agencyInfoId;
  final bool? status;

  ChangeAgencyStatusRequestModel toModel() {
    return ChangeAgencyStatusRequestModel(
      agencyInfoId: agencyInfoId,
      status: status,
    );
  }

  ChangeAgencyStatusParamEntity copyWith({
    int? agencyInfoId,
    bool? status,
  }) {
    return ChangeAgencyStatusParamEntity(
      agencyInfoId: agencyInfoId ?? this.agencyInfoId,
      status: status ?? this.status,
    );
  }
}
