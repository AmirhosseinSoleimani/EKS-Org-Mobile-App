class AddAgencyContractState {
  const AddAgencyContractState({
    this.isSubmitting = false,
    this.errorMessage,
    this.connectionError = false,
    this.createdId,
  });

  final bool isSubmitting;
  final String? errorMessage;
  final bool connectionError;
  final String? createdId;

  AddAgencyContractState copyWith({
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
    bool? connectionError,
    String? createdId,
  }) {
    return AddAgencyContractState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      connectionError: connectionError ?? this.connectionError,
      createdId: createdId ?? this.createdId,
    );
  }
}
