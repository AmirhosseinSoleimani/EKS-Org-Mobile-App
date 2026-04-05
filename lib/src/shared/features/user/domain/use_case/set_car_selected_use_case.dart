import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/car_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetCarSelectedUseCase extends BaseUseCase<void, CarInfoEntity> {
  SetCarSelectedUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future<void> call(arg) async {
    final result = _repository.setCarSelected(arg);
    return result;
  }
}
