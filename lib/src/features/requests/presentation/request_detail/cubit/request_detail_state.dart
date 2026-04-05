import 'package:eks_sana_plus_org/src/features/requests/domain/entities/cancel_reasons_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/time_table_response_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_detail_state.freezed.dart';

@freezed
abstract class RequestDetailState with _$RequestDetailState {
  const factory RequestDetailState.idle() = RequestDetailIdleState;

  const factory RequestDetailState.loading() = RequestDetailLoadingState;
  const factory RequestDetailState.error(
      {required BottomSheetMessageModel message}) = RequestDetailtErrorState;

  const factory RequestDetailState.notice({required String message}) =
      RequestDetailNoticeState;

  const factory RequestDetailState.fetchedSelectedRequest() =
      RequestDetailFetchedSelectedRequestState;

  const factory RequestDetailState.getCancelReasonLoading() =
      RequestDetailGetCancelReasonLoadingState;

  const factory RequestDetailState.getCancelReasonSuccess(
          List<CancelReasonEntity> reasons) =
      RequestDetailGetCancelReasonSuccessState;

  const factory RequestDetailState.reasonNotSelectedError({
    required String message,
  }) = RequestDetailReasonNotSelectedErrorState;

  const factory RequestDetailState.cancelRequestLoading() =
      RequestDetailCancelRequestLoadingState;

  const factory RequestDetailState.cancelRequestSuccess(String message) =
      RequestDetailCancelRequestSuccessState;

  const factory RequestDetailState.getTimesLoading() = RequestDetailGetTimesLoadingState;

  const factory RequestDetailState.getTimesSuccess(
      List<DayScheduleEntity?> times) = RequestDetailGetTimesSuccessState;

  const factory RequestDetailState.changeTimeRequestLoading() =
      RequestDetailChangeTimeRequestLoadingState;

  const factory RequestDetailState.changeTimeRequestSuccess(BottomSheetMessageModel message) =
      RequestDetailChangeTimeRequestSuccessState;

  const factory RequestDetailState.daySelected(DayScheduleEntity selectedDay) = RequestDetailDaySelectedState;

  const factory RequestDetailState.timeSelected(TimeRangeEntity selectedTime) =
      RequestDetailTimeSelectedState;

  const factory RequestDetailState.updatePaymentLoading() =
      RequestDetailUpdatePaymentLoadingState;

  const factory RequestDetailState.successUpdatePayment({required String message}) =
      RequestDetailSuccessUpdatePaymentState;

  const factory RequestDetailState.errorUpdatePayment(
      {required String message}) = RequestDetailErrorUpdatePaymentState;

  const factory RequestDetailState.connectionError() = _ConnectionError;
}
