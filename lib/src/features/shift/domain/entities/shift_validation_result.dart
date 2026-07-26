class ShiftValidationResult {
  const ShiftValidationResult._({
    required this.isValid,
    this.message,
  });

  const ShiftValidationResult.valid() : this._(isValid: true);

  const ShiftValidationResult.invalid(String message)
      : this._(isValid: false, message: message);

  final bool isValid;
  final String? message;
}
