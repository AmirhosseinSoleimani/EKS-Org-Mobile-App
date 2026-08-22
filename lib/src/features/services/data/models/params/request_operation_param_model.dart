import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';

class RequestOperationParamModel extends RequestOperationParamEntity {
  const RequestOperationParamModel({
    required super.serviceType,
    super.requestId,
    super.serviceRequestTrackCode,
    super.pageSize,
    super.page,
  });

  factory RequestOperationParamModel.fromJson(Map<String, dynamic> json) {
    return RequestOperationParamModel(
      serviceType: json['serviceType'],
      requestId: json['serviceRequestId'],
      serviceRequestTrackCode: json['serviceRequestTrackCode'],
      pageSize: json['pageSize'],
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Sort': <Map<String, dynamic>>[],
      'Filter': {
        'Logic': 'and',
        'Filters': [
          {
            'Field': 'ServiceRequestId',
            'Operator': 'eq',
            'Value': requestId?.toString(),
          },
        ],
      },
      'serviceType': serviceType.value,
    };
  }

  Map<String, dynamic> toOperationJson() {
    return {
      'serviceType': serviceType.value,
      'serviceRequestId': requestId,
      'serviceRequestTrackCode': serviceRequestTrackCode,
      'pageSize': pageSize,
      'page': page,
    };
  }
}
