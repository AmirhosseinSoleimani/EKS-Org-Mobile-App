import 'enums/api_failure_type.dart';

class ApiFailure {
  final ApiFailureType type;
  final String message;

  const ApiFailure.connection()
      : type = ApiFailureType.connection,
        message = '';

  const ApiFailure.general(this.message)
      : type = ApiFailureType.general;
}