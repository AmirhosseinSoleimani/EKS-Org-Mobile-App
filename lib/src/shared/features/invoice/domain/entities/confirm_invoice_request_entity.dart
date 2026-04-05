import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_request_model.dart';

class ConfirmHomeServiceRequest {
  const ConfirmHomeServiceRequest({
    this.isAgreed,
    this.isApproved,
    this.id,
    this.serviceRequestId,
    this.canOnlinePay,
  });

  final int? id;
  final bool? isApproved;
  final bool? isAgreed;
  final bool? canOnlinePay;
  final int? serviceRequestId;

  ConfirmInvoiceRequestModel toModel() {
    return ConfirmInvoiceRequestModel(
      id: id,
      isAgreed: isAgreed,
      isApproved: isApproved,
      serviceRequestId: serviceRequestId,
      canOnlinePay: canOnlinePay,
    );
  }
}