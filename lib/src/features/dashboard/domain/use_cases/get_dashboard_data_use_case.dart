import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDashboardDataUseCase
    extends BaseUseCase<ApiResult<DashboardEntity?>, DashboardParamEntity> {
  GetDashboardDataUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  Future<ApiResult<DashboardEntity?>> call(DashboardParamEntity arg) async {
    return await _repository.getDashboardData(arg);
  }
}
