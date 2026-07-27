import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/request_operation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_cartable_cycle_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cartable_cycle_cubit.freezed.dart';

part 'cartable_cycle_state.dart';



@injectable
class CartableCycleCubit extends Cubit<CartableCycleState> {
  CartableCycleCubit(
    this._getCartableCycleListUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
  ) : super(const CartableCycleState.idle());

  final GetCartableCycleListUseCase _getCartableCycleListUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;

  EmdadgarInfoEntity? emdadgarInfo;
  BaseRequestEntity? selectedBaseRequest;

  final List<CartableCycleItemEntity> items = [];

  int _page = 1;
  final int _pageSize = 3;
  bool _hasMore = true;
  String? _errorMessage;

  bool get hasMore => _hasMore;

  String _fallbackError([String? msg]) =>
      msg?.trim().isNotEmpty == true
          ? msg!
          : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';

  Future<void> init() async {
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const CartableCycleState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const CartableCycleState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<FetchResultType> _initializeData() async {
    _clearData();

    final selectedResult = await _fetchSelectedServiceRequest();
    if (selectedResult != FetchResultType.success) {
      return selectedResult;
    }
    _safeEmit(const CartableCycleState.loading());

    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    if (_shouldFetchEmdadgarInfo) {
      final emdadgarResult = await _fetchEmdadgarInfo();
      if (emdadgarResult != FetchResultType.success) {
        return emdadgarResult;
      }
    }

    final listResult = await _loadCartableCycleList();
    if (listResult != FetchResultType.success) {
      return listResult;
    }

    return FetchResultType.success;
  }

  bool get _shouldFetchEmdadgarInfo {
    return (selectedBaseRequest?.requestStatus ?? 0) > 1;
  }

  Future<FetchResultType> _fetchSelectedServiceRequest() async{
    try{
      selectedBaseRequest = await _fetchSelectedRequestItemUseCase.call();
      return FetchResultType.success;
    } catch (_) {
      _errorMessage = _fallbackError();
      return FetchResultType.failure;
    }
  }

  Future<FetchResultType> _fetchServiceRequestData() async {
    final id   = selectedBaseRequest?.id ?? 0;

    final result =
    (selectedBaseRequest?.serviceType == ServiceType.homeService)
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, _) {
        selectedBaseRequest = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage  = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
        connectionError: () {
          fetchResult = FetchResultType.connectionError;
        },
      expireToken: () {
        fetchResult = FetchResultType.expireToken;
      },
    );
    return fetchResult;
  }

  Future<FetchResultType> _fetchEmdadgarInfo() async {

    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedBaseRequest?.id ?? 0,
      serviceType: selectedBaseRequest?.serviceType?.value ?? 1,
    );
    final result = await _getEmdadgarInfoUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, _) {
        emdadgarInfo = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      expireToken: () {
        fetchResult = FetchResultType.expireToken;
      },
    );
    return fetchResult;
  }

  Future<FetchResultType> _loadCartableCycleList() async {
    _resetPagination();

    final result = await _getCartableCycleListUseCase(
      _requestOperationParam,
    );

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, failures, resultCode) {
        items.addAll(data);
        _hasMore = data.length >= _pageSize;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () => fetchResult = FetchResultType.connectionError,
      expireToken: () {
        fetchResult = FetchResultType.expireToken;
      },
    );
    return fetchResult;
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    if (state == const CartableCycleState.loadingMore()) return;

    _safeEmit(const CartableCycleState.loadingMore());

    _page++;

    final result = await _getCartableCycleListUseCase(
      _requestOperationParam,
    );

    result.whenOrNull(
      success: (data, _, _) {
        if (data.isEmpty) {
          _hasMore = false;
        } else {
          items.addAll(data);
          _hasMore = data.length >= _pageSize;
        }

        _safeEmit(const CartableCycleState.loadedMore());
      },
      failure: (_, message) {
        _rollbackPage();
        _errorMessage = _fallbackError(message);
        _safeEmit(const CartableCycleState.loaded());
      },
      connectionError: () {
        _rollbackPage();
        _safeEmit(const CartableCycleState.connectionError());
      },
      expireToken: () {
        _rollbackPage();
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
      },
    );
  }

  RequestOperationParamEntity get _requestOperationParam {
    return RequestOperationParamEntity(
      serviceType: selectedBaseRequest?.serviceType ?? ServiceType.reliefService,
      requestId: selectedBaseRequest?.id ?? 0,
      page: _page,
      pageSize: _pageSize,
    );
  }

  void _resetPagination() {
    _page = 1;
    _hasMore = true;
    items.clear();
  }

  void _rollbackPage() {
    if (_page > 1) _page--;
  }

  void _clearData() {
    _errorMessage = null;
    emdadgarInfo = null;
    selectedBaseRequest = null;
    items.clear();
    _page = 1;
    _hasMore = true;
  }

  void _emitError([String? message]) {
    _safeEmit(
      CartableCycleState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  void _safeEmit(CartableCycleState state) {
    if (!isClosed) emit(state);
  }
}
