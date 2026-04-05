import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OtpValidatorUseCase extends ValidatorUseCase<bool, String?> {
  OtpValidatorUseCase();

  @override
  bool call(arg) {
    return arg?.length == 5;
  }
}
