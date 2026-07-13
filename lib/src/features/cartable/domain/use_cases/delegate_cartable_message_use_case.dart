import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/delegate_cartable_message_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/delegate_cartable_message_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/repositories/cartable_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DelegateCartableMessageUseCase extends BaseUseCase<
    ApiResult<DelegateCartableMessageResponseEntity>,
    DelegateCartableMessageParamEntity> {
  final CartableRepository _repository;

  DelegateCartableMessageUseCase(this._repository);

  @override
  Future<ApiResult<DelegateCartableMessageResponseEntity>> call(arg) async {
    return await _repository.delegateCartableMessage(arg);
  }
}
