class GradePatternValidationResult {
  const GradePatternValidationResult._({this.message});

  final String? message;

  bool get isValid => message == null;

  const factory GradePatternValidationResult.valid() =
      _GradePatternValidationValid;

  const factory GradePatternValidationResult.invalid(String message) =
      _GradePatternValidationInvalid;
}

class _GradePatternValidationValid extends GradePatternValidationResult {
  const _GradePatternValidationValid() : super._();
}

class _GradePatternValidationInvalid extends GradePatternValidationResult {
  const _GradePatternValidationInvalid(String message)
      : super._(message: message);
}
