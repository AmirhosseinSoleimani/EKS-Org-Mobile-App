import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/bulk_invoice_accept_result_entity.dart';

class BulkInvoiceAcceptResultModel extends BulkInvoiceAcceptResultEntity {
  const BulkInvoiceAcceptResultModel({
    super.totalCount,
    super.succeedCount,
    super.failuresCount,
    super.alreadyGeneratedInvoicesCount,
    super.messageList,
  });

  factory BulkInvoiceAcceptResultModel.fromResponse(dynamic response) {
    final json = ResponseJsonReader.object(response);
    final rawMessages = json['messageList'];
    return BulkInvoiceAcceptResultModel(
      totalCount: JsonValueReader.intValue(json['totalCount']),
      succeedCount: JsonValueReader.intValue(json['succeedCount']),
      failuresCount: JsonValueReader.intValue(json['failuresCount']),
      alreadyGeneratedInvoicesCount:
          JsonValueReader.intValue(json['alreadyGeneratedInvoicesCount']),
      messageList: rawMessages is List
          ? rawMessages.map((item) => item.toString()).toList()
          : null,
    );
  }
}
