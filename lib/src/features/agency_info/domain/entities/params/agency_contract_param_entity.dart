import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_contract_filter_request_model.dart';

class AgencyContractParamEntity {
  const AgencyContractParamEntity({
    this.pageSize,
    this.agencyId,
  });

  final int? pageSize;
  final int? agencyId;

  AgencyContractFilterRequestModel toModel() {
    return AgencyContractFilterRequestModel(
      pageSize: pageSize,
      agencyId: agencyId,
    );
  }

  AgencyContractParamEntity copyWith({
    int? pageSize,
    int? agencyId,
  }) {
    return AgencyContractParamEntity(
      pageSize: pageSize ?? this.pageSize,
      agencyId: agencyId ?? this.agencyId,
    );
  }
}
