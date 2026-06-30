import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/create_follow_up_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/post_follow_up_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreateFollowUpUseCase
    extends
        BaseUseCase<
          ApiResult<PostFollowUpResponseEntity>,
          CreateFollowUpParamEntity
        > {
  final RequestRepository _repository;

  CreateFollowUpUseCase(this._repository);

  @override
  Future<ApiResult<PostFollowUpResponseEntity>> call(arg) async {
    return await _repository.createFollowUp(arg);
  }
}
