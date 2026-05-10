import 'package:eks_sana_plus_org/src/features/services/domain/entities/car_covers_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetBasicDataUseCase
    extends BaseUseCaseNoArgs<ApiResult<CarCoversDataEntity>> {
  final RequestRepository _repository;

  GetBasicDataUseCase(this._repository);

  @override
  Future<ApiResult<CarCoversDataEntity>> call() async {
    return await _repository.getBasicData();
  }
}
