import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/login_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/phone_number_validator_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final PhoneNumberValidatorUseCase _phoneNumberValidatorUseCase;

  LoginCubit(this.loginUseCase,
      this._phoneNumberValidatorUseCase,
      ) : super(const LoginState.idle()) {
    userNameController.addListener(_onChanged);
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final validationNotifier = ValueNotifier<bool>(false);

  bool get isWeb => kIsWeb;

  String? phoneNumberValidate(String? value) => _phoneNumberValidatorUseCase.call(value);


  void _onChanged() {
    validationNotifier.value = userNameController.text.length == 11;
  }

  void privacyPolicyUrl() => launchUrl(Uri.parse(AppConstants.privacyPolicyUrl));

  Future<void> login() async {
     emit(const LoginState.loading());
     final loginParam = LoginRequestEntity(
       userName: userNameController.text,
     password: passwordController.text,
     );
    final result = await loginUseCase.call(loginParam);
      result.whenOrNull(
        success: (data, _, _) {
          emit(const LoginState.success());
        },
        failure: (error, failure) {
        emit(
          LoginState.error(
            errorMessage: failure ?? 'درخواست شما با خطا مواجه شد، لطفا با شماره 096550 تماس بگیرید',
          ),
        );
        },
      connectionError: () => emit(const LoginState.connectionError()),
    );
  }

  @override
  Future<void> close() {
    userNameController.removeListener(_onChanged);
    userNameController.dispose();
    passwordController.dispose();
    validationNotifier.dispose();
    return super.close();
  }
}
