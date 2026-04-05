import 'dart:async';

import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/use_case/fetch_active_service_request_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'active_request_state.dart';

@injectable
class ActiveRequestCubit extends Cubit<ActiveRequestState> {
  final FetchActiveServiceRequestUseCase _fetchActiveServiceRequestUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;
  ActiveRequestCubit(this._fetchActiveServiceRequestUseCase,
      this._setSelectedRequestItemUseCase)
      : super(const ActiveRequestState.idle());

  final List<RequestEntity?> activeRequestList = [];

  void _safeEmit(ActiveRequestState state) {
    if (!isClosed) emit(state);
  }

  String _fallbackError([String? msg]) =>
      msg?.trim().isNotEmpty == true
          ? msg!
          : 'درخواست شما با خطا مواجه شد، لطفا با شماره 096550 تماس بگیرید';

  Future<void> init() async {
    _fetchActiveRequest();
  }

  Future<void> _fetchActiveRequest() async {
    _safeEmit(const ActiveRequestState.loading());
    final result = await _fetchActiveServiceRequestUseCase();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        activeRequestList..clear()..addAll(data);
        _safeEmit(const ActiveRequestState.success());
      },
      failure: (_, msg) {
        _safeEmit(ActiveRequestState.error(
            message: BottomSheetMessageModel(
                message: _fallbackError(msg), title: 'خطا')));
      },
      connectionError: () {
        _safeEmit(const ActiveRequestState.connectionError());
      },
    );
  }

  void setSelectedRequest(RequestEntity item) async {
    await _setSelectedRequestItemUseCase(item);
  }
}
