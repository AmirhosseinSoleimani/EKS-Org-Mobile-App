part of 'chassis_request_history_cubit.dart';

@freezed
class ChassisRequestHistoryState with _$ChassisRequestHistoryState {
  const factory ChassisRequestHistoryState.idle() = _Idle;

  const factory ChassisRequestHistoryState.loading() = _Loading;

  const factory ChassisRequestHistoryState.loaded() = _Loaded;

  const factory ChassisRequestHistoryState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory ChassisRequestHistoryState.loadingMore() = _LoadingMore;


  const factory ChassisRequestHistoryState.connectionError() = _ConnectionError;
}
