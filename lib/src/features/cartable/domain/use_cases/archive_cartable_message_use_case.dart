import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/archive_cartable_message_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/archive_cartable_message_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/repositories/cartable_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ArchiveCartableMessageUseCase
    extends
        BaseUseCase<
          ApiResult<ArchiveCartableMessageResponseEntity>,
          ArchiveCartableMessageParamEntity
        > {
  final CartableRepository _repository;

  ArchiveCartableMessageUseCase(this._repository);

  @override
  Future<ApiResult<ArchiveCartableMessageResponseEntity>> call(
    ArchiveCartableMessageParamEntity arg,
  ) async {
    return await _repository.archiveCartableMessage(arg);
  }
}
