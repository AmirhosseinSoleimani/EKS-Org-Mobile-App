import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_param_model.dart';

class ServiceRequestParamEntity {
  const ServiceRequestParamEntity({
    this.serviceRequestId,
    this.serviceType,
  });

  final int? serviceRequestId;
  final ServiceType? serviceType;

  ServiceRequestParamModel toModel() {
    return ServiceRequestParamModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
    );
  }
}
