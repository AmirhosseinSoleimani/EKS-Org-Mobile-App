import 'package:eks_sana_plus_org/src/features/requests/data/models/params/cancel_request_param_model.dart';

class CancelRequestParam {
  final int serviceRequestId;
  final int cancelReasonId;
  final int serviceType;
  final String? description;

  const CancelRequestParam({
    required this.serviceRequestId,
    required this.cancelReasonId,
    required this.serviceType,
    this.description,
  });

  CancelRequestParam copyWith({
    int? serviceRequestId,
    int? cancelReasonId,
    int? serviceType,
    String? description,
  }) {
    return CancelRequestParam(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      cancelReasonId: cancelReasonId ?? this.cancelReasonId,
      serviceType: serviceType ?? this.serviceType,
      description: description ?? this.description,
    );
  }

  CancelRequestParamModel toModel() {
    return CancelRequestParamModel(
      serviceRequestId: serviceRequestId,
      cancelReasonId: cancelReasonId,
      description: description,
      serviceType: serviceType,
    );
  }
}
