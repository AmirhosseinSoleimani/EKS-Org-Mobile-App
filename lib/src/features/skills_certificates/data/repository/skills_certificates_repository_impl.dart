import 'package:eks_sana_plus_org/src/features/skills_certificates/data/data_source/skills_certificates_data_source.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/create_or_edit_skill_certificate_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/skill_certificate_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/submit_skill_services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/repository/skills_certificates_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result_converter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SkillsCertificatesRepository)
class SkillsCertificatesRepositoryImpl extends SkillsCertificatesRepository {
  final SkillsCertificatesDataSource _dataSource;

  SkillsCertificatesRepositoryImpl(this._dataSource);

  @override
  Future<ApiResult<SkillCertificateListEntity>> getSkills(
    SkillCertificateFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getSkills(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<SkillCertificateEntity?>> getSkillById(int id) async {
    try {
      final result = await _dataSource.getSkillById(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> createSkill(
    CreateOrEditSkillCertificateParamEntity param,
  ) async {
    try {
      final result = await _dataSource.createSkill(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> editSkill(
    CreateOrEditSkillCertificateParamEntity param,
  ) async {
    try {
      final result = await _dataSource.editSkill(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> deleteSkill(int id) async {
    try {
      final result = await _dataSource.deleteSkill(id);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<SkillServiceEntity>>> getServices(int skillId) async {
    try {
      final result = await _dataSource.getServices(skillId);
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<void>> submitServices(
    SubmitSkillServicesParamEntity param,
  ) async {
    try {
      final result = await _dataSource.submitServices(param.toModel());
      return result.toApiResult();
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }

  @override
  Future<ApiResult<List<SkillCertificateEntity>>> getReport(
    SkillCertificateFilterParamEntity param,
  ) async {
    try {
      final result = await _dataSource.getReport(param.toModel());
      return result.toApiResult().when(
            success: (data, failures, resultCode) => ApiResult.success(
              data: data.items,
              failures: failures,
              resultCode: resultCode,
            ),
            failure: (error, failures) => ApiResult.failure(
              error: error,
              failures: failures,
            ),
            expireToken: () => const ApiResult.expireToken(),
            connectionError: () => const ApiResult.connectionError(),
          );
    } catch (e, s) {
      return e.toApiResult(s);
    }
  }
}
