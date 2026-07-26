import 'package:eks_sana_plus_org/src/features/imei/domain/entities/device_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/repository/imei_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDeviceInfoListUseCase
    extends BaseUseCaseNoArgs<ApiResult<List<DeviceInfoEntity>>> {
  GetDeviceInfoListUseCase(this._repository);

  final ImeiRepository _repository;

  @override
  Future<ApiResult<List<DeviceInfoEntity>>> call() {
    return _repository.getDeviceTypes();
  }
}
