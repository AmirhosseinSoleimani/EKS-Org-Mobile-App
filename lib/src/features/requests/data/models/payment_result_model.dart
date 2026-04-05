import 'package:eks_sana_plus_org/src/features/requests/domain/entities/payment_result_entity.dart';

class PaymentResultModel extends PaymentResultEntity {
  PaymentResultModel({
    required super.transId,
    super.paymentLink,
    super.transStatus,
  });

  factory PaymentResultModel.fromJson(Map<String, dynamic> json) {
    final link = json['gatewayAddress'];
    final transStatus = json['transStatus'];
    final transId = json['transId'];

    return PaymentResultModel(
      transId: transId,
      paymentLink: link,
      transStatus: transStatus,
    );
  }
}
