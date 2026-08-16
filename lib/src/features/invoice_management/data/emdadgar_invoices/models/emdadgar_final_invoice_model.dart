import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_final_invoice_entity.dart';

class EmdadgarFinalInvoiceModel extends EmdadgarFinalInvoiceEntity {
  const EmdadgarFinalInvoiceModel();

  factory EmdadgarFinalInvoiceModel.fromJson(Map<String, dynamic> json) {
    return const EmdadgarFinalInvoiceModel();
  }
}

class EmdadgarFinalInvoicePageModel extends EmdadgarFinalInvoicePageEntity {
  const EmdadgarFinalInvoicePageModel({
    super.records,
    super.count,
  });

  factory EmdadgarFinalInvoicePageModel.fromResponse(dynamic response) {
    final records = ResponseJsonReader.records(response)
        .map(EmdadgarFinalInvoiceModel.fromJson)
        .toList();
    return EmdadgarFinalInvoicePageModel(
      records: records,
      count: ResponseJsonReader.count(response, records.length),
    );
  }
}
