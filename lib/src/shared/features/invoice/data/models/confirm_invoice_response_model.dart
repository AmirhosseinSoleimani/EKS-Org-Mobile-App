import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/confirm_invoice_response_entity.dart';

class ConfirmInvoiceResponseModel extends ConfirmInvoiceResponseEntity {
  const ConfirmInvoiceResponseModel({
    super.message,
  });

  factory ConfirmInvoiceResponseModel.fromJson(Map<String, dynamic> json) {
    return ConfirmInvoiceResponseModel(
      message: json['message'],
    );
  }
}