import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/degree_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchDegreeListUseCase extends BaseUseCaseNoArgs {
  FetchDegreeListUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future <List<DegreeEntity?>> call() async{
    final result = _repository.fetchDegreeList;
    return result;
  }
}
