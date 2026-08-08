import 'emdadgar_invoice_record_entity.dart';

class EmdadgarInvoicePageEntity {
  const EmdadgarInvoicePageEntity({
    required this.records,
    required this.count,
  });

  final List<EmdadgarInvoiceRecordEntity> records;
  final int count;
}
