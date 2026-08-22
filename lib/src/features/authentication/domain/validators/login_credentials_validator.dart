import 'package:eks_sana_plus_org/src/shared/validator/validations/max_length_validation.dart';
import 'package:eks_sana_plus_org/src/shared/validator/validations/required_validation.dart';
import 'package:eks_sana_plus_org/src/shared/validator/validator.dart';

class LoginCredentialsValidator {
  LoginCredentialsValidator._();

  static const int userNameMaxLength = 20;
  static const int passwordMaxLength = 30;

  static String? validateUserName(String? value) {
    return Validator.apply<String>(
      const [
        RequiredValidation<String>(fieldName: 'نام کاربری'),
        MaxLengthValidation(
          maxLength: userNameMaxLength,
          fieldName: 'نام کاربری',
        ),
      ],
    )(value);
  }

  static String? validatePassword(String? value) {
    return Validator.apply<String>(
      const [
        RequiredValidation<String>(fieldName: 'رمز عبور'),
        MaxLengthValidation(
          maxLength: passwordMaxLength,
          fieldName: 'رمز عبور',
        ),
      ],
    )(value);
  }

  static String? validateCaptchaCode(String? value) {
    return Validator.apply<String>(
      const [
        RequiredValidation<String>(fieldName: 'کد امنیتی'),
      ],
    )(value);
  }

  static bool areValid({
    required String? userName,
    required String? password,
  }) {
    return validateUserName(userName) == null &&
        validatePassword(password) == null;
  }
}
