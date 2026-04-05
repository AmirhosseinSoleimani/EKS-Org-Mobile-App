import 'package:eks_sana_plus_org/src/features/requests/domain/entities/message_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/params/cancel_request_param.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CancelRequestUseCase extends BaseUseCase<
    ApiResult<MessageEntity>, CancelRequestParam> {
  CancelRequestUseCase(this._homeRepository);

  final RequestRepository _homeRepository;

  @override
  Future<ApiResult<MessageEntity>> call(arg) async {
    ApiResult<MessageEntity> result =
        await _homeRepository.cancelRequest(arg);
    return result;
  }
}
