import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/service_assign_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_assign_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ServiceAssignUseCase
    extends
        BaseUseCase<
          ApiResult<ServiceAssignResponseEntity>,
          ServiceAssignParamEntity
        > {
  final RequestRepository _repository;

  ServiceAssignUseCase(this._repository);

  @override
  Future<ApiResult<ServiceAssignResponseEntity>> call(arg) async {
    return await _repository.serviceAssign(arg);
  }
}
