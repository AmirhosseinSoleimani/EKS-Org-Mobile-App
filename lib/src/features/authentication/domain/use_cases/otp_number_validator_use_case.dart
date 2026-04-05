import 'package:eks_sana_plus_org/src/shared/usecase/use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OtpNumberValidatorUseCase extends ValidatorUseCase<String?, String?> {
  OtpNumberValidatorUseCase();

  @override
  String? call(arg) {
    final raw = (arg ?? '').trim();
    if (raw.isEmpty) return 'شماره موبایل الزامی است';
    final digits = raw.replaceAll(RegExp(r'\\D'), '');
    if (!digits.startsWith('09')) {
      return 'شماره موبایل معتبر نیست. لطفا دوباره وارد کنید.';
    }
    return null;
  }
}
