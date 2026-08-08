import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_operation_access_entity.dart';

class InvoiceOperationAccessModel extends InvoiceOperationAccessEntity {
  const InvoiceOperationAccessModel({
    required super.batchConfirmation,
    required super.hasAdminAccess,
    required super.hasTechAccess,
    required super.hasMaliAmaliatAccess,
  });

  factory InvoiceOperationAccessModel.fromJson(Map<String, dynamic> json) {
    return InvoiceOperationAccessModel(
      batchConfirmation: JsonValueReader.boolValue(json['batchConfirmation']) ?? false,
      hasAdminAccess: JsonValueReader.boolValue(json['hasAdminAccess']) ?? false,
      hasTechAccess: JsonValueReader.boolValue(json['hasTechAccess']) ?? false,
      hasMaliAmaliatAccess:
          JsonValueReader.boolValue(json['hasMaliAmaliatAccess']) ?? false,
    );
  }
}
