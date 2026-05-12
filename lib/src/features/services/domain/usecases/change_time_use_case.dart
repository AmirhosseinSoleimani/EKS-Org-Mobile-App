import 'package:eks_sana_plus_org/src/features/services/domain/entities/message_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/change_time_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChangeTimeUseCase
    extends BaseUseCase<ApiResult<MessageEntity>, ChangeTimeParamEntity> {
  RequestRepository requestRepository;

  ChangeTimeUseCase(this.requestRepository);

  @override
  Future<ApiResult<MessageEntity>> call(arg) async {
    final result = await requestRepository.changeTime(arg);
    return result;
  }
}
