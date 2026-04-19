import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';

class RequestOperationParamModel extends RequestOperationParamEntity {
  const RequestOperationParamModel({
    required super.serviceType,
    required super.requestId,
    super.pageSize,
    super.page,
  });

  factory RequestOperationParamModel.fromJson(Map<String, dynamic> json) {
    return RequestOperationParamModel(
      serviceType: json['serviceType'],
      requestId: json['serviceRequestId'],
      pageSize: json['pageSize'],
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "serviceType": serviceType.value,
      "serviceRequestId": requestId,
      "pageSize": pageSize,
      "page": page,
    };
  }
}
