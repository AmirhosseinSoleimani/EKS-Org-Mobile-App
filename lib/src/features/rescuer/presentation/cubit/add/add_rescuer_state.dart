class AddRescuerState {
  const AddRescuerState({
    this.currentStep = 0,
    this.isLoading = false,
    this.isLoadingCities = false,
    this.errorMessage,
    this.connectionError = false,
    this.createdId,
    this.isActive = true,
  });

  final int currentStep;
  final bool isLoading;
  final bool isLoadingCities;
  final String? errorMessage;
  final bool connectionError;
  final String? createdId;
  final bool isActive;

  AddRescuerState copyWith({
    int? currentStep,
    bool? isLoading,
    bool? isLoadingCities,
    String? errorMessage,
    bool clearError = false,
    bool? connectionError,
    String? createdId,
    bool? isActive,
  }) {
    return AddRescuerState(
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? this.isLoading,
      isLoadingCities: isLoadingCities ?? this.isLoadingCities,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      connectionError: connectionError ?? this.connectionError,
      createdId: createdId ?? this.createdId,
      isActive: isActive ?? this.isActive,
    );
  }
}
