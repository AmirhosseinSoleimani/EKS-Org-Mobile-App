import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_service_kilometer_image_state.freezed.dart';

@freezed
class HomeServiceKilometerImageState with _$HomeServiceKilometerImageState {

  const factory HomeServiceKilometerImageState.idle() = _Idle;
  const factory HomeServiceKilometerImageState.error({required DialogDataModel dialogDataModel}) = _Error;
  const factory HomeServiceKilometerImageState.success() = _Success;
  const factory HomeServiceKilometerImageState.loading() = _Loading;

  const factory HomeServiceKilometerImageState.submitSuccess() = _SubmitSuccess;
  const factory HomeServiceKilometerImageState.submitLoading() = _SubmitLoading;
}