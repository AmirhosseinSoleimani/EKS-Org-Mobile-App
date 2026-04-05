import 'package:eks_sana_plus_org/src/features/requests/data/models/params/payment_type_param_model.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/payment_type.dart';

class PaymentTypeParam {
  final String? customerInvoiceDocGuid;
  final PaymentType? type;

  const PaymentTypeParam({
    this.type,
    this.customerInvoiceDocGuid,
  });

  PaymentTypeParam copyWith({
    String? customerInvoiceDocGuid,
    PaymentType? type,
  }) {
    return PaymentTypeParam(
      customerInvoiceDocGuid:
          customerInvoiceDocGuid ?? this.customerInvoiceDocGuid,
      type: type ?? this.type,
    );
  }

  PaymentTypeParamModel toModel() => PaymentTypeParamModel(
        customerInvoiceDocGuid: customerInvoiceDocGuid,
        type: type,
      );
}
