import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/cover_car_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchCoverCarListUseCase extends BaseUseCaseNoArgs {
  FetchCoverCarListUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future <List<CoverCarEntity?>> call() async{
    final result = _repository.fetchCoverCarList;
    return result;
  }
}
