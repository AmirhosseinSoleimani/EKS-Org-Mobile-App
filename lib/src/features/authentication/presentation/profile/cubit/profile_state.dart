enum ProfileStatus {
  idle,
  changingPassword,
  loggingOut,
  changePasswordSuccess,
  logoutSuccess,
  changePasswordFailure,
  connectionError,
}

class ProfileState {
  const ProfileState({
    this.status = ProfileStatus.idle,
    this.errorMessage,
  });

  final ProfileStatus status;
  final String? errorMessage;

  bool get isChangingPassword => status == ProfileStatus.changingPassword;
  bool get isLoggingOut => status == ProfileStatus.loggingOut;

  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }
}
