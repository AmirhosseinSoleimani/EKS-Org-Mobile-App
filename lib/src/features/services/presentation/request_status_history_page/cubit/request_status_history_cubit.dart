import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_status_history_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';

import 'package:injectable/injectable.dart';

import 'request_status_history_state.dart';

@injectable
class RequestStatusHistoryCubit
    extends Cubit<RequestStatusHistoryState> {
  final GetRequestStatusHistoryUseCase _getRequestStatusHistoryUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;

  RequestStatusHistoryCubit(
      this._getRequestStatusHistoryUseCase,
      this._fetchSelectedRequestItemUseCase,
      this._getReliefRequestByIdUseCase,
      this._getHomeServiceRequestByIdUseCase,
      this._getEmdadgarInfoUseCase,
      )  : super(const RequestStatusHistoryState.idle());

  int _page = 1;
  final int _pageSize = 3;
  bool _hasMore = true;

  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  List<RequestStatusHistoryItemEntity> items = [];

  Future<void> init() async {

    selectedRequest = await _fetchSelectedRequestItemUseCase();

    if (selectedRequest == null) {
      _safeEmit(const RequestStatusHistoryState.error(message: BottomSheetMessageModel(title: '', message: 'در دریافت اطلاعات اولیه مشکلی رخ داد.')));

      return;
    }

    _safeEmit(const RequestStatusHistoryState.loading());

    await _refreshRequestData();

   if ((selectedRequest?.requestStatus ?? 0) > 1) {
      await _fetchEmdadgarInfo();
    }

    await _fetchHistory();
  }

  Future<void> _refreshRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result =
        selectedRequest!.isHomeService
            ? await _getHomeServiceRequestByIdUseCase(id)
            : await _getReliefRequestByIdUseCase(id);

    result.whenOrNull(
      success: (data, _, __) {
        selectedRequest = data;
      },
    );
  }

  Future<void> _fetchEmdadgarInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest!.id,
      serviceType: selectedRequest!.serviceType?.value ?? 1,
    );

    final result = await _getEmdadgarInfoUseCase(param);

    result.whenOrNull(
      success: (data, _, __) {
        emdadgarInfo = data;
      },
    );
  }

  Future<void> _fetchHistory() async {
    final param = RequestOperationParamEntity(
      requestId: selectedRequest?.id ?? 0,
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      page: _page,
      pageSize: _pageSize,
    );

    final result = await _getRequestStatusHistoryUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        items = data.records;
        _safeEmit(const RequestStatusHistoryState.loaded());
      },
      failure: (error, message) {
        _safeEmit( RequestStatusHistoryState.error(message: BottomSheetMessageModel(title: '',message:message ?? error.toString())));
      },
      connectionError: () {
        _safeEmit(const RequestStatusHistoryState.connectionError());
      },
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    _safeEmit(const RequestStatusHistoryState.loadingMore());

    _page++;

    final result = await _getRequestStatusHistoryUseCase(
      RequestOperationParamEntity(
        serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
        requestId: selectedRequest?.id ?? 0,
        page: _page,
        pageSize: _pageSize,
      ),
    );

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (data.records.isEmpty) {
          _hasMore = false;
        } else {
          items.addAll(data.records);
          if ( data.count <= items.length) {
            _hasMore = false;
          }
        }
        _safeEmit(const RequestStatusHistoryState.loadedMore());
      },
      failure: (error, msg) {
        _page--;
        _safeEmit(RequestStatusHistoryState.loadMoreError(msg ?? error.toString()));
      },
      connectionError: () {
        _page--;
        _safeEmit(const RequestStatusHistoryState.loadMoreError(
            'اتصال اینترنت را بررسی کرده و دوباره تلاش کنید.'));
      },
    );
  }

  bool get hasMore => _hasMore;

  void _safeEmit(RequestStatusHistoryState state) {
    if (!isClosed) emit(state);
  }
}
