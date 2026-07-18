import 'package:eks_sana_plus_org/src/features/agency_info/data/models/agency_history_request_model.dart';

class AgencyHistoryParamEntity {
  const AgencyHistoryParamEntity({
    this.refId,
    this.type,
  });

  final int? refId;
  final int? type;

  AgencyHistoryRequestModel toModel() {
    return AgencyHistoryRequestModel(
      refId: refId,
      type: type,
    );
  }

  AgencyHistoryParamEntity copyWith({
    int? refId,
    int? type,
  }) {
    return AgencyHistoryParamEntity(
      refId: refId ?? this.refId,
      type: type ?? this.type,
    );
  }
}
