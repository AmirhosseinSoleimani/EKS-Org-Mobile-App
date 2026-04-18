import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/location_to_address_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/map_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchLocationToAddressUseCase extends BaseUseCase<
    ApiResult<LocationToAddressResponseEntity?>, MapRequestEntity?> {
  FetchLocationToAddressUseCase(this._repository);

  final MapRepository _repository;

  @override
  Future<ApiResult<LocationToAddressResponseEntity?>> call(arg) async {
    ApiResult<LocationToAddressResponseEntity?> result =
        await _repository.fetchLocationToAddress(arg);
    return result;
  }
}
