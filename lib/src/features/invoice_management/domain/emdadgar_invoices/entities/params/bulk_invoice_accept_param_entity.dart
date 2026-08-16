import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_param_model.dart';

class BulkInvoiceAcceptParamEntity {
  const BulkInvoiceAcceptParamEntity({
    this.bulkAcceptItems,
  });

  final List<BulkInvoiceAcceptItemParamEntity>? bulkAcceptItems;

  BulkInvoiceAcceptParamModel toModel() {
    return BulkInvoiceAcceptParamModel(
      bulkAcceptItems: bulkAcceptItems,
    );
  }
}

class BulkInvoiceAcceptItemParamEntity {
  const BulkInvoiceAcceptItemParamEntity({
    this.serviceRequestId,
    this.emdadgarEvaluationId,
    this.invoiceId,
  });

  final int? serviceRequestId;
  final int? emdadgarEvaluationId;
  final int? invoiceId;

  BulkInvoiceAcceptItemParamModel toModel() {
    return BulkInvoiceAcceptItemParamModel(
      serviceRequestId: serviceRequestId,
      emdadgarEvaluationId: emdadgarEvaluationId,
      invoiceId: invoiceId,
    );
  }
}
