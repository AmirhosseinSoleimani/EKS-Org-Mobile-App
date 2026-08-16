import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/params/bulk_invoice_accept_param_entity.dart';

class BulkInvoiceAcceptParamModel extends BulkInvoiceAcceptParamEntity {
  const BulkInvoiceAcceptParamModel({
    super.bulkAcceptItems,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'bulkAcceptItems': bulkAcceptItems
          ?.map((item) => item.toModel().toJson())
          .toList(),
    };
  }
}

class BulkInvoiceAcceptItemParamModel
    extends BulkInvoiceAcceptItemParamEntity {
  const BulkInvoiceAcceptItemParamModel({
    super.serviceRequestId,
    super.emdadgarEvaluationId,
    super.invoiceId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'serviceRequestId': serviceRequestId,
      'emdadgarEvaluationId': emdadgarEvaluationId,
      'invoiceId': invoiceId,
    };
  }
}
