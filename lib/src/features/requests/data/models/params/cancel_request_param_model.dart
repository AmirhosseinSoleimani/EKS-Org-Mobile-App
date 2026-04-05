import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/cancel_request_param.dart';


class CancelRequestParamModel extends CancelRequestParam {
  const CancelRequestParamModel({
    required super.serviceRequestId,
    required super.cancelReasonId,
    required super.serviceType,
    super.description,
  });

  factory CancelRequestParamModel.fromJson(Map<String, dynamic> json) {
    return CancelRequestParamModel(
      cancelReasonId: json['ReasonId'] ?? 0,
      description: json['Description'],
      serviceType: json['serviceType'] ?? 0,
      serviceRequestId: json['ServiceRequestId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ReasonId': cancelReasonId,
      'Description': description,
      'serviceType': serviceType,
      'ServiceRequestId': serviceRequestId,
    };
  }
}
