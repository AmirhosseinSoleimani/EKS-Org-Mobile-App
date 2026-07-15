import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/san_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRescuerHistoryUseCase {
  final RescuerRepository _repository;

  GetRescuerHistoryUseCase(this._repository);

  Future<ApiResult<List<SanHistoryEntity>>> call(int id) {
    return _repository.getHistory(id);
  }
}
