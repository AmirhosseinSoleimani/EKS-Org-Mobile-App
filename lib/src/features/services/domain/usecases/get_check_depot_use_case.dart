import 'package:eks_sana_plus_org/src/features/services/domain/entities/check_depot_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/check_depot_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCheckDepotUseCase
    extends BaseUseCase<ApiResult<CheckDepotEntity>, CheckDepotParamEntity> {
  final RequestRepository _repository;

  GetCheckDepotUseCase(this._repository);

  @override
  Future<ApiResult<CheckDepotEntity>> call(CheckDepotParamEntity arg) async {
    return await _repository.getCheckDepot(arg);
  }
}
