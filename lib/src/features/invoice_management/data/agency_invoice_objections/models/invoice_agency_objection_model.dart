import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';

class InvoiceAgencyObjectionModel extends InvoiceAgencyObjectionEntity {
  const InvoiceAgencyObjectionModel({required super.id});

  factory InvoiceAgencyObjectionModel.fromJson(Map<String, dynamic> json) {
    return InvoiceAgencyObjectionModel(
      id: JsonValueReader.intValue(json['id']) ?? 0,
    );
  }
}
