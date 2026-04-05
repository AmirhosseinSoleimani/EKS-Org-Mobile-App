import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/send_otp_code_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendOTPCodeUseCase extends BaseUseCase<ApiResult, SendOtpCodeRequestEntity?> {
  SendOTPCodeUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<ApiResult> call(arg) async {
    ApiResult result = await _authRepository.sendOTPCode(arg);
    return result;
  }
}
