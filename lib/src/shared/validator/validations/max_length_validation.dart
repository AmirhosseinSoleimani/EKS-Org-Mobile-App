import 'package:eks_sana_plus_org/src/shared/validator/validations/validation.dart';

class MaxLengthValidation extends Validation<String> {
  final int maxLength;
  final String? fieldName;

  const MaxLengthValidation({
    required this.maxLength,
    this.fieldName,
  });

  @override
  String? validate(String? value) {
    if (value == null || value.length <= maxLength) return null;

    if (fieldName != null) {
      return '$fieldName باید حداکثر $maxLength کاراکتر باشد';
    }

    return 'حداکثر $maxLength کاراکتر مجاز است';
  }
}
