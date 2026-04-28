import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/params/service_invoice_param_model.dart';

class ServiceInvoiceParamEntity {
  final int? serviceType;
  final int? serviceRequestId;
  final int invoiceStatus;

  const ServiceInvoiceParamEntity({
    this.serviceRequestId,
    this.serviceType,
    this.invoiceStatus = 0,
  });

  ServiceInvoiceParamModel toModel() {
    return ServiceInvoiceParamModel(
      serviceType: serviceType,
      serviceRequestId: serviceRequestId,
      invoiceStatus: invoiceStatus,
    );
  }
}
