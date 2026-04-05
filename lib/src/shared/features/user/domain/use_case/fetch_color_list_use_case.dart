import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/entities/color_entity.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FetchColorListUseCase extends BaseUseCaseNoArgs {
  FetchColorListUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future <List<ColorEntity?>> call() async{
    final result = _repository.fetchColorList;
    return result;
  }
}
