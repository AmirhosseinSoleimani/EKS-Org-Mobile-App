import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/repository/map_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProvinceLookupListUseCase
    extends BaseUseCaseNoArgs<ApiResult<List<ProvinceLookupEntity>>> {
  GetProvinceLookupListUseCase(this._repository);

  final MapRepository _repository;

  @override
  Future<ApiResult<List<ProvinceLookupEntity>>> call() =>
      _repository.getProvinceLookupList();
}
