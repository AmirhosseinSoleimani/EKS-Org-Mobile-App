import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/location_permission_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApplyHighAccuracyUseCase extends BaseUseCaseNoArgs {
  ApplyHighAccuracyUseCase(this._repository);

  final LocationPermissionRepository _repository;

  @override
  Future <ApiResult<void>> call() async => _repository.applyHighAccuracy();
}