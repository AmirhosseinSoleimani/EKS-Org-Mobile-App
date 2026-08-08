import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/invoice_agency_objection_model.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/response_json_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_page_entity.dart';

class InvoiceAgencyObjectionPageModel
    extends InvoiceAgencyObjectionPageEntity {
  const InvoiceAgencyObjectionPageModel({
    super.records,
    super.count,
  });

  factory InvoiceAgencyObjectionPageModel.fromResponse(dynamic response) {
    final records = ResponseJsonReader.records(response)
        .map(InvoiceAgencyObjectionModel.fromJson)
        .toList();
    return InvoiceAgencyObjectionPageModel(
      records: records,
      count: ResponseJsonReader.count(response, records.length),
    );
  }
}
