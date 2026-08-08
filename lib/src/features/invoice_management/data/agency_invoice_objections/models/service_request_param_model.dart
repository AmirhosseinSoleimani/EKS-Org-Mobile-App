import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/params/service_request_param_entity.dart';

class ServiceRequestParamModel extends ServiceRequestParamEntity {
  const ServiceRequestParamModel({
    super.serviceRequestId,
    super.serviceType,
  });

  factory ServiceRequestParamModel.fromEntity(ServiceRequestParamEntity entity) =>
      entity.toModel();

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'serviceRequestId': serviceRequestId,
      'serviceType': serviceType?.value,
    };
  }
}
