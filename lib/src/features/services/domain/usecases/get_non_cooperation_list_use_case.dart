import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

import '../entities/non_cooperation_list_entity.dart';
import '../entities/params/request_operation_param_entity.dart';

@lazySingleton
class GetNonCooperationListUseCase extends BaseUseCase<
    ApiResult<NonCooperationListEntity?>, RequestOperationParamEntity> {
  final RequestRepository _repository;

  GetNonCooperationListUseCase(this._repository);

  @override
  Future<ApiResult<NonCooperationListEntity?>> call(arg) async {
    return await _repository.getNonCooperationList(arg);
  }
}
