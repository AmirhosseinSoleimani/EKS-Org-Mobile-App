import 'package:eks_sana_plus_org/src/features/invoice_management/data/agency_invoice_objections/models/service_request_operation_access_model.dart';

class ServiceRequestOperationAccessEntity {
  const ServiceRequestOperationAccessEntity({
    this.cancel,
    this.cancelAfterAssign,
    this.cancelBeforeAssign,
    this.assign,
    this.assignCancel,
    this.lackOfCooperation,
    this.cartableCycle,
    this.followUp,
    this.invoiceCancel,
    this.customerInvoice,
    this.emdadgarInvoice,
    this.invoiceRegistration,
    this.externalEmdadNavgan,
    this.cancelExternalEmdadNavgan,
    this.serviceRequestCopy,
    this.evaluationHistory,
    this.invoiceModification,
    this.urgentServiceRequestCompleted,
    this.canInsert,
    this.canView,
    this.canUpdate,
    this.canDelete,
    this.canExport,
    this.canPrint,
    this.canImport,
  });

  final bool? cancel;
  final bool? cancelAfterAssign;
  final bool? cancelBeforeAssign;
  final bool? assign;
  final bool? assignCancel;
  final bool? lackOfCooperation;
  final bool? cartableCycle;
  final bool? followUp;
  final bool? invoiceCancel;
  final bool? customerInvoice;
  final bool? emdadgarInvoice;
  final bool? invoiceRegistration;
  final bool? externalEmdadNavgan;
  final bool? cancelExternalEmdadNavgan;
  final bool? serviceRequestCopy;
  final bool? evaluationHistory;
  final bool? invoiceModification;
  final bool? urgentServiceRequestCompleted;
  final bool? canInsert;
  final bool? canView;
  final bool? canUpdate;
  final bool? canDelete;
  final bool? canExport;
  final bool? canPrint;
  final bool? canImport;

  ServiceRequestOperationAccessModel toModel() {
    return ServiceRequestOperationAccessModel(
      cancel: cancel,
      cancelAfterAssign: cancelAfterAssign,
      cancelBeforeAssign: cancelBeforeAssign,
      assign: assign,
      assignCancel: assignCancel,
      lackOfCooperation: lackOfCooperation,
      cartableCycle: cartableCycle,
      followUp: followUp,
      invoiceCancel: invoiceCancel,
      customerInvoice: customerInvoice,
      emdadgarInvoice: emdadgarInvoice,
      invoiceRegistration: invoiceRegistration,
      externalEmdadNavgan: externalEmdadNavgan,
      cancelExternalEmdadNavgan: cancelExternalEmdadNavgan,
      serviceRequestCopy: serviceRequestCopy,
      evaluationHistory: evaluationHistory,
      invoiceModification: invoiceModification,
      urgentServiceRequestCompleted: urgentServiceRequestCompleted,
      canInsert: canInsert,
      canView: canView,
      canUpdate: canUpdate,
      canDelete: canDelete,
      canExport: canExport,
      canPrint: canPrint,
      canImport: canImport,
    );
  }
}
