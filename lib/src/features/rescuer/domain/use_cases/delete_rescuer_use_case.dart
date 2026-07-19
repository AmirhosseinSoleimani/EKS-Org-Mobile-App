import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/delete_rescuer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteRescuerUseCase {
  final RescuerRepository _repository;

  DeleteRescuerUseCase(this._repository);

  Future<ApiResult<DeleteRescuerResponseEntity>> call(int id) {
    return _repository.deleteRescuer(id);
  }
}
