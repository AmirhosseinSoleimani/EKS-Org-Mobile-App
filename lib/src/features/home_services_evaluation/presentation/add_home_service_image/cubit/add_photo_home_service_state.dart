
import 'package:eks_sana_plus_org/src/shared/widgets/dialog_widget/dialog_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_photo_home_service_state.freezed.dart';

@freezed
class AddPhotoHomeServiceState with _$AddPhotoHomeServiceState {


  const factory AddPhotoHomeServiceState.idle() = AddPhotoHomeServiceIdleState;
  const factory AddPhotoHomeServiceState.error({required DialogDataModel dialogDataModel}) = AddPhotoHomeServiceErrorState;
  const factory AddPhotoHomeServiceState.success() = AddPhotoHomeServiceSuccessState;
  const factory AddPhotoHomeServiceState.loading() = AddPhotoHomeServiceLoadingState;

  const factory AddPhotoHomeServiceState.submitSuccess() = AddPhotoHomeServiceSubmitSuccessState;
  const factory AddPhotoHomeServiceState.submitLoading() = AddPhotoHomeServiceSubmitLoadingState;

  const factory AddPhotoHomeServiceState.evaluation({required DialogDataModel dialogDataModel}) = AddPhotoHomeServiceEvaluationState;
}