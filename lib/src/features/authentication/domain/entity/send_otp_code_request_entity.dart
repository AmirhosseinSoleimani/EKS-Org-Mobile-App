
import 'package:eks_sana_plus_org/src/features/authentication/data/models/send_otp_code_request_model.dart';

class SendOtpCodeRequestEntity {
  const SendOtpCodeRequestEntity({
    this.mobileNumber,
    this.channelType,
  });

  final String? mobileNumber;
  final String? channelType;

  SendOtpCodeRequestEntity copyWith({
    String? mobileNumber,
    String? channelType,
  }) {
    return SendOtpCodeRequestEntity(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      channelType: channelType ?? this.channelType,
    );
  }

  SendOtpCodeRequestModel toModel() {
    return SendOtpCodeRequestModel(
      mobileNumber: mobileNumber,
      channelType: channelType,
    );
  }
}