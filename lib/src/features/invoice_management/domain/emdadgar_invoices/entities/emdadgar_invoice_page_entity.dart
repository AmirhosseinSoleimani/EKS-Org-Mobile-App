import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_invoice_page_model.dart';
import 'emdadgar_invoice_record_entity.dart';

class EmdadgarInvoicePageEntity {
  const EmdadgarInvoicePageEntity({
    this.records,
    this.count,
  });

  final List<EmdadgarInvoiceRecordEntity>? records;
  final int? count;

  EmdadgarInvoicePageModel toModel() {
    return EmdadgarInvoicePageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }
}
