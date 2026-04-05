import 'package:eks_sana_plus_org/src/shared/validator/validations/validation.dart';
import 'package:flutter/widgets.dart';

class Validator {
  Validator._();

  static FormFieldValidator<T> apply<T>(
    List<Validation<T>>? validations,
  ) {
    return (T? value) => _validateValue(value, validations);
  }

  static String? _validateValue<T>(
    T? value,
    List<Validation<T>>? validations,
  ) {
    if (validations == null) {
      return null;
    }

    for (final validation in validations) {
      final error = validation.validate(value);
      if (error != null) return error;
    }
    return null;
  }
}
