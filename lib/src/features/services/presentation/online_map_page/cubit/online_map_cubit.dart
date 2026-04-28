import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/route_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_route_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'online_map_cubit.freezed.dart';
part 'online_map_state.dart';

@injectable
class OnlineMapCubit extends Cubit<OnlineMapState> {
  OnlineMapCubit(
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
    this._getRouteUseCase,
  ) : super(const OnlineMapState.idle());

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetRouteUseCase _getRouteUseCase;

  EmdadgarInfoEntity? emdadgarInfo;
  BaseRequestEntity? selectedRequest;
  RouteDataEntity? routeDataEntity;
  bool isDetailsExpanded = false;
  Timer? _pollingTimer;

  final List<dynamic> items = [];
  String? _errorMessage;

  String _fallbackError([String? msg]) => msg?.trim().isNotEmpty == true
      ? msg!
      : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';

  Future<void> init() async {
    _safeEmit(const OnlineMapState.loading());

    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const OnlineMapState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const OnlineMapState.connectionError());
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

    final mapDataResult = await _loadOnlineMapData();
    if (mapDataResult != FetchResultType.success) {
      return mapDataResult;
    }

    return FetchResultType.success;
  }

  bool get _shouldFetchEmdadgarInfo {
    return (selectedRequest?.requestStatus ?? 0) > 1;
  }

  Future<FetchResultType> _fetchSelectedServiceRequest() async {
    try {
      selectedRequest = await _fetchSelectedRequestItemUseCase.call();
      return FetchResultType.success;
    } catch (_) {
      _errorMessage = _fallbackError();
      return FetchResultType.failure;
    }
  }

  Future<FetchResultType> _fetchServiceRequestData() async {
    final id = selectedRequest?.id ?? 0;

    final result = (selectedRequest?.serviceType == ServiceType.homeService)
        ? await _getHomeServiceRequestByIdUseCase(id)
        : await _getReliefRequestByIdUseCase(id);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
        selectedRequest = data;
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

  Future<FetchResultType> _fetchEmdadgarInfo() async {
    final param = ServiceRequestParamEntity(
      serviceRequestId: selectedRequest?.id ?? 0,
      serviceType: selectedRequest?.serviceType?.value ?? 1,
    );
    final result = await _getEmdadgarInfoUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
        emdadgarInfo = data;
        fetchResult = FetchResultType.success;
       // _startPolling();
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

  Future<FetchResultType> _loadOnlineMapData() async {
    final startParam = LocationParamEntity(
      latitude: emdadgarInfo?.lastLocationLatitude ?? 0,
      longitude: emdadgarInfo?.lastLocationLongitude ?? 0,
    );
    final destinationParam = LocationParamEntity(
      latitude: selectedRequest?.latitude ?? 0,
      longitude: selectedRequest?.longitude ?? 0,
    );

    final routeParam = RouteParamEntity(
      start: startParam,
      destination: destinationParam,
      includeLegs: true,
      includeStepsPoints: true,
    );
    final result = await _getRouteUseCase(routeParam);
    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, failures, resultCode) {
        routeDataEntity = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
      },
      connectionError: () => fetchResult = FetchResultType.connectionError,
      expireToken: () => fetchResult = FetchResultType.expireToken,
    );
    return fetchResult;
  }

  void _startPolling() {
    _pollingTimer?.cancel();

    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      final emdadgarResult = await _fetchEmdadgarInfo();

      final mapDataResult = await _loadOnlineMapData();

      if (emdadgarResult == FetchResultType.success &&
          mapDataResult == FetchResultType.success) {
        _safeEmit(const OnlineMapState.refresh());
      }
    });
  }

  void _clearData() {
    _errorMessage = null;
    emdadgarInfo = null;
    selectedRequest = null;
    routeDataEntity = null;
    items.clear();
  }

  void _emitError([String? message]) {
    _safeEmit(
      OnlineMapState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  void _safeEmit(OnlineMapState state) {
    if (!isClosed) emit(state);
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }

  void toggleMapDetails() {
    isDetailsExpanded = !isDetailsExpanded;
    _safeEmit(const OnlineMapState.refresh());
  }

}
