import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_definite_invoice_entity.dart';

class EmdadgarDefiniteInvoiceModel extends EmdadgarDefiniteInvoiceEntity {
  const EmdadgarDefiniteInvoiceModel();

  factory EmdadgarDefiniteInvoiceModel.fromJson(Map<String, dynamic> json) {
    return const EmdadgarDefiniteInvoiceModel();
  }
}

class EmdadgarDefiniteInvoicePageModel
    extends EmdadgarDefiniteInvoicePageEntity {
  const EmdadgarDefiniteInvoicePageModel({
    super.records,
    super.count,
  });

  factory EmdadgarDefiniteInvoicePageModel.fromResponse(dynamic response) {
    final records = ResponseJsonReader.records(response)
        .map(EmdadgarDefiniteInvoiceModel.fromJson)
        .toList();
    return EmdadgarDefiniteInvoicePageModel(
      records: records,
      count: ResponseJsonReader.count(response, records.length),
    );
  }
}
