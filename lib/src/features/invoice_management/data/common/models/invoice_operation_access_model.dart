import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_operation_access_entity.dart';

class InvoiceOperationAccessModel extends InvoiceOperationAccessEntity {
  const InvoiceOperationAccessModel({
    super.batchConfirmation,
    super.hasAdminAccess,
    super.hasTechAccess,
    super.hasMaliAmaliatAccess,
  });

  factory InvoiceOperationAccessModel.fromJson(Map<String, dynamic> json) {
    return InvoiceOperationAccessModel(
      batchConfirmation: JsonValueReader.boolValue(json['batchConfirmation']),
      hasAdminAccess: JsonValueReader.boolValue(json['hasAdminAccess']),
      hasTechAccess: JsonValueReader.boolValue(json['hasTechAccess']),
      hasMaliAmaliatAccess:
          JsonValueReader.boolValue(json['hasMaliAmaliatAccess']),
    );
  }
}
