part of 'evaluation_history_cubit.dart';

@freezed
class EvaluationHistoryState with _$EvaluationHistoryState {
  const factory EvaluationHistoryState.idle() = _Idle;

  const factory EvaluationHistoryState.loading() = _Loading;

  const factory EvaluationHistoryState.loaded() = _Loaded;

  const factory EvaluationHistoryState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory EvaluationHistoryState.loadingMore() = _LoadingMore;


  const factory EvaluationHistoryState.connectionError() = _ConnectionError;
}
