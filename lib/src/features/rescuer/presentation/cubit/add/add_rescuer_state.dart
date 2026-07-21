class AddRescuerState {
  final int currentStep;
  final bool isLoading;
  final bool isLoadingCities;
  final String? errorMessage;
  final bool connectionError;
  final String? createdId;

  const AddRescuerState({
    this.currentStep = 0,
    this.isLoading = false,
    this.isLoadingCities = false,
    this.errorMessage,
    this.connectionError = false,
    this.createdId,
  });

  AddRescuerState copyWith({
    int? currentStep,
    bool? isLoading,
    bool? isLoadingCities,
    String? errorMessage,
    bool clearError = false,
    bool? connectionError,
    String? createdId,
  }) => AddRescuerState(
    currentStep: currentStep ?? this.currentStep,
    isLoading: isLoading ?? this.isLoading,
    isLoadingCities: isLoadingCities ?? this.isLoadingCities,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    connectionError: connectionError ?? this.connectionError,
    createdId: createdId ?? this.createdId,
  );
}
