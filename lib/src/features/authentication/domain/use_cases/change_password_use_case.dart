import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/change_password_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/repositories/profile_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChangePasswordUseCase
    extends BaseUseCase<ApiResult<String>, ChangePasswordRequestEntity> {
  ChangePasswordUseCase(this._repository);

  final ProfileRepository _repository;

  @override
  Future<ApiResult<String>> call(ChangePasswordRequestEntity arg) {
    return _repository.changePassword(arg);
  }
}
