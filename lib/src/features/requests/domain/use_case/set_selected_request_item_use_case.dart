import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/repository/request_repository_share_data.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetSelectedRequestItemUseCase extends BaseUseCase<void, RequestEntity> {
  final RequestRepositoryShareData _repository;

  SetSelectedRequestItemUseCase(this._repository);

  @override
  Future<void> call(arg) async {
    _repository.setSelectedRequestItem(arg);
  }
}
