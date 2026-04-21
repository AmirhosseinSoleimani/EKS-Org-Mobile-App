import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'operation_base_state.dart';

abstract class OperationBaseCubit<T> extends Cubit<OperationBaseState<T>> {
  OperationBaseCubit() : super(const OperationBaseState.loading());

  Future<void> init();

  void emitLoading() => emit(const OperationBaseState.loading());

  void emitLoaded() => emit(const OperationBaseState.loaded());

  void emitLoadingMore() => emit(const OperationBaseState.loadingMore());

  void emitError(BottomSheetMessageModel message) => emit(OperationBaseState.error(message));

  void emitConnectionError() =>
      emit(const OperationBaseState.connectionError());
}
