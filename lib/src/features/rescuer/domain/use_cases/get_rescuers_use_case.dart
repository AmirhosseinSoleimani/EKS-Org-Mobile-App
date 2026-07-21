import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/get_rescuers_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRescuersUseCase {
  final RescuerRepository _repository;

  GetRescuersUseCase(this._repository);

  Future<ApiResult<List<RescuerEntity>>> call(
    GetRescuersParamEntity param,
  ) {
    return _repository.getRescuers(param);
  }
}
