import 'package:eks_sana_plus_org/src/shared/validator/validations/validation.dart';

class PinCodeValidation<T> extends Validation<T> {
  @override
  String? validate(T? value) {
    if (value == null || (value is String && value.isEmpty)) {
      return null;
    }

    final pinCode = (value as String).trim();

    if (!RegExp(r'^\d{5}$').hasMatch(pinCode)) {
      return 'پین کد باید ۵ رقم باشد';
    }

    return null;
  }
}
