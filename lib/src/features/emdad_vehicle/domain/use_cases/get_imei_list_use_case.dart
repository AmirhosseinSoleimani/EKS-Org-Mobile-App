import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/repositories/emdad_vehicle_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetImeiListUseCase
    extends BaseUseCaseNoArgs<ApiResult<List<ImeiInfoEntity>>> {
  GetImeiListUseCase(this._repository);

  final EmdadVehicleRepository _repository;

  @override
  Future<ApiResult<List<ImeiInfoEntity>>> call() async {
    return await _repository.getImeiList();
  }
}
