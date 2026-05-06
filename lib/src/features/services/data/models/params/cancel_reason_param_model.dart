import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';

class CancelReasonParamModel extends CancelReasonParamEntity {
  const CancelReasonParamModel({super.reasonId});

  factory CancelReasonParamModel.fromJson(Map<String, dynamic> json) {
    return CancelReasonParamModel(reasonId: json['reasonId'] as int?);
  }

  Map<String, dynamic> toJson() {
    return {'reasonId': reasonId};
  }
}
