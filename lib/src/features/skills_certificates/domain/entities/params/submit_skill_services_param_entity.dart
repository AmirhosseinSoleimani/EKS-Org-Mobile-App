import '../../../data/models/params/submit_skill_services_param_model.dart';

class SubmitSkillServicesParamEntity {
  final int skillCertificateId;
  final List<int> emdadServiceIds;

  const SubmitSkillServicesParamEntity({
    required this.skillCertificateId,
    required this.emdadServiceIds,
  });

  SubmitSkillServicesParamModel toModel() {
    return SubmitSkillServicesParamModel(
      skillCertificateId: skillCertificateId,
      emdadServiceIds: emdadServiceIds,
    );
  }
}
