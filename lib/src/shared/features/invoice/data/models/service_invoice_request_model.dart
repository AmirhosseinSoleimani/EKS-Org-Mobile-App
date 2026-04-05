import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/service_invoice_request_entity.dart';

class ServiceInvoiceRequestModel extends ServiceInvoiceRequestEntity {
  ServiceInvoiceRequestModel({
    super.serviceRequestId,
    super.serviceType,
    super.invoiceId,
  });

  Map<String,dynamic> toJson() => {
    'ServiceType': serviceType,
    'ServiceRequestId': serviceRequestId,
    'EmdadgarEvaluationId': invoiceId,
  };
}