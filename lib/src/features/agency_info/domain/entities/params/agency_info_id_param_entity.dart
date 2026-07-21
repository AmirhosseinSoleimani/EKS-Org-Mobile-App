import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_info_id_request_model.dart';

class AgencyInfoIdParamEntity {
  const AgencyInfoIdParamEntity({this.agencyInfoId});

  final int? agencyInfoId;

  AgencyInfoIdRequestModel toModel() {
    return AgencyInfoIdRequestModel(agencyInfoId: agencyInfoId);
  }

  AgencyInfoIdParamEntity copyWith({int? agencyInfoId}) {
    return AgencyInfoIdParamEntity(
      agencyInfoId: agencyInfoId ?? this.agencyInfoId,
    );
  }
}
