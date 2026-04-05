import 'package:eks_sana_plus_org/src/shared/validator/validations/validation.dart';

class EmailValidation<T> extends Validation<T> {
  @override
  String? validate(T? value) {
    final RegExp emailRegex =
        RegExp(r'^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$');

    if (value == null) {
      return null;
    }

    if (value is String && !emailRegex.hasMatch(value)) {
      return 'ایمیل وارد شده معتبر نیست.';
    }

    return null;
  }
}
