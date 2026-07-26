import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/navgan_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/navgan/domain/repository/navgan_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetNavganListUseCase
    extends BaseUseCaseNoArgs<ApiResult<NavganPageEntity>> {
  GetNavganListUseCase(this._repository);

  final NavganRepository _repository;

  @override
  Future<ApiResult<NavganPageEntity>> call() {
    return _repository.getByFilter();
  }
}
