import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRescuerSkillCertificatesUseCase {
  final RescuerRepository _repository;

  GetRescuerSkillCertificatesUseCase(this._repository);

  Future<ApiResult<List<SkillCertificateEntity>>> call(int id) {
    return _repository.getSkillCertificates(id);
  }
}
