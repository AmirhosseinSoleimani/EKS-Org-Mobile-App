import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_base_state.freezed.dart';

@freezed
class OperationBaseState<T> with _$OperationBaseState<T> {
  const factory OperationBaseState.loading() = _Loading<T>;

  const factory OperationBaseState.loaded() = _Loaded<T>;

  const factory OperationBaseState.loadingMore() = _LoadingMore<T>;

  const factory OperationBaseState.error(String message) = _Error<T>;

  const factory OperationBaseState.connectionError() = _ConnectionError<T>;
}
