import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_request_param_entity.dart';

class CancelRequestParamModel extends CancelRequestParamEntity {
  const CancelRequestParamModel({
    required super.serviceType,
    super.serviceRequestId,
    super.cancelReason,
    super.cancelReasonDetailId,
    super.cancelDesc,
    super.needCopy,
  });

  factory CancelRequestParamModel.fromEntity(
      CancelRequestParamEntity entity) {
    return CancelRequestParamModel(
      serviceType: entity.serviceType,
      serviceRequestId: entity.serviceRequestId,
      cancelReason: entity.cancelReason,
      cancelReasonDetailId: entity.cancelReasonDetailId,
      cancelDesc: entity.cancelDesc,
      needCopy: entity.needCopy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ServiceRequestId": serviceRequestId,
      "CancelReason": cancelReason,
      "cancelReasonDetailId":
      cancelReasonDetailId == null || cancelReasonDetailId == 0
          ? ""
          : cancelReasonDetailId,
      "CancelDesc": cancelDesc,
      "NeedCopy": needCopy ?? false,
    };
  }
}
