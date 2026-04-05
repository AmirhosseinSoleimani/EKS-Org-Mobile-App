import 'package:eks_sana_plus_org/src/features/authentication/data/models/send_otp_code_response_model.dart';

class SendOtpCodeResponseEntity {
  const SendOtpCodeResponseEntity({
    this.token,
  });

  final String? token;

  SendOtpCodeResponseEntity copyWith({
    String? token,
  }) {
    return SendOtpCodeResponseEntity(
      token: token ?? this.token,
    );
  }

  SendOtpCodeResponseModel toModel() {
    return SendOtpCodeResponseModel(
      token: token,
    );
  }
}