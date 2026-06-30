import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/get_current_session.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/phone_number_validator_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final PhoneNumberValidatorUseCase _phoneNumberValidatorUseCase;
  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  final CurrentSessionManager _currentSessionManager;

  LoginCubit(
      this.loginUseCase,
      this._phoneNumberValidatorUseCase,
      this._getCurrentSessionUseCase,
      this._currentSessionManager,
      ) : super(const LoginState.idle()) {
    userNameController.addListener(_onChanged);
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final validationNotifier = ValueNotifier<bool>(false);

  bool get isWeb => kIsWeb;

  String? phoneNumberValidate(String? value) {
    return _phoneNumberValidatorUseCase.call(value);
  }

  void _onChanged() {
    validationNotifier.value = userNameController.text.length == 11;
  }

  void privacyPolicyUrl() {
    launchUrl(Uri.parse(AppConstants.privacyPolicyUrl));
  }

  Future<void> login() async {
    emit(const LoginState.loading());

    final loginParam = LoginRequestEntity(
      userName: userNameController.text,
      password: passwordController.text,
    );

    final result = await loginUseCase.call(loginParam);

    Future<void>? nextAction;

    result.whenOrNull(
      success: (data, failures, resultCode) {
        nextAction = _getCurrentSessionAfterLogin();
      },
      failure: (error, failure) {
        emit(
          LoginState.error(
            errorMessage: failure ?? _defaultErrorMessage,
          ),
        );
      },
      connectionError: () {
        emit(const LoginState.connectionError());
      },
    );

    if (nextAction != null) {
      await nextAction!;
    }
  }

  Future<void> _getCurrentSessionAfterLogin() async {
    final result = await _getCurrentSessionUseCase.call();

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data == null) {
          emit(
            const LoginState.error(
              errorMessage: 'اطلاعات نشست کاربر دریافت نشد.',
            ),
          );
          return;
        }

        _currentSessionManager.setCurrentSession(data);

        emit(const LoginState.success());
      },
      failure: (error, failure) {
        emit(
          LoginState.error(
            errorMessage: failure ?? 'دریافت اطلاعات کاربر با خطا مواجه شد.',
          ),
        );
      },
      connectionError: () {
        emit(const LoginState.connectionError());
      },
    );
  }

  static const String _defaultErrorMessage =
      'درخواست شما با خطا مواجه شد، لطفا با شماره 096550 تماس بگیرید';

  @override
  Future<void> close() {
    userNameController.removeListener(_onChanged);
    userNameController.dispose();
    passwordController.dispose();
    validationNotifier.dispose();
    return super.close();
  }
}
