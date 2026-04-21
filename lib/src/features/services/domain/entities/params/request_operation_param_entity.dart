import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/params/request_operation_param_model.dart';

class RequestOperationParamEntity {
  final ServiceType serviceType;
  final int? requestId;
  final int? serviceRequestTrackCode;
  final int? pageSize;
  final int? page;

  const RequestOperationParamEntity({
    required this.serviceType,
    this.requestId,
    this.serviceRequestTrackCode,
    this.pageSize,
    this.page,
  });

  RequestOperationParamEntity copyWith({
    ServiceType? serviceType,
    int? serviceRequestTrackCode,
    int? requestId,
    int? pageSize,
    int? page,
  }) {
    return RequestOperationParamEntity(
      serviceType: serviceType ?? this.serviceType,
      serviceRequestTrackCode: requestId ?? this.serviceRequestTrackCode,
      requestId: requestId ?? this.requestId,
      pageSize: pageSize ?? this.pageSize,
      page: page ?? this.page,
    );
  }

  RequestOperationParamModel toModel() {
    return RequestOperationParamModel(
      serviceType: serviceType,
      serviceRequestTrackCode: serviceRequestTrackCode,
      requestId: requestId,
      pageSize: pageSize,
      page: page,
    );
  }
}
