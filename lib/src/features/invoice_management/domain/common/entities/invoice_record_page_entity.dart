import 'invoice_record_entity.dart';

class InvoiceRecordPageEntity {
  const InvoiceRecordPageEntity({
    required this.records,
    required this.count,
  });

  final List<InvoiceRecordEntity> records;
  final int count;
}
