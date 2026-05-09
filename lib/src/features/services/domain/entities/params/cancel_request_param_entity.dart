import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/cancel_request_param_model.dart';

class CancelRequestParamEntity {
  final ServiceType serviceType;
  final int? serviceRequestId;
  final int? cancelReason;
  final int? cancelReasonDetailId;
  final String? cancelDesc;
  final bool? needCopy;

  const CancelRequestParamEntity({
    required this.serviceType,
    this.serviceRequestId,
    this.cancelReason,
    this.cancelReasonDetailId,
    this.cancelDesc,
    this.needCopy,
  });

  CancelRequestParamEntity copyWith({
    final ServiceType? serviceType,
    int? serviceRequestId,
    int? cancelReason,
    int? cancelReasonDetailId,
    String? cancelDesc,
    bool? needCopy,
  }) {
    return CancelRequestParamEntity(
      serviceType: serviceType ?? this.serviceType,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      cancelReason: cancelReason ?? this.cancelReason,
      cancelReasonDetailId:
      cancelReasonDetailId ?? this.cancelReasonDetailId,
      cancelDesc: cancelDesc ?? this.cancelDesc,
      needCopy: needCopy ?? this.needCopy,
    );
  }

  CancelRequestParamModel toModel() =>
      CancelRequestParamModel.fromEntity(this);
}
