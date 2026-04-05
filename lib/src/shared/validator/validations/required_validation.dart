import 'package:eks_sana_plus_org/src/shared/validator/validations/validation.dart';

class RequiredValidation<T> extends Validation<T> {
  final String? fieldName;

  const RequiredValidation({this.fieldName});

  @override
  String? validate(T? value) {
    if (value == null || (value is String && value.isEmpty)) {
      if (fieldName != null) {
        return '$fieldName را وارد کنید';
      }
      return 'این فیلد اجباری است';
    }
    return null;
  }
}
