import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/send_otp_code_request_entity.dart';

class SendOtpCodeRequestModel extends SendOtpCodeRequestEntity{
  const SendOtpCodeRequestModel({
    super.mobileNumber,
    super.channelType,
  });

  Map<String, dynamic> toJson() => {
      'MobileNumber': mobileNumber,
      'ChannelType': channelType,
    };
}