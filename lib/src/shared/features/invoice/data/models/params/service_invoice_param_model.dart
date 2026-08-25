import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';

class ServiceInvoiceParamModel extends ServiceInvoiceParamEntity {
  ServiceInvoiceParamModel({
    super.serviceRequestId,
    super.serviceType,
    super.emdadgarEvaluationId,
    super.invoiceStatus,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'ServiceType': serviceType,
    };

    if (serviceRequestId != null) {
      json['ServiceRequestId'] = serviceRequestId;
    }
    if (emdadgarEvaluationId != null) {
      json['emdadgarEvaluationId'] = emdadgarEvaluationId;
    }
    if (invoiceStatus != null) {
      json['invoiceStatus'] = invoiceStatus;
    }

    return json;
  }
}
