import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_final_invoice_model.dart';

class EmdadgarFinalInvoiceEntity {
  const EmdadgarFinalInvoiceEntity();

  EmdadgarFinalInvoiceModel toModel() => const EmdadgarFinalInvoiceModel();
}

class EmdadgarFinalInvoicePageEntity {
  const EmdadgarFinalInvoicePageEntity({
    this.records,
    this.count,
  });

  final List<EmdadgarFinalInvoiceEntity>? records;
  final int? count;

  EmdadgarFinalInvoicePageModel toModel() {
    return EmdadgarFinalInvoicePageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }
}
