import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_definite_invoice_model.dart';

class EmdadgarDefiniteInvoiceEntity {
  const EmdadgarDefiniteInvoiceEntity();

  EmdadgarDefiniteInvoiceModel toModel() =>
      const EmdadgarDefiniteInvoiceModel();
}

class EmdadgarDefiniteInvoicePageEntity {
  const EmdadgarDefiniteInvoicePageEntity({
    this.records,
    this.count,
  });

  final List<EmdadgarDefiniteInvoiceEntity>? records;
  final int? count;

  EmdadgarDefiniteInvoicePageModel toModel() {
    return EmdadgarDefiniteInvoicePageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }
}
