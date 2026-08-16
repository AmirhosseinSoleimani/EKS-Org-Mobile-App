import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_record_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_page_entity.dart';

class InvoiceRecordPageModel extends InvoiceRecordPageEntity {
  const InvoiceRecordPageModel({
    super.records,
    super.count,
  });

  factory InvoiceRecordPageModel.fromResponse(dynamic response) {
    final records = ResponseJsonReader.records(response)
        .map(InvoiceRecordModel.fromJson)
        .toList();
    return InvoiceRecordPageModel(
      records: records,
      count: ResponseJsonReader.count(response, records.length),
    );
  }
}
