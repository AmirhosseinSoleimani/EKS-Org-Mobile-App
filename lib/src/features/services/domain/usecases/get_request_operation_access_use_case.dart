import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetRequestOperationAccessUseCase {
  const GetRequestOperationAccessUseCase(this._repository);

  final RequestRepository _repository;

  Future<ApiResult<RequestOperationAccessEntity>> call(ServiceType serviceType) {
    return _repository.getRequestOperationAccess(serviceType);
  }
}
