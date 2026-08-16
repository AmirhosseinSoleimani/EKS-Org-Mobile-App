import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/service_request_operation_access_entity.dart';

class ServiceRequestOperationAccessModel
    extends ServiceRequestOperationAccessEntity {
  const ServiceRequestOperationAccessModel({
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
    super.canInsert,
    super.canView,
    super.canUpdate,
    super.canDelete,
    super.canExport,
    super.canPrint,
    super.canImport,
  });

  factory ServiceRequestOperationAccessModel.fromJson(
    Map<String, dynamic> json,
  ) {
    bool? read(String key) => JsonValueReader.boolValue(json[key]);
    return ServiceRequestOperationAccessModel(
      cancel: read('cancel'),
      cancelAfterAssign: read('cancelAfterAssign'),
      cancelBeforeAssign: read('cancelBeforeAssign'),
      assign: read('assign'),
      assignCancel: read('assignCancel'),
      lackOfCooperation: read('lackOfCooperation'),
      cartableCycle: read('cartableCycle'),
      followUp: read('followUp'),
      invoiceCancel: read('invoiceCancel'),
      customerInvoice: read('customerInvoice'),
      emdadgarInvoice: read('emdadgarInvoice'),
      invoiceRegistration: read('invoiceRegistration'),
      externalEmdadNavgan: read('externalEmdadNavgan'),
      cancelExternalEmdadNavgan: read('cancelExternalEmdadNavgan'),
      serviceRequestCopy: read('serviceRequestCopy'),
      evaluationHistory: read('evaluationHistory'),
      invoiceModification: read('invoiceModification'),
      urgentServiceRequestCompleted: read('urgentServiceRequestCompleted'),
      canInsert: read('canInsert'),
      canView: read('canView'),
      canUpdate: read('canUpdate'),
      canDelete: read('canDelete'),
      canExport: read('canExport'),
      canPrint: read('canPrint'),
      canImport: read('canImport'),
    );
  }
}
