import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/submit_skill_certificates_response_entity.dart';

class SubmitSkillCertificatesResponseModel
    extends SubmitSkillCertificatesResponseEntity {
  const SubmitSkillCertificatesResponseModel({required super.message});

  factory SubmitSkillCertificatesResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final message = json['message']?.toString().trim() ?? '';

    return SubmitSkillCertificatesResponseModel(
      message: message.isEmpty ? 'اطلاعات با موفقیت ثبت شد' : message,
    );
  }
}
