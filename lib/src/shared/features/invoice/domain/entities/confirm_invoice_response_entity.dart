import 'package:eks_sana_plus_org/src/shared/features/invoice/data/models/confirm_invoice_response_model.dart';

class ConfirmInvoiceResponseEntity {
  const ConfirmInvoiceResponseEntity({
    this.message,
  });

  final String? message;

  ConfirmInvoiceResponseModel toModel() {
    return ConfirmInvoiceResponseModel(
      message: message,
    );
  }
}