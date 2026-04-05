import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/payment_type_param.dart';

class PaymentTypeParamModel extends PaymentTypeParam {
  const PaymentTypeParamModel({
    super.type,
    super.customerInvoiceDocGuid,
  });

  Map<String, dynamic> toJson() => {
        'customerInvoiceDocGuid': customerInvoiceDocGuid,
        'PaymentType': type?.value,
      };
}
