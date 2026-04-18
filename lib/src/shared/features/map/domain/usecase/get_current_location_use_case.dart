import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/location_permission_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

@lazySingleton
class GetCurrentLocationUseCase extends BaseUseCaseNoArgs {
  GetCurrentLocationUseCase(this._repository);

  final LocationPermissionRepository _repository;

  @override
  Future <ApiResult<lat_lng.LatLng>> call() async => _repository.getCurrentPosition();
}