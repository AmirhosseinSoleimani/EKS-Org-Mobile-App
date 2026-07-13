enum CartableActionType {
  viewRequest,
  delegateCartable,
  archive,
  insertReport,
  invoiceObjectionConfirm,
  invoiceObjectionReject,
  createInvoice,
  cancelRequest,
  snooze,
  cartableCirculation,
  followUp,
  unknown,
}


abstract final class CartableActionCodes {
  static const viewRequest =
      'ServiceRequest-ViewRequest';

  static const delegateCartable =
      'ServiceRequest-DelegateCartable';

  static const archive =
      'CartableMessage-Archive';

  static const insertReport =
      'NewCarServiceRequest-Insert';

  static const invoiceObjectionConfirm =
      'InvoiceObjection-Confirm';

  static const invoiceObjectionReject =
      'InvoiceObjection-Reject';

  static const createInvoice =
      'ServiceRequest-CreateInvoice';

  static const cancelRequest =
      'ServiceRequest-Cancel';

  static const snooze =
      'ServiceRequest-Snooz';

  static const cartableCirculation =
      'cartable-circulation';

  static const followUp =
      'ServiceRequest-FollowUp';

  static CartableActionType resolveType(
      String? code,
      ) {
    switch (_normalize(code)) {
      case 'servicerequest-viewrequest':
        return CartableActionType.viewRequest;

      case 'servicerequest-delegatecartable':
        return CartableActionType.delegateCartable;

      case 'cartablemessage-archive':
        return CartableActionType.archive;

      case 'newcarservicerequest-insert':
        return CartableActionType.insertReport;

      case 'invoiceobjection-confirm':
        return CartableActionType
            .invoiceObjectionConfirm;

      case 'invoiceobjection-reject':
        return CartableActionType
            .invoiceObjectionReject;

      case 'servicerequest-createinvoice':
        return CartableActionType.createInvoice;

      case 'servicerequest-cancel':
        return CartableActionType.cancelRequest;

      case 'servicerequest-snooz':
        return CartableActionType.snooze;

      case 'cartable-circulation':
        return CartableActionType
            .cartableCirculation;

      case 'servicerequest-followup':
        return CartableActionType.followUp;

      default:
        return CartableActionType.unknown;
    }
  }

  static String _normalize(String? value) {
    return value?.trim().toLowerCase() ?? '';
  }
}