import 'package:eks_sana_plus_org/src/common/constants/reason_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/cancel_reason_param_model.dart';

class CancelReasonParamEntity {
  final int? reasonId;
  final ServiceType serviceType;
  final ReasonType reasonType;
  const CancelReasonParamEntity({
    required this.serviceType,
    required this.reasonType,
    this.reasonId,
  });

  CancelReasonParamModel toModel() {
    return CancelReasonParamModel(
      reasonId: reasonId,
      reasonType: reasonType,
      serviceType: serviceType,
    );
  }

  CancelReasonParamEntity copyWith({
    int? reasonId,
    ServiceType? serviceType,
    ReasonType? reasonType,
  }) {
    return CancelReasonParamEntity(
      reasonId: reasonId ?? this.reasonId,
      serviceType: serviceType ?? this.serviceType,
      reasonType: reasonType ?? this.reasonType,
    );
  }
}
