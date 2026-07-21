import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/add_rescuer_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/add_rescuer_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/repositories/rescuer_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddRescuerUseCase {
  final RescuerRepository _repository;
  AddRescuerUseCase(this._repository);
  Future<ApiResult<AddRescuerResponseEntity>> call(AddRescuerParamEntity param) => _repository.addRescuer(param);
}
