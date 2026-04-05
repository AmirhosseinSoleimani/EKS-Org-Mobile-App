import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetThemeUseCase extends BaseUseCaseNoArgs<ApiResult<String?>> {
  GetThemeUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future<ApiResult<String?>> call() async {
    ApiResult<String?> result =
        const ApiResult.success(data: null); //await _repository.getTheme();
    return result;
  }
}
