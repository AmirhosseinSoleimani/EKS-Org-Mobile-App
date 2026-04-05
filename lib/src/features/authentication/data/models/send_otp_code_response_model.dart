import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/send_otp_code_response_entity.dart';

class SendOtpCodeResponseModel extends SendOtpCodeResponseEntity{
  SendOtpCodeResponseModel({
    super.token,
  });

  factory SendOtpCodeResponseModel.fromJson(Map<String, dynamic> json) {
    return SendOtpCodeResponseModel(
      token: json['token'],
    );
  }
}
