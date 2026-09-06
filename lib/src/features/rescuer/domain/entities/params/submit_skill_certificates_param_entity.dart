import 'package:eks_sana_plus_org/src/features/rescuer/data/models/params/submit_skill_certificates_param_model.dart';

class SubmitSkillCertificatesParamEntity {
  final List<int> skillCertificateIds;
  final int personInfoId;

  const SubmitSkillCertificatesParamEntity({
    required this.skillCertificateIds,
    required this.personInfoId,
  });

  SubmitSkillCertificatesParamModel toModel() {
    return SubmitSkillCertificatesParamModel(
      skillCertificateIds: skillCertificateIds,
      personInfoId: personInfoId,
    );
  }
}
