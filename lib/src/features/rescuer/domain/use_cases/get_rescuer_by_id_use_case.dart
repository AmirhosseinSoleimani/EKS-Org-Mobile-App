import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRescuerByIdUseCase {
  final RescuerRepository _repository;

  GetRescuerByIdUseCase(this._repository);

  Future<ApiResult<RescuerEntity>> call(int id) {
    return _repository.getRescuerById(id);
  }
}
