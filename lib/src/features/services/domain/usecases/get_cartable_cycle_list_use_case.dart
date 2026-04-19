import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

import '../entities/params/request_operation_param_entity.dart';

@lazySingleton
class GetCartableCycleListUseCase extends BaseUseCase<
    ApiResult<CartableCycleListEntity?>, RequestOperationParamEntity> {
  final RequestRepository _repository;

  GetCartableCycleListUseCase(this._repository);

  @override
  Future<ApiResult<CartableCycleListEntity?>> call(arg) async {
    return await _repository.getCartableCycleList(arg);
  }
}
