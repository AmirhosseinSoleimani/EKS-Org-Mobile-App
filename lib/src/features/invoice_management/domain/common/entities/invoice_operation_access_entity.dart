class InvoiceOperationAccessEntity {
  const InvoiceOperationAccessEntity({
    required this.batchConfirmation,
    required this.hasAdminAccess,
    required this.hasTechAccess,
    required this.hasMaliAmaliatAccess,
  });

  final bool batchConfirmation;
  final bool hasAdminAccess;
  final bool hasTechAccess;
  final bool hasMaliAmaliatAccess;
}
