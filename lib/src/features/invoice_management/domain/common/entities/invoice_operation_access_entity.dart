import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/invoice_operation_access_model.dart';

class InvoiceOperationAccessEntity {
  const InvoiceOperationAccessEntity({
    this.batchConfirmation,
    this.hasAdminAccess,
    this.hasTechAccess,
    this.hasMaliAmaliatAccess,
  });

  final bool? batchConfirmation;
  final bool? hasAdminAccess;
  final bool? hasTechAccess;
  final bool? hasMaliAmaliatAccess;

  InvoiceOperationAccessModel toModel() {
    return InvoiceOperationAccessModel(
      batchConfirmation: batchConfirmation,
      hasAdminAccess: hasAdminAccess,
      hasTechAccess: hasTechAccess,
      hasMaliAmaliatAccess: hasMaliAmaliatAccess,
    );
  }
}
