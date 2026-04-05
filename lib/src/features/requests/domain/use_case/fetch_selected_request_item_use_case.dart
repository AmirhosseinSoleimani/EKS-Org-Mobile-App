import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/repository/request_repository_share_data.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchSelectedRequestItemUseCase extends BaseUseCaseNoArgs {
  final RequestRepositoryShareData _repository;

  FetchSelectedRequestItemUseCase(this._repository);

  @override
  Future<RequestEntity> call() async {
    return _repository.fetchSelectedRequestItem;
  }
}
