import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_to_location_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/map_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchAddressToLocationUseCase extends BaseUseCase<
    ApiResult<AddressToLocationResponseEntity?>, MapRequestEntity?> {
  FetchAddressToLocationUseCase(this._repository);

  final MapRepository _repository;

  @override
  Future<ApiResult<AddressToLocationResponseEntity?>> call(arg) async {
    ApiResult<AddressToLocationResponseEntity?> result =
        await _repository.fetchAddressToLocation(arg);
    return result;
  }
}
