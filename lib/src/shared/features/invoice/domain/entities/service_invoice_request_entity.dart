import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/service_invoice_request_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/enums/invoice_type.dart';

class ServiceInvoiceRequestEntity {
  final int? serviceType;
  final int? serviceRequestId;
  final int? invoiceId;
  final InvoiceType? type;

  const ServiceInvoiceRequestEntity({
    this.serviceType,
    this.serviceRequestId,
    this.invoiceId,
    this.type,
  });

  ServiceInvoiceRequestModel toModel() {
    return ServiceInvoiceRequestModel(
      serviceType: serviceType,
      serviceRequestId: serviceRequestId,
      invoiceId: invoiceId,
    );
  }
}
