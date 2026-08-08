import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/change_password_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/change_password_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/log_off_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/profile/cubit/profile_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/validator/validations/required_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._changePasswordUseCase,
    this._logOffUseCase,
    this._currentSessionManager,
  ) : super(const ProfileState());

  final ChangePasswordUseCase _changePasswordUseCase;
  final LogOffUseCase _logOffUseCase;
  final CurrentSessionManager _currentSessionManager;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String get displayName =>
      _currentSessionManager.currentSession?.displayName?.trim().isNotEmpty ==
              true
          ? _currentSessionManager.currentSession!.displayName!.trim()
          : 'کاربر';

  String get roleName =>
      _currentSessionManager.currentSession?.displayRoleName?.trim().isNotEmpty ==
              true
          ? _currentSessionManager.currentSession!.displayRoleName!.trim()
          : 'کاربر';

  void resetPasswordForm() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    emit(const ProfileState());
  }

  String? validateRequiredPassword(String? value) {
    return const RequiredValidation<String>().validate(value);
  }

  String? validatePasswordConfirmation(String? value) {
    final requiredError = const RequiredValidation<String>().validate(value);
    if (requiredError != null) return requiredError;

    if (value != newPasswordController.text) {
      return 'تکرار رمز عبور با رمز عبور جدید یکسان نیست';
    }

    return null;
  }

  Future<void> changePassword() async {
    if (state.isChangingPassword || state.isLoggingOut) return;

    emit(
      state.copyWith(
        status: ProfileStatus.changingPassword,
        clearErrorMessage: true,
      ),
    );

    final result = await _changePasswordUseCase(
      ChangePasswordRequestEntity(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
      ),
    );

    Future<void>? nextAction;

    result.when(
      success: (data, failures, resultCode) {
        nextAction = _completePasswordChange();
      },
      failure: (error, failures) {
        emit(
          state.copyWith(
            status: ProfileStatus.changePasswordFailure,
            errorMessage: failures ?? _defaultErrorMessage,
          ),
        );
      },
      expireToken: () {
        emit(
          state.copyWith(
            status: ProfileStatus.changePasswordFailure,
            errorMessage: 'نشست کاربری منقضی شده است.',
          ),
        );
      },
      connectionError: () {
        emit(
          state.copyWith(
            status: ProfileStatus.connectionError,
            errorMessage: 'اتصال به اینترنت برقرار نیست.',
          ),
        );
      },
    );

    if (nextAction != null) {
      await nextAction!;
    }
  }

  Future<void> _completePasswordChange() async {
    await _logOffUseCase();
    emit(
      state.copyWith(
        status: ProfileStatus.changePasswordSuccess,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> logout() async {
    if (state.isLoggingOut || state.isChangingPassword) return;

    emit(
      state.copyWith(
        status: ProfileStatus.loggingOut,
        clearErrorMessage: true,
      ),
    );

    await _logOffUseCase();

    emit(
      state.copyWith(
        status: ProfileStatus.logoutSuccess,
        clearErrorMessage: true,
      ),
    );
  }

  static const String _defaultErrorMessage =
      'درخواست شما با خطا مواجه شد، لطفا با شماره 096550 تماس بگیرید';

  @override
  Future<void> close() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
