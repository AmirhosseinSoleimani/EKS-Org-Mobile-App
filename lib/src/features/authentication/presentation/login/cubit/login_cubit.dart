import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/get_current_session.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/log_off_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/validators/login_credentials_validator.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      this.loginUseCase,
      this._getCurrentSessionUseCase,
      this._logOffUseCase,
      this._currentSessionManager,
      ) : super(const LoginState.idle()) {
    userNameController.addListener(_onCredentialsChanged);
    passwordController.addListener(_onCredentialsChanged);
  }

  final LoginUseCase loginUseCase;
  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  final LogOffUseCase _logOffUseCase;
  final CurrentSessionManager _currentSessionManager;

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final validationNotifier = ValueNotifier<bool>(false);

  Future<void> Function()? _retryAction;

  bool get isWeb => kIsWeb;

  Future<void> init() async {
    await _logOffUseCase.call();
  }

  void _onCredentialsChanged() {
    _updateValidation();
  }

  void _updateValidation() {
    validationNotifier.value = LoginCredentialsValidator.areValid(
      userName: userNameController.text,
      password: passwordController.text,
    );
  }

  String? validateUserName(String? value) {
    return LoginCredentialsValidator.validateUserName(value);
  }

  String? validatePassword(String? value) {
    return LoginCredentialsValidator.validatePassword(value);
  }

  void privacyPolicyUrl() {
    launchUrl(Uri.parse(AppConstants.privacyPolicyUrl));
  }

  Future<void> login() async {
    if (!LoginCredentialsValidator.areValid(
      userName: userNameController.text,
      password: passwordController.text,
    )) {
      return;
    }

    emit(const LoginState.loading());

    final loginParam = LoginRequestEntity(
      userName: userNameController.text,
      password: passwordController.text,
    );

    final result = await loginUseCase.call(loginParam);

    Future<void>? nextAction;

    result.whenOrNull(
      success: (data, failures, resultCode) {
        _retryAction = null;
        nextAction = _getCurrentSessionAfterLogin();
      },
      failure: (error, failure) {
        _retryAction = null;
        _emitError(failure ?? _defaultErrorMessage);
        _updateValidation();
      },
      connectionError: () {
        _retryAction = login;
        _emitConnectionError();
      },
    );

    if (nextAction != null) {
      await nextAction!;
    }
  }

  Future<void> retry() async {
    final action = _retryAction;

    if (action != null) {
      await action();
      return;
    }

    await login();
  }

  Future<void> _getCurrentSessionAfterLogin() async {
    final result = await _getCurrentSessionUseCase.call();

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data == null) {
          _retryAction = null;
          _emitError('اطلاعات نشست کاربر دریافت نشد.');
          return;
        }

        _currentSessionManager.setCurrentSession(data);
        _retryAction = null;

        emit(const LoginState.success());
      },
      failure: (error, failure) {
        _retryAction = null;
        _emitError(
          failure ?? 'دریافت اطلاعات کاربر با خطا مواجه شد.',
        );
      },
      connectionError: () {
        _retryAction = _getCurrentSessionAfterLogin;
        _emitConnectionError();
      },
    );
  }

  void _emitError(String message) {
    if (state == LoginState.error(errorMessage: message)) {
      emit(const LoginState.idle());
    }

    emit(LoginState.error(errorMessage: message));
  }

  void _emitConnectionError() {
    state.whenOrNull(
      connectionError: () => emit(const LoginState.idle()),
    );

    emit(const LoginState.connectionError());
  }

  static const String _defaultErrorMessage =
      'درخواست شما با خطا مواجه شد، لطفا با شماره 096550 تماس بگیرید';

  @override
  Future<void> close() {
    userNameController.removeListener(_onCredentialsChanged);
    passwordController.removeListener(_onCredentialsChanged);

    userNameController.dispose();
    passwordController.dispose();
    validationNotifier.dispose();

    return super.close();
  }
}