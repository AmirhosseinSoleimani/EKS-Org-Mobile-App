import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/submit_skill_certificates_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/submit_skill_certificates_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubmitRescuerSkillCertificatesUseCase {
  final RescuerRepository _repository;

  const SubmitRescuerSkillCertificatesUseCase(this._repository);

  Future<ApiResult<SubmitSkillCertificatesResponseEntity>> call(
    SubmitSkillCertificatesParamEntity param,
  ) {
    return _repository.submitSkillCertificates(param);
  }
}
