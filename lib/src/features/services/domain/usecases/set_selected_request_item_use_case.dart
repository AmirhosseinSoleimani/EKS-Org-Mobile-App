
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/repository/request_repository_share_data.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetSelectedRequestItemUseCase extends BaseUseCase<void, BaseRequestEntity> {
  final RequestRepositoryShareData _repository;

  SetSelectedRequestItemUseCase(this._repository);

  @override
  Future<void> call(arg) async {
    _repository.setSelectedRequestItem(arg);
  }
}
