import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/bulk_invoice_accept_result_model.dart';

class BulkInvoiceAcceptResultEntity {
  const BulkInvoiceAcceptResultEntity({
    this.totalCount,
    this.succeedCount,
    this.failuresCount,
    this.alreadyGeneratedInvoicesCount,
    this.messageList,
  });

  final int? totalCount;
  final int? succeedCount;
  final int? failuresCount;
  final int? alreadyGeneratedInvoicesCount;
  final List<String>? messageList;

  BulkInvoiceAcceptResultModel toModel() {
    return BulkInvoiceAcceptResultModel(
      totalCount: totalCount,
      succeedCount: succeedCount,
      failuresCount: failuresCount,
      alreadyGeneratedInvoicesCount: alreadyGeneratedInvoicesCount,
      messageList: messageList,
    );
  }
}
