import 'package:eks_sana_plus_org/src/features/agency_info/domain/entities/params/agency_history_param_entity.dart';

class AgencyHistoryRequestModel  extends AgencyHistoryParamEntity{
  const AgencyHistoryRequestModel({
    super.refId,
    super.type = 1,
  });



  factory AgencyHistoryRequestModel.fromJson(Map<String, dynamic> json) {
    return AgencyHistoryRequestModel(
      refId: json['refId'] is int
          ? json['refId'] as int
          : int.tryParse(json['refId']?.toString() ?? ''),
      type: json['type'] is int
          ? json['type'] as int
          : int.tryParse(json['type']?.toString() ?? '') ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refId': refId,
      'type': type,
    };
  }
}
