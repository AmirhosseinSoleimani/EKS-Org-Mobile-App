import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_operation_access_entity.dart';

class RequestOperationAccessModel extends RequestOperationAccessEntity {
  const RequestOperationAccessModel({
    super.cancel,
    super.cancelAfterAssign,
    super.cancelBeforeAssign,
    super.assign,
    super.assignCancel,
    super.lackOfCooperation,
    super.cartableCycle,
    super.followUp,
    super.invoiceCancel,
    super.customerInvoice,
    super.emdadgarInvoice,
    super.invoiceRegistration,
    super.externalEmdadNavgan,
    super.cancelExternalEmdadNavgan,
    super.serviceRequestCopy,
    super.evaluationHistory,
    super.invoiceModification,
    super.urgentServiceRequestCompleted,
    super.smsHistory,
    super.viewAssignHistory,
    super.canInsert,
    super.canView,
    super.canUpdate,
    super.canDelete,
    super.canExport,
    super.canPrint,
    super.canImport,
    super.canViewUserRole,
    super.canViewUserOperation,
    super.changeUserPassword,
  });

  factory RequestOperationAccessModel.fromJson(Map<String, dynamic> json) {
    bool readBool(String key) {
      final pascalKey = '${key[0].toUpperCase()}${key.substring(1)}';
      final value = json[key] ?? json[pascalKey];

      if (value is bool) return value;
      if (value is num) return value != 0;
      if (value is String) {
        final normalized = value.trim().toLowerCase();
        return normalized == 'true' || normalized == '1';
      }
      return false;
    }

    return RequestOperationAccessModel(
      cancel: readBool('cancel'),
      cancelAfterAssign: readBool('cancelAfterAssign'),
      cancelBeforeAssign: readBool('cancelBeforeAssign'),
      assign: readBool('assign'),
      assignCancel: readBool('assignCancel'),
      lackOfCooperation: readBool('lackOfCooperation'),
      cartableCycle: readBool('cartableCycle'),
      followUp: readBool('followUp'),
      invoiceCancel: readBool('invoiceCancel'),
      customerInvoice: readBool('customerInvoice'),
      emdadgarInvoice: readBool('emdadgarInvoice'),
      invoiceRegistration: readBool('invoiceRegistration'),
      externalEmdadNavgan: readBool('externalEmdadNavgan'),
      cancelExternalEmdadNavgan: readBool('cancelExternalEmdadNavgan'),
      serviceRequestCopy: readBool('serviceRequestCopy'),
      evaluationHistory: readBool('evaluationHistory'),
      invoiceModification: readBool('invoiceModification'),
      urgentServiceRequestCompleted: readBool('urgentServiceRequestCompleted'),
      smsHistory: readBool('smsHistory'),
      viewAssignHistory: readBool('viewAssignHistory'),
      canInsert: readBool('canInsert'),
      canView: readBool('canView'),
      canUpdate: readBool('canUpdate'),
      canDelete: readBool('canDelete'),
      canExport: readBool('canExport'),
      canPrint: readBool('canPrint'),
      canImport: readBool('canImport'),
      canViewUserRole: readBool('canViewUserRole'),
      canViewUserOperation: readBool('canViewUserOperation'),
      changeUserPassword: readBool('changeUserPassword'),
    );
  }
}
