import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';

class ServiceRequestParamModel extends ServiceRequestParamEntity {
  const ServiceRequestParamModel({
    super.serviceRequestId,
    super.serviceType,
  });

  factory ServiceRequestParamModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestParamModel(
      serviceRequestId: json['serviceRequestId'],
      serviceType: json['serviceType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "serviceRequestId": serviceRequestId,
      "serviceType": serviceType,
    };
  }
}
