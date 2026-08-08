import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/service_request_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/data/common/models/json_value_reader.dart';

class ServiceRequestOperationAccessModel
    extends ServiceRequestOperationAccessEntity {
  const ServiceRequestOperationAccessModel({
    required super.cancel,
    required super.cancelAfterAssign,
    required super.cancelBeforeAssign,
    required super.assign,
    required super.assignCancel,
    required super.lackOfCooperation,
    required super.cartableCycle,
    required super.followUp,
    required super.invoiceCancel,
    required super.customerInvoice,
    required super.emdadgarInvoice,
    required super.invoiceRegistration,
    required super.externalEmdadNavgan,
    required super.cancelExternalEmdadNavgan,
    required super.serviceRequestCopy,
    required super.evaluationHistory,
    required super.invoiceModification,
    required super.urgentServiceRequestCompleted,
    required super.canInsert,
    required super.canView,
    required super.canUpdate,
    required super.canDelete,
    required super.canExport,
    required super.canPrint,
    required super.canImport,
  });

  factory ServiceRequestOperationAccessModel.fromJson(
    Map<String, dynamic> json,
  ) {
    bool read(String key) => JsonValueReader.boolValue(json[key]) ?? false;
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
