class ServiceRequestOperationAccessEntity {
  const ServiceRequestOperationAccessEntity({
    required this.cancel,
    required this.cancelAfterAssign,
    required this.cancelBeforeAssign,
    required this.assign,
    required this.assignCancel,
    required this.lackOfCooperation,
    required this.cartableCycle,
    required this.followUp,
    required this.invoiceCancel,
    required this.customerInvoice,
    required this.emdadgarInvoice,
    required this.invoiceRegistration,
    required this.externalEmdadNavgan,
    required this.cancelExternalEmdadNavgan,
    required this.serviceRequestCopy,
    required this.evaluationHistory,
    required this.invoiceModification,
    required this.urgentServiceRequestCompleted,
    required this.canInsert,
    required this.canView,
    required this.canUpdate,
    required this.canDelete,
    required this.canExport,
    required this.canPrint,
    required this.canImport,
  });

  final bool cancel;
  final bool cancelAfterAssign;
  final bool cancelBeforeAssign;
  final bool assign;
  final bool assignCancel;
  final bool lackOfCooperation;
  final bool cartableCycle;
  final bool followUp;
  final bool invoiceCancel;
  final bool customerInvoice;
  final bool emdadgarInvoice;
  final bool invoiceRegistration;
  final bool externalEmdadNavgan;
  final bool cancelExternalEmdadNavgan;
  final bool serviceRequestCopy;
  final bool evaluationHistory;
  final bool invoiceModification;
  final bool urgentServiceRequestCompleted;
  final bool canInsert;
  final bool canView;
  final bool canUpdate;
  final bool canDelete;
  final bool canExport;
  final bool canPrint;
  final bool canImport;
}
