import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/user/domain/repository/user_repository.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetThemeUseCase extends BaseUseCase<ApiResult<String?>, String?> {
  SetThemeUseCase(this._repository);

  final UserRepository _repository;

  @override
  Future<ApiResult<String?>> call(args) async {
    // TODO: Refactor needed (Hive dependency removed).
    ApiResult<String?> result =
        const ApiResult.success(data: null); //await _repository.setTheme(args);
    return result;
  }
}
