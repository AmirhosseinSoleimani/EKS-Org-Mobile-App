import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_status_history_state.freezed.dart';

@freezed
class RequestStatusHistoryState with _$RequestStatusHistoryState {
  const factory RequestStatusHistoryState.idle() = _Idle;
}
