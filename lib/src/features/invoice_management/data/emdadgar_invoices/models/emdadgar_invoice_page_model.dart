import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_invoice_record_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_page_entity.dart';

class EmdadgarInvoicePageModel extends EmdadgarInvoicePageEntity {
  const EmdadgarInvoicePageModel({
    super.records,
    super.count,
  });

  factory EmdadgarInvoicePageModel.fromResponse(dynamic response) {
    final records = ResponseJsonReader.records(response)
        .map(EmdadgarInvoiceRecordModel.fromJson)
        .toList();
    return EmdadgarInvoicePageModel(
      records: records,
      count: ResponseJsonReader.count(response, records.length),
    );
  }
}
