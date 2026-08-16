import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_record_page_model.dart';
import 'invoice_record_entity.dart';

class InvoiceRecordPageEntity {
  const InvoiceRecordPageEntity({
    this.records,
    this.count,
  });

  final List<InvoiceRecordEntity>? records;
  final int? count;

  InvoiceRecordPageModel toModel() {
    return InvoiceRecordPageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }
}
