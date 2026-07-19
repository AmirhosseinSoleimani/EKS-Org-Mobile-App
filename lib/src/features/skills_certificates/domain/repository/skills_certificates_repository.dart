import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/create_or_edit_skill_certificate_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/skill_certificate_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/submit_skill_services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

abstract class SkillsCertificatesRepository {
  Future<ApiResult<SkillCertificateListEntity>> getSkills(
    SkillCertificateFilterParamEntity param,
  );

  Future<ApiResult<SkillCertificateEntity?>> getSkillById(int id);

  Future<ApiResult<void>> createSkill(
    CreateOrEditSkillCertificateParamEntity param,
  );

  Future<ApiResult<void>> editSkill(
    CreateOrEditSkillCertificateParamEntity param,
  );

  Future<ApiResult<void>> deleteSkill(int id);

  Future<ApiResult<List<SkillServiceEntity>>> getServices(int skillId);

  Future<ApiResult<void>> submitServices(SubmitSkillServicesParamEntity param);

  Future<ApiResult<List<SkillCertificateEntity>>> getReport(
    SkillCertificateFilterParamEntity param,
  );
}
