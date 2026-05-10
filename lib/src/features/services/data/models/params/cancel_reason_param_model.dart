import 'package:eks_sana_plus_org/src/common/constants/reason_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';

class CancelReasonParamModel extends CancelReasonParamEntity {
  const CancelReasonParamModel({
    super.reasonId,
    required super.reasonType,
    required super.serviceType,
  });

  factory CancelReasonParamModel.fromJson(Map<String, dynamic> json) {
    return CancelReasonParamModel(
      reasonId: json['reasonId'] as int?,
      reasonType: ReasonType.fromValue(json['type'] as int?),
      serviceType: ServiceType.fromValue( json['serviceType'] as int?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reasonId': reasonId,
      'type': reasonType.value,

    };
  }
}
