import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/car_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchCarSelectedUseCase extends BaseUseCaseNoArgs {
  FetchCarSelectedUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future <CarInfoEntity?> call() async{
    final result = _repository.fetchCarSelected;
    return result;
  }
}
