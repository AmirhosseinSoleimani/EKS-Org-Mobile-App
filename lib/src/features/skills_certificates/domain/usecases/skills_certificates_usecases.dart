import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/create_or_edit_skill_certificate_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/skill_certificate_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/params/submit_skill_services_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/entities/skill_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/skills_certificates/domain/repository/skills_certificates_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetSkillsCertificatesUseCase
    extends BaseUseCase<ApiResult<SkillCertificateListEntity>,
        SkillCertificateFilterParamEntity> {
  final SkillsCertificatesRepository _repository;

  GetSkillsCertificatesUseCase(this._repository);

  @override
  Future<ApiResult<SkillCertificateListEntity>> call(
    SkillCertificateFilterParamEntity arg,
  ) {
    return _repository.getSkills(arg);
  }
}

@lazySingleton
class GetSkillCertificateByIdUseCase
    extends BaseUseCase<ApiResult<SkillCertificateEntity?>, int> {
  final SkillsCertificatesRepository _repository;

  GetSkillCertificateByIdUseCase(this._repository);

  @override
  Future<ApiResult<SkillCertificateEntity?>> call(int arg) {
    return _repository.getSkillById(arg);
  }
}

@lazySingleton
class CreateSkillCertificateUseCase
    extends BaseUseCase<ApiResult<void>, CreateOrEditSkillCertificateParamEntity> {
  final SkillsCertificatesRepository _repository;

  CreateSkillCertificateUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(CreateOrEditSkillCertificateParamEntity arg) {
    return _repository.createSkill(arg);
  }
}

@lazySingleton
class EditSkillCertificateUseCase
    extends BaseUseCase<ApiResult<void>, CreateOrEditSkillCertificateParamEntity> {
  final SkillsCertificatesRepository _repository;

  EditSkillCertificateUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(CreateOrEditSkillCertificateParamEntity arg) {
    return _repository.editSkill(arg);
  }
}

@lazySingleton
class DeleteSkillCertificateUseCase extends BaseUseCase<ApiResult<void>, int> {
  final SkillsCertificatesRepository _repository;

  DeleteSkillCertificateUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(int arg) {
    return _repository.deleteSkill(arg);
  }
}

@lazySingleton
class GetSkillCertificateServicesUseCase
    extends BaseUseCase<ApiResult<List<SkillServiceEntity>>, int> {
  final SkillsCertificatesRepository _repository;

  GetSkillCertificateServicesUseCase(this._repository);

  @override
  Future<ApiResult<List<SkillServiceEntity>>> call(int arg) {
    return _repository.getServices(arg);
  }
}

@lazySingleton
class SubmitSkillCertificateServicesUseCase
    extends BaseUseCase<ApiResult<void>, SubmitSkillServicesParamEntity> {
  final SkillsCertificatesRepository _repository;

  SubmitSkillCertificateServicesUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(SubmitSkillServicesParamEntity arg) {
    return _repository.submitServices(arg);
  }
}

@lazySingleton
class GetSkillCertificatesReportUseCase
    extends BaseUseCase<ApiResult<List<SkillCertificateEntity>>,
        SkillCertificateFilterParamEntity> {
  final SkillsCertificatesRepository _repository;

  GetSkillCertificatesReportUseCase(this._repository);

  @override
  Future<ApiResult<List<SkillCertificateEntity>>> call(
    SkillCertificateFilterParamEntity arg,
  ) {
    return _repository.getReport(arg);
  }
}
