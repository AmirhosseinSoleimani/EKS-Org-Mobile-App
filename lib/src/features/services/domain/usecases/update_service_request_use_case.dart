import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/update_service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/update_service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateServiceRequestUseCase
    extends
        BaseUseCase<
          ApiResult<UpdateServiceResponseEntity>,
          UpdateServiceRequestParamEntity
        > {
  final RequestRepository _repository;

  UpdateServiceRequestUseCase(this._repository);

  @override
  Future<ApiResult<UpdateServiceResponseEntity>> call(arg) async {
    return await _repository.updateServiceRequest(arg);
  }
}
