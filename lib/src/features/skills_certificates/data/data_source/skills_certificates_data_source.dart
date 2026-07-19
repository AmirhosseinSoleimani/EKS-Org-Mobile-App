import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/params/create_or_edit_skill_certificate_param_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/params/skill_certificate_filter_param_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/params/submit_skill_services_param_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/skill_certificate_model.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/data/models/skill_service_model.dart';
import 'package:eks_sana_plus_org/src/services/network/model/base_response.dart';

abstract class SkillsCertificatesDataSource {
  Future<BaseSingleResponse<SkillCertificateListModel>> getSkills(
    SkillCertificateFilterParamModel param,
  );

  Future<BaseSingleResponse<SkillCertificateModel>> getSkillById(int id);

  Future<BaseSingleResponse<void>> createSkill(
    CreateOrEditSkillCertificateParamModel param,
  );

  Future<BaseSingleResponse<void>> editSkill(
    CreateOrEditSkillCertificateParamModel param,
  );

  Future<BaseSingleResponse<void>> deleteSkill(int id);

  Future<BaseListResponse<SkillServiceModel>> getServices(int skillId);

  Future<BaseSingleResponse<void>> submitServices(
    SubmitSkillServicesParamModel param,
  );

  Future<BaseSingleResponse<SkillCertificateListModel>> getReport(
    SkillCertificateFilterParamModel param,
  );
}
