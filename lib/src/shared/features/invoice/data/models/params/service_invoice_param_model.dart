import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/params/service_invoice_param_entity.dart';

class ServiceInvoiceParamModel extends ServiceInvoiceParamEntity {
  ServiceInvoiceParamModel({
    super.serviceRequestId,
    super.serviceType,
    super.invoiceStatus,
  });

  Map<String,dynamic> toJson() => {
    'ServiceType': serviceType,
    'ServiceRequestId': serviceRequestId,
        'invoiceStatus': invoiceStatus,
      };
}