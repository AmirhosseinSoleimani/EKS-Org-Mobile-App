import 'package:eks_sana_plus_org/src/features/services/domain/entities/message_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/change_address_home_service_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChangeHomeServiceRequestAddressUseCase
    extends BaseUseCase<ApiResult<MessageEntity>, ChangeAddressHomeServiceParamEntity> {
  RequestRepository requestRepository;

  ChangeHomeServiceRequestAddressUseCase(this.requestRepository);

  @override
  Future<ApiResult<MessageEntity>> call(arg) async {
    final result = await requestRepository.changeAddressHomeServiceRequest(arg);
    return result;
  }
}
