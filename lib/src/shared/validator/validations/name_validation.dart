import 'package:eks_sana_plus_org/src/shared/validator/validations/validation.dart';

class NameValidation<T> extends Validation<T> {
  @override
  String? validate(T? value) {
    if (value == null || (value is String && value.isEmpty)) {
      return null;
    }

    final name = (value as String).trim();

    if (!RegExp(r'^[\p{L}\s]+$', unicode: true).hasMatch(name)) {
      return 'فقط حروف و فاصله مجاز است';
    }

    if (name.length < 2) {
      return 'نام وارد شده کوتاه است';
    }

    if (name.length > 50) {
      return 'نام وارد شده طولانی است';
    }

    return null;
  }
}
