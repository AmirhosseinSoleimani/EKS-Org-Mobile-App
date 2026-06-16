
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/repository/home_service_evaluation_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

import '../entity/insert_home_service_service_response_entity.dart';

@lazySingleton
class FetchInsertHomeServiceServiceUseCase extends BaseUseCase<ApiResult<InsertHomeServiceServiceResponseEntity?>, InsertHomeServiceServiceRequestEntity?> {
  FetchInsertHomeServiceServiceUseCase(this._repository);

  final HomeServiceEvaluationRepository _repository;

  @override
  Future<ApiResult<InsertHomeServiceServiceResponseEntity?>> call(arg) async {
    final result = await _repository.fetchHomeServiceServices(arg);
    return result;
  }
}
