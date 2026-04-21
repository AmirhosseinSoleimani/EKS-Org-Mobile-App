import 'package:eks_sana_plus_org/src/features/services/data/models/params/service_request_param_model.dart';

class ServiceRequestParamEntity {
  final int? serviceRequestId;
  final int? serviceType;

  const ServiceRequestParamEntity({
    this.serviceRequestId,
    this.serviceType,
  });

  ServiceRequestParamEntity copyWith({
    int? serviceRequestId,
    int? serviceType,
  }) {
    return ServiceRequestParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  ServiceRequestParamModel toModel() {
    return ServiceRequestParamModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
    );
  }
}
