import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {

  const factory LoginState.idle() = _Idle;

  const factory LoginState.error({required String errorMessage}) = _Error;

  const factory LoginState.loading() = _Loading;

  const factory LoginState.success() = _Succes;

  const factory LoginState.animationCompleted() = _AnimationCompleted;

  const factory LoginState.connectionError() = _ConnectionError;

}
