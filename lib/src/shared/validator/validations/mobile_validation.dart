
import 'package:eks_sana_plus_org/src/shared/validator/validations/validation.dart';

class MobileValidation<T> extends Validation<T> {
  const MobileValidation();
  @override
  String? validate(T? value) {
    if (value == null) {
      return null;
    }

    if (value is String && value.isEmpty) {
      return null;
    }

    final phone = value as String;
    final phoneRegExp = RegExp(r'^09\d{9}$');

    if (!phoneRegExp.hasMatch(phone)) {
      return 'شماره موبایل معتبر نیست. لطفا دوباره وارد کنید.';
    }

    return null;
  }
}
