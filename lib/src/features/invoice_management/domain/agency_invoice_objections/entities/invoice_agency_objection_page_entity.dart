import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_page_model.dart';
import 'invoice_agency_objection_entity.dart';

class InvoiceAgencyObjectionPageEntity {
  const InvoiceAgencyObjectionPageEntity({
    this.records,
    this.count,
  });

  final List<InvoiceAgencyObjectionEntity>? records;
  final int? count;

  InvoiceAgencyObjectionPageModel toModel() {
    return InvoiceAgencyObjectionPageModel(
      records: records?.map((item) => item.toModel()).toList(),
      count: count,
    );
  }
}
