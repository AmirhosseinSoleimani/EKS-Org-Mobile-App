import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/cancel_reasons_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCancelReasonsUseCase
    extends BaseUseCase<ApiResult<List<CancelReasonEntity>>, int?> {
  RequestRepository requestRepository;

  GetCancelReasonsUseCase(this.requestRepository);

  @override
  Future<ApiResult<List<CancelReasonEntity>>> call(arg) async {
    return await requestRepository.getCancelReasons(arg);

  }
}
