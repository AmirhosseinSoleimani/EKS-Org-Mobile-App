import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_status_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_request_status_history_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'request_status_history_state.dart';

@injectable
class RequestStatusHistoryCubit extends Cubit<RequestStatusHistoryState> {
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
  ) : super(const RequestStatusHistoryState.idle());

  static const int _initialVisibleItemCount = 3;

  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  List<RequestStatusHistoryItemEntity> items = [];
  List<RequestStatusHistoryItemEntity> _allItems = [];

  Future<void> init() async {
    _resetHistory();
    emdadgarInfo = null;

    selectedRequest = await _fetchSelectedRequestItemUseCase();

    if (selectedRequest == null) {
      _safeEmit(
        const RequestStatusHistoryState.error(
          message: BottomSheetMessageModel(
            title: '',
            message: 'در دریافت اطلاعات اولیه مشکلی رخ داد.',
          ),
        ),
      );
      return;
    }

    _safeEmit(const RequestStatusHistoryState.loading());

    await _refreshRequestData();

    if (_shouldFetchEmdadgarInfo) {
      await _fetchEmdadgarInfo();
    }

    await _fetchHistory();
  }

  void _resetHistory() {
    items = [];
    _allItems = [];
  }

  bool get _shouldFetchEmdadgarInfo {
    if (selectedRequest?.serviceType == ServiceType.homeService) {
      return selectedRequest?.hasEmdadgar == true;
    }

    return (selectedRequest?.planningId ?? 0) > 0;
  }

  Future<void> _refreshRequestData() async {
    final id = selectedRequest?.id ?? 0;
    final result = selectedRequest!.isHomeService
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    result.whenOrNull(
      success: (data, _, _) {
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
      success: (data, _, _) {
        emdadgarInfo = data;
      },
    );
  }

  Future<void> _fetchHistory() async {
    final param = RequestOperationParamEntity(
      requestId: selectedRequest?.id ?? 0,
      serviceType:
          selectedRequest?.serviceType ?? ServiceType.reliefService,
    );

    final result = await _getRequestStatusHistoryUseCase(param);

    result.when(
      success: (data, _, _) {
        _allItems = _deduplicate(data.records);
        items = _allItems.take(_initialVisibleItemCount).toList(growable: false);
        _safeEmit(const RequestStatusHistoryState.loaded());
      },
      failure: (error, message) {
        _safeEmit(
          RequestStatusHistoryState.error(
            message: BottomSheetMessageModel(
              title: '',
              message: message ?? error.toString(),
            ),
          ),
        );
      },
      connectionError: () {
        _safeEmit(const RequestStatusHistoryState.connectionError());
      },
      expireToken: () {
        _safeEmit(
          const RequestStatusHistoryState.error(
            message: BottomSheetMessageModel(
              title: '',
              message: 'نشست شما منقضی شده است. لطفا دوباره وارد شوید.',
            ),
          ),
        );
      },
    );
  }

  void loadMore() {
    if (!hasMore) return;

    items = List<RequestStatusHistoryItemEntity>.unmodifiable(_allItems);
    _safeEmit(const RequestStatusHistoryState.loadedMore());
  }

  List<RequestStatusHistoryItemEntity> _deduplicate(
    Iterable<RequestStatusHistoryItemEntity> source,
  ) {
    final keys = <String>{};
    return source
        .where((item) => keys.add(_historyKey(item)))
        .toList(growable: false);
  }

  String _historyKey(RequestStatusHistoryItemEntity item) {
    final id = item.id;
    if (id != null) return 'id:$id';

    return [
      item.serviceRequestId,
      item.refId,
      item.insertDateTime,
      item.insertDateTimeJalali,
      item.insertTime,
      item.title,
      item.description,
    ].join('|');
  }

  bool get hasMore => items.length < _allItems.length;

  void _safeEmit(RequestStatusHistoryState state) {
    if (!isClosed) emit(state);
  }
}
