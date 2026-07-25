class AddAgencyContractState {
  const AddAgencyContractState({
    this.isSubmitting = false,
    this.fileVersion = 0,
    this.errorMessage,
    this.connectionError = false,
    this.createdId,
  });

  final bool isSubmitting;
  final int fileVersion;
  final String? errorMessage;
  final bool connectionError;
  final String? createdId;

  AddAgencyContractState copyWith({
    bool? isSubmitting,
    int? fileVersion,
    String? errorMessage,
    bool clearError = false,
    bool? connectionError,
    String? createdId,
  }) {
    return AddAgencyContractState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      fileVersion: fileVersion ?? this.fileVersion,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      connectionError: connectionError ?? this.connectionError,
      createdId: createdId ?? this.createdId,
    );
  }
}
