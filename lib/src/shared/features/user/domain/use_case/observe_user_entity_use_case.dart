import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/user_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ObserveUserEntityUseCase extends BaseUseCaseOfStreamNoArgs {
  ObserveUserEntityUseCase(this._repository);

  final UserRepository _repository;

  @override
  Stream<UserEntity?> call() {
    return _repository.fetchBaseEntityStream;
  }
}
