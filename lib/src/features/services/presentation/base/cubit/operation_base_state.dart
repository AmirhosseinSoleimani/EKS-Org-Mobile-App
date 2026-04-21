import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_base_state.freezed.dart';

@freezed
class OperationBaseState<T> with _$OperationBaseState<T> {
  const factory OperationBaseState.loading() = _Loading<T>;

  const factory OperationBaseState.loaded() = _Loaded<T>;

  const factory OperationBaseState.loadingMore() = _LoadingMore<T>;

  const factory OperationBaseState.error(BottomSheetMessageModel message) = _Error<T>;

  const factory OperationBaseState.connectionError() = _ConnectionError<T>;
}
