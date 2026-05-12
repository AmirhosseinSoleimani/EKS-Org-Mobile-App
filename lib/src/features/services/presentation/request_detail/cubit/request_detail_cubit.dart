import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/followup_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_followup_history_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_status_history_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    this._getEmdadgarInfoUseCase,
    this._getRequestStatusHistoryUseCase,
  ) : super(const RequestDetailState.idle());

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetRequestFollowupHistoryUseCase _getRequestFollowupHistoryUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetRequestStatusHistoryUseCase _getRequestStatusHistoryUseCase;

  BaseRequestEntity? selectedRequest;
  List<FollowupItemEntity> followups = [];
  List<RequestStatusHistoryItemEntity> requestStatusHistory = [];
  EmdadgarInfoEntity? emdadgarInfo;

  final int _pageSize = 10;



  Future<void> init() async {
    try {
      selectedRequest = await _fetchSelectedRequestItemUseCase();
      if (selectedRequest == null) {
        _safeEmit(const RequestDetailState.error(
            message: BottomSheetMessageModel(
                title: '',
                message: "درخواستی برای نمایش جزئیات انتخاب نشده است.")));
        return;
      }

      bool  isRelief  = selectedRequest?.serviceType == ServiceType.reliefService;

      _safeEmit(const RequestDetailState.loading());

      final int? requestId = selectedRequest?.id;

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
                  message: msg ?? error.toString(),
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
                  message: msg ?? error.toString(),
                  title: '',
                ),
              ),
            );
          },
          connectionError: () =>
              _safeEmit(const RequestDetailState.connectionError()),
        );
      }

      await _fetchEmdadgarInfo();

      final RequestOperationParamEntity param = RequestOperationParamEntity(
        serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
        requestId: requestId,
        pageSize: _pageSize,
      );
      final followupResult = await _getRequestFollowupHistoryUseCase(param);

      followupResult.whenOrNull(
        success: (data, failures, resultCode) {
          followups = data.followUpList ?? [];
        },
        failure: (error, msg) {
          _safeEmit(
            RequestDetailState.error(
              message: BottomSheetMessageModel(
                message: msg ?? error.toString(),
                title: '',
              ),
            ),
          );
        },
        connectionError: () =>
            _safeEmit(const RequestDetailState.connectionError()),
      );

      final requestStatusHistoryResult = await _getRequestStatusHistoryUseCase(param);

      requestStatusHistoryResult.whenOrNull(
        success: (data, failures, resultCode) {
          requestStatusHistory = data.records;
        },
        failure: (error, msg) {
          _safeEmit(
            RequestDetailState.error(
              message: BottomSheetMessageModel(
                message: msg ?? error.toString(),
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


  Future<void> _fetchEmdadgarInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest!.id,
      serviceType: selectedRequest!.serviceType?.value ?? 1,
    );

    final result = await _getEmdadgarInfoUseCase(param);

    result.whenOrNull(
      success: (data, _, _) {
        emdadgarInfo = data;
      },
    );
  }

  void _safeEmit(RequestDetailState state) {
    if (!isClosed) emit(state);
  }
}
