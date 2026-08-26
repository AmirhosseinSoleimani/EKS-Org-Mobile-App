import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/cancel_reason_param_model.dart';

class CancelReasonParamEntity {
  final int type;
  final ServiceType serviceType;

  const CancelReasonParamEntity({
    required this.type,
    required this.serviceType,
  });

  CancelReasonParamModel toModel() {
    return CancelReasonParamModel(
      type: type,
      serviceType: serviceType,
    );
  }

  CancelReasonParamEntity copyWith({
    int? type,
    ServiceType? serviceType,
  }) {
    return CancelReasonParamEntity(
      type: type ?? this.type,
      serviceType: serviceType ?? this.serviceType,
    );
  }
}
