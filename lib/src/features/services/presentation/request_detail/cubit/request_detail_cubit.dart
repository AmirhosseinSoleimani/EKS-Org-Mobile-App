import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
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
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
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

  static const int _pageSize = 10;

  Future<void> init({
    int? requestId,
    ServiceType? serviceType,
  }) async {
    try {
      final cachedRequest = await _fetchSelectedRequestItemUseCase();
      final resolvedRequestId = requestId ?? cachedRequest?.id;
      final resolvedServiceType = serviceType ?? cachedRequest?.serviceType;

      // Route arguments are the source of truth when opening a specific
      // history row. Do not render a previously cached request while the
      // explicitly selected request is being loaded.
      selectedRequest = requestId == null && serviceType == null
          ? cachedRequest
          : null;
      followups = [];
      requestStatusHistory = [];
      emdadgarInfo = null;

      if (resolvedRequestId == null || resolvedServiceType == null) {
        _emitMissingRequestError();
        return;
      }

      _safeEmit(const RequestDetailState.loading());

      final requestLoaded = await _loadRequestDetails(
        requestId: resolvedRequestId,
        serviceType: resolvedServiceType,
      );
      if (!requestLoaded || selectedRequest == null) return;

      if (_shouldLoadEmdadgarInfo) {
        await _fetchEmdadgarInfo();
      }

      final param = RequestOperationParamEntity(
        serviceType: selectedRequest?.serviceType ?? resolvedServiceType,
        requestId: resolvedRequestId,
        pageSize: _pageSize,
      );

      final followupLoaded = await _fetchFollowups(param);
      if (!followupLoaded) return;

      final statusHistoryLoaded = await _fetchRequestStatusHistory(param);
      if (!statusHistoryLoaded) return;

      _safeEmit(const RequestDetailState.loaded());
    } catch (e, st) {
      debugPrint('RequestDetailCubit.init error: $e\n$st');
      _safeEmit(
        RequestDetailState.error(
          message: BottomSheetMessageModel(
            title: '',
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<bool> _loadRequestDetails({
    required int requestId,
    required ServiceType serviceType,
  }) async {
    final result = serviceType == ServiceType.reliefService
        ? await _getReliefRequestByIdUseCase(requestId)
        : await _getHomeServiceRequestByIdUseCase(requestId);

    return result.when(
      success: (data, _, __) {
        selectedRequest = data;
        return data != null;
      },
      failure: (error, message) {
        _emitError(message ?? error.toString());
        return false;
      },
      expireToken: () {
        _emitError('نشست کاربری منقضی شده است.');
        return false;
      },
      connectionError: () {
        _safeEmit(const RequestDetailState.connectionError());
        return false;
      },
    );
  }

  Future<bool> _fetchFollowups(RequestOperationParamEntity param) async {
    final result = await _getRequestFollowupHistoryUseCase(param);

    return result.when(
      success: (data, _, __) {
        followups = data.followUpList ?? [];
        return true;
      },
      failure: (error, message) {
        _emitError(message ?? error.toString());
        return false;
      },
      expireToken: () {
        _emitError('نشست کاربری منقضی شده است.');
        return false;
      },
      connectionError: () {
        _safeEmit(const RequestDetailState.connectionError());
        return false;
      },
    );
  }

  Future<bool> _fetchRequestStatusHistory(
    RequestOperationParamEntity param,
  ) async {
    final result = await _getRequestStatusHistoryUseCase(param);

    return result.when(
      success: (data, _, __) {
        requestStatusHistory = data.records;
        return true;
      },
      failure: (error, message) {
        _emitError(message ?? error.toString());
        return false;
      },
      expireToken: () {
        _emitError('نشست کاربری منقضی شده است.');
        return false;
      },
      connectionError: () {
        _safeEmit(const RequestDetailState.connectionError());
        return false;
      },
    );
  }

  bool get _shouldLoadEmdadgarInfo =>
      (selectedRequest?.planningId ?? 0) > 0 ||
      (selectedRequest?.emdadgarId ?? 0) > 0;

  Future<void> _fetchEmdadgarInfo() async {
    final request = selectedRequest;
    if (request?.id == null || request?.serviceType == null) return;

    final param = ServiceRequestParamEntity(
      serviceRequestId: request!.id,
      serviceType: request.serviceType!.value,
    );

    final result = await _getEmdadgarInfoUseCase(param);
    result.whenOrNull(
      success: (data, _, __) {
        emdadgarInfo = data;
      },
    );
  }

  void _emitMissingRequestError() {
    _safeEmit(
      const RequestDetailState.error(
        message: BottomSheetMessageModel(
          title: '',
          message: 'درخواستی برای نمایش جزئیات انتخاب نشده است.',
        ),
      ),
    );
  }

  void _emitError(String message) {
    _safeEmit(
      RequestDetailState.error(
        message: BottomSheetMessageModel(
          title: '',
          message: message,
        ),
      ),
    );
  }

  void _safeEmit(RequestDetailState state) {
    if (!isClosed) emit(state);
  }
}
