import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_status_history_state.freezed.dart';

@freezed
class RequestStatusHistoryState with _$RequestStatusHistoryState {
  const factory RequestStatusHistoryState.idle() = _Idle;


  const factory RequestStatusHistoryState.loading() = _Loading;

  const factory RequestStatusHistoryState.loaded() = _Loaded;

  const factory RequestStatusHistoryState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory RequestStatusHistoryState.loadingMore() = _LoadingMore;

  const factory RequestStatusHistoryState.loadedMore() = _LoadedMore;

  const factory RequestStatusHistoryState.loadMoreError(String message) = _LoadMoreError;

  const factory RequestStatusHistoryState.connectionError() = _ConnectionError;
}
