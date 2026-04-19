import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository_share_data.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchSelectedRequestItemUseCase extends BaseUseCaseNoArgs {
  final RequestRepositoryShareData _repository;

  FetchSelectedRequestItemUseCase(this._repository);

  @override
  Future<BaseRequestEntity?> call() async {
    return _repository.fetchSelectedRequestItem;
  }
}
