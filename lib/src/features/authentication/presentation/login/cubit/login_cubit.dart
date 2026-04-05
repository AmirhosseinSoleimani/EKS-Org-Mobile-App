import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/entity/send_otp_code_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/phone_number_validator_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/domain/use_cases/send_opt_code_use_case.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {

  final SendOTPCodeUseCase _sendOTPCodeUseCase;
  final PhoneNumberValidatorUseCase _phoneNumberValidatorUseCase;

  LoginCubit(
      this._sendOTPCodeUseCase,
      this._phoneNumberValidatorUseCase,
      ) : super(const LoginState.idle()) {
    phoneNumberController.addListener(_onChanged);
  }

  final phoneNumberController = TextEditingController();

  final validationNotifier = ValueNotifier<bool>(false);

  bool get isWeb => kIsWeb;

  String? phoneNumberValidate(String? value) => _phoneNumberValidatorUseCase.call(value);


  void _onChanged() {
    validationNotifier.value = phoneNumberController.text.length == 11;
  }

  void privacyPolicyUrl() => launchUrl(Uri.parse(AppConstants.privacyPolicyUrl));

  Future<void> sendOTPCode() async {
    emit(const LoginState.loading());
    final result = await _sendOTPCodeUseCase.call(
        SendOtpCodeRequestEntity(
          mobileNumber: phoneNumberController.text,
        )
      );
      result.whenOrNull(
        success: (_, __, ___) => emit(const LoginState.success()),
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

  void onLogoAnimationFinished() {
    emit(const LoginState.animationCompleted());
  }

  @override
  Future<void> close() {
    phoneNumberController.removeListener(_onChanged);
    phoneNumberController.dispose();
    validationNotifier.dispose();
    return super.close();
  }
}
