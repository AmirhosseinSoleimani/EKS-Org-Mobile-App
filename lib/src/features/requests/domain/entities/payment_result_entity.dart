import 'package:eks_sana_plus_org/src/features/requests/data/models/payment_result_model.dart';

class PaymentResultEntity {
  final String? transId;
  final String? paymentLink;
  final String? transStatus;

  PaymentResultEntity({
    required this.transId,
    this.transStatus,
    this.paymentLink,
  });

  PaymentResultEntity copyWith({
    String? transId,
    String? paymentLink,
    String? transStatus,
  }) {
    return PaymentResultEntity(
      transId: transId ?? this.transId,
      paymentLink: paymentLink ?? this.paymentLink,
      transStatus: transStatus ?? this.transStatus,
    );
  }

  PaymentResultModel toModel() {
    return PaymentResultModel(
      transId: transId,
      paymentLink: paymentLink,
      transStatus: transStatus,
    );
  }
}