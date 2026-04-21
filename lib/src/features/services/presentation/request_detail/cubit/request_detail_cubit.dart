import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_followup_history_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'request_detail_cubit.freezed.dart';
part 'request_detail_state.dart';
@injectable
class RequestDetailCubit extends Cubit<RequestDetailState> {
  RequestDetailCubit(
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getRequestFollowupHistoryUseCase,
  ) : super(const RequestDetailState.idle());

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetRequestFollowupHistoryUseCase _getRequestFollowupHistoryUseCase;

  BaseRequestEntity? selectedRequest;
  List<FollowupEntity> followups = [];

  bool get isRelief =>
      selectedRequest?.serviceType == ServiceType.reliefService;

  Future<void> init() async {
    _safeEmit(const RequestDetailState.loading());

    try {
      final cachedRequest = await _fetchSelectedRequestItemUseCase();

      if (cachedRequest == null) {
        _safeEmit(const RequestDetailState.error(
            message: BottomSheetMessageModel(
                title: '',
                message: "درخواستی برای نمایش جزئیات انتخاب نشده است.")));
        return;
      }

      selectedRequest = cachedRequest;

      final int? requestId = cachedRequest.id;

      if (requestId == null) {
        _safeEmit(const RequestDetailState.error(
          message: BottomSheetMessageModel(
              title: '',
              message: "درخواستی برای نمایش جزئیات انتخاب نشده است."),
        ));
        return;
      }

      if (isRelief) {
        final result = await _getReliefRequestByIdUseCase(requestId);

        result.whenOrNull(
          success: (data, failures, resultCode) {
            if (data != null) selectedRequest = data;
          },
          failure: (error, msg) {
            _safeEmit(
              RequestDetailState.error(
                message: BottomSheetMessageModel(
                  message: msg ?? 'خطای غیر منتظره',
                  title: '',
                ),
              ),
            );
          },
          connectionError: () =>
              _safeEmit(const RequestDetailState.connectionError()),
        );
      } else {
        final result = await _getHomeServiceRequestByIdUseCase(requestId);

        result.whenOrNull(
          success: (data, failures, resultCode) {
            if (data != null) selectedRequest = data;
          },
          failure: (error, msg) {
            _safeEmit(
              RequestDetailState.error(
                message: BottomSheetMessageModel(
                  message: msg ?? 'خطای غیر منتظره',
                  title: '',
                ),
              ),
            );
          },
          connectionError: () =>
              _safeEmit(const RequestDetailState.connectionError()),
        );
      }

     /* if (state is RequestDetailError ||
          state is RequestDetailConnectionError) {
        return;
      }*/

      final followupResult = await _getRequestFollowupHistoryUseCase(requestId
      /*  ServiceRequestParamEntity(
          serviceRequestId: requestId,
          serviceType: selectedRequest!.serviceType,
        ),*/
      );

      followupResult.whenOrNull(
        success: (data, failures, resultCode) {
          followups = data ?? [];
        },
        failure: (error, msg) {
          _safeEmit(
            RequestDetailState.error(
              message: BottomSheetMessageModel(
                message: msg ?? 'خطای غیر منتظره',
                title: '',
              ),
            ),
          );
        },
        connectionError: () =>
            _safeEmit(const RequestDetailState.connectionError()),
      );

      _safeEmit(const RequestDetailState.loaded());
    } catch (e, st) {
      debugPrint("RequestDetailCubit.init error: $e\n$st");
      _safeEmit(const RequestDetailState.error(
        message:BottomSheetMessageModel(
            title: '',
            message: "درخواستی برای نمایش جزئیات انتخاب نشده است."),
      ));
    }
  }

  void _safeEmit(RequestDetailState state) {
    if (!isClosed) emit(state);
  }
}
