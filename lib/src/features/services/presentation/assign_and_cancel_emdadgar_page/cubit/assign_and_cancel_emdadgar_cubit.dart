import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/area_business_usage_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/reason_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/check_depot_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/service_assign_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/check_depot_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/emdadgar_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_assign_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_cancel_reason_request_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_check_depot_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_non_cooperation_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/service_assign_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/enums/service_assign_action.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/data/models/online_route_model.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/area_base_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/online_route_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/area_base_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/params/route_param_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_area_base_info_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/usecase/get_route_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'assign_and_cancel_emdadgar_cubit.freezed.dart';
part 'assign_and_cancel_emdadgar_state.dart';


@injectable
class AssignAndCancelEmdadgarCubit extends Cubit<AssignAndCancelEmdadgarState> {


  void setMockRouteData() {
    final json = <String, dynamic>{
      "routes": [
        {
          "legs": [
            {
              "steps": [
                {
                  "points": [
                    [35.68813, 51.30939],
                    [35.68854, 51.30800],
                    [35.68926, 51.30559],
                    [35.69019, 51.30229],
                    [35.69161, 51.29750],
                  ],
                  "travelMode": "driving",
                  "traffic": 2.0,
                  "distance": {
                    "text": "۱ کیلومتر",
                    "value": 1000.0,
                  },
                  "duration": {
                    "text": "۳ دقیقه",
                    "value": 180.0,
                  },
                  "start": {
                    "latitude": 35.68813,
                    "longitude": 51.30939,
                  },
                  "destination": {
                    "latitude": 35.69161,
                    "longitude": 51.29750,
                  },
                },
                {
                  "points": [
                    [35.69161, 51.29750],
                    [35.69330, 51.29174],
                    [35.69549, 51.28710],
                    [35.69824, 51.28747],
                  ],
                  "travelMode": "driving",
                  "traffic": 2.0,
                  "distance": {
                    "text": "۱ کیلومتر ۸۰۰ متر",
                    "value": 1800.0,
                  },
                  "duration": {
                    "text": "۴ دقیقه",
                    "value": 240.0,
                  },
                  "start": {
                    "latitude": 35.69161,
                    "longitude": 51.29750,
                  },
                  "destination": {
                    "latitude": 35.69824,
                    "longitude": 51.28747,
                  },
                },
                {
                  "points": [
                    [35.69824, 51.28747],
                    [35.69976, 51.29581],
                    [35.69906, 51.31613],
                    [35.72064, 51.31736],
                  ],
                  "travelMode": "driving",
                  "traffic": 3.0,
                  "distance": {
                    "text": "۷ کیلومتر ۹۰۰ متر",
                    "value": 7900.0,
                  },
                  "duration": {
                    "text": "۱۵ دقیقه",
                    "value": 900.0,
                  },
                  "start": {
                    "latitude": 35.69824,
                    "longitude": 51.28747,
                  },
                  "destination": {
                    "latitude": 35.72064,
                    "longitude": 51.31736,
                  },
                },
              ],
              "distance": {
                "text": "۱۰ کیلومتر ۷۰۰ متر",
                "value": 10700.0,
              },
              "duration": {
                "text": "۲۲ دقیقه",
                "value": 1320.0,
              },
              "start": {
                "latitude": 35.688129,
                "longitude": 51.309386,
              },
              "destination": {
                "latitude": 35.720644,
                "longitude": 51.317357,
              },
            },
          ],
          "distance": {
            "text": "۱۰ کیلومتر ۷۰۰ متر",
            "value": 10700.0,
          },
          "duration": {
            "text": "۲۲ دقیقه",
            "value": 1320.0,
          },
          "start": {
            "latitude": 35.688129,
            "longitude": 51.309386,
          },
          "destination": {
            "latitude": 35.720644,
            "longitude": 51.317357,
          },
        },
      ],
    };

    routeData = RouteDataModel.fromJson(json);

  }


  AssignAndCancelEmdadgarCubit(this._getEmdadgarListUseCase,
      this._serviceAssignUseCase,
      this._getCheckDepotUseCase,
      this._fetchSelectedRequestItemUseCase,
      this._getReliefRequestByIdUseCase,
      this._getHomeServiceRequestByIdUseCase,
      this._getRouteUseCase,
      this._getAreaBaseInfoUseCase,
      this._getCancelReasonRequestUseCase,
      this._getNonCooperationListUseCase,)
      : super(AssignAndCancelEmdadgarState.idle());

  final GetEmdadgarListUseCase _getEmdadgarListUseCase;
  final ServiceAssignUseCase  _serviceAssignUseCase;
  final GetCheckDepotUseCase _getCheckDepotUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetRouteUseCase _getRouteUseCase;
  final GetAreaBaseInfoUseCase _getAreaBaseInfoUseCase;
  final GetCancelReasonRequestUseCase _getCancelReasonRequestUseCase;
  final GetNonCooperationListUseCase _getNonCooperationListUseCase;


  String? _errorMessage;
  BaseRequestEntity? selectedRequest;
  EmdadgarEntity? selectedEmdadgar;
  final List<EmdadgarEntity> emdadgarList = [];
  RouteDataEntity? routeData;
  final List<AreaBaseEntity> _areaBaseEntity = [];
  CheckDepotEntity? checkDepotEntity;

  final emdadgarNameController = TextEditingController();
  final aidPerCodeController = TextEditingController();
  final aidDistanceKmController = TextEditingController();
  final descriptionController = TextEditingController();
  final agencyNameController = TextEditingController();
  final agencyCodeController = TextEditingController();

  final ValueNotifier<bool> onlyReadyEmdadgar = ValueNotifier<bool>(false);
  final ValueNotifier<bool> requestCityEmdadgar = ValueNotifier<bool>(false);
  final ValueNotifier<bool> requestProvinceEmdadgar = ValueNotifier<bool>(
      false);
  final ValueNotifier<bool> limitedEmdadgar = ValueNotifier<bool>(false);

  final reasonListNotifier =
  ValueNotifier<List<CancelRequestReasonEntity>>([]);

  final selectedCancelReason = ValueNotifier<CancelRequestReasonEntity?>(null);

  VoidCallback? _retryAction;

  bool isBottomSheetOpen = false;

  void markBottomSheetOpen() {
    isBottomSheetOpen = true;
  }

  void markBottomSheetClosed() {
    isBottomSheetOpen = false;
  }

  Future<void> init() async {
    _retryAction = init;
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const AssignAndCancelEmdadgarState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const AssignAndCancelEmdadgarState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<void> getCancelReasons({
    required ServiceAssignAction action
  }) async {
    _retryAction = () => getCancelReasons(action: action);

    final param = CancelReasonParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      reasonType: action == ServiceAssignAction.cancelMission
          ? ReasonType.cancelEmdadgar
          : ReasonType.nonCooperation,);

    _safeEmit(
        AssignAndCancelEmdadgarState.getReasonListLoading(action: action));
    final result = await _getCancelReasonRequestUseCase(param);

    result.whenOrNull(
      success: (data, _, _) {
        reasonListNotifier.value = List<CancelRequestReasonEntity>.from(data);

        if (action == ServiceAssignAction.nonCooperation) {
          _safeEmit(
              AssignAndCancelEmdadgarState.showNonCooperationBottomSheet());
        } else if (action == ServiceAssignAction.cancelMission) {
          _safeEmit(
              AssignAndCancelEmdadgarState.showCancelMissionBottomSheet());
        }

      },
      failure: (error, failures) => _emitError(failures ?? error.toString()),
      connectionError: () =>
          _safeEmit(const AssignAndCancelEmdadgarState.connectionError()),

    );
  }

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedRequest();
    if (selectedResult != FetchResultType.success) return selectedResult;

    _safeEmit(const AssignAndCancelEmdadgarState.loading());

    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    final emdadgarListResult = await getEmdadgarList();
    if (emdadgarListResult != FetchResultType.success) {
      return emdadgarListResult;
    }

    if (selectedRequest?.hasEmdadGar ?? false) {
      selectedEmdadgar =  emdadgarList.first;
      final start = LocationParamEntity(
          latitude: emdadgarList.first.lastLocationLatitude ?? 0,
          longitude: emdadgarList.first.lastLocationLongitude ?? 0);

      final destination = LocationParamEntity(
          latitude: selectedRequest?.latitude ?? 0,
          longitude: selectedRequest?.longitude ?? 0);

      final routeResult = await _getRoutes(
          start: start, destination: destination);
      if (routeResult != FetchResultType.success) {
        return routeResult;
      }
    }

    final areaBaseInfoResult = await _getAreaBaseInfo();
    if (areaBaseInfoResult != FetchResultType.success) {
      return areaBaseInfoResult;
    }

    return FetchResultType.success;
  }

  Future<FetchResultType> _fetchSelectedRequest() async {
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

    result.whenOrNull(
      success: (data, _, _) {
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
    );
    return fetchResult;
  }

  Future<FetchResultType> _getAreaBaseInfo() async {
    final param = AreaBaseInfoParamEntity(
        latitude: selectedRequest?.latitude,
        longitude: selectedRequest?.longitude,
        areaBusinessUsageTypes: [
          selectedRequest?.serviceType?.value ??
              ServiceType.reliefService.value,
          AreaBusinessUsageType.spatialPlan.value,
          AreaBusinessUsageType.discount.value,
        ]
    );

    final result = await _getAreaBaseInfoUseCase(param);

    late FetchResultType fetchResult;

    result.whenOrNull(
      success: (data, _, _) {
        _areaBaseEntity.clear();
        _areaBaseEntity.addAll(data);
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );
    return fetchResult;
  }

  Future<FetchResultType> getEmdadgarList() async {
    final emdadServiceId = (selectedRequest is ReliefRequestEntity) ? (
        selectedRequest as ReliefRequestEntity
    ).emdadServiceId : null;
    final param = EmdadgarListParamEntity(
      serviceRequestId: selectedRequest?.id ?? 0,
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      serviceId: emdadServiceId,
      isActive: true,
      aidPerName: emdadgarNameController.text,
      aidPerCode: aidPerCodeController.text,
      aidDistanceKm: int.tryParse(aidDistanceKmController.text),
      onlyReadyEmdadgar: onlyReadyEmdadgar.value,
      requestCityEmdadgar: requestCityEmdadgar.value,
      requestProvinceEmdadgar: requestProvinceEmdadgar.value,
    );

    final result = await _getEmdadgarListUseCase(param);

    late FetchResultType fetchResult;

    result.whenOrNull(
      success: (data, _, _) {
        emdadgarList.clear();
        emdadgarList.addAll(data);
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );
    return fetchResult;
  }

  Future<void> applyFilterOnEmdadgarList() async {
    _retryAction = applyFilterOnEmdadgarList;
    _safeEmit(AssignAndCancelEmdadgarState.loading());
    final emdadgarListResult = await getEmdadgarList();
    _emitFetchResultState(emdadgarListResult,
      successState: AssignAndCancelEmdadgarState.loaded(),
    );
  }

  Future<void> setSelectedCancelReason(CancelRequestReasonEntity? value) async {
    selectedCancelReason.value = value;
  }

  Future<void> setSelectedEmdadgar(EmdadgarEntity value) async {
    selectedEmdadgar = value;
  }


  Future<void> executeServiceAssign(ServiceAssignAction action) async {
    _retryAction = () => executeServiceAssign(action);
    emit(const AssignAndCancelEmdadgarState.submitLoading());

    final param = ServiceAssignParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      rejectReason: (action == ServiceAssignAction.nonCooperation)
          ? selectedCancelReason.value?.id
          : null,
      cancelReason: (action == ServiceAssignAction.cancelMission)
          ? selectedCancelReason.value?.id
          : null,

      description: descriptionController.text,
      isActive: selectedEmdadgar?.isActive,
      planningId: selectedEmdadgar?.planningId,
      serviceRequestId: selectedRequest?.id,
      emdadgarID: selectedEmdadgar?.emdadgars?.first.aidPerCode,
      distance: int.tryParse(
          selectedEmdadgar?.distanceKmToOrigin.toString() ?? '0'),
      emdadgarPriority: selectedEmdadgar?.priority,
        duration: routeData?.routes.first.duration.value.toInt() ?? 0,
        durationTitle: routeData?.routes.first.duration.text ?? '',
        distanceTitle: routeData?.routes.first.distance.text ?? '',
        type: action.value

    );
    final result = await _serviceAssignUseCase.call(param);
    result.whenOrNull(
      success: (data, _, _) {
        _safeEmit(AssignAndCancelEmdadgarState.closeBottomSheetAndRefresh(
            operationAction: action, response: data));
      },
      failure: (error, failures) => _emitError(failures ?? error.toString()),
      connectionError: () =>
          _safeEmit(const AssignAndCancelEmdadgarState.connectionError()),
    );
  }

  Future<void> refreshAfterOperationSuccess(
      ServiceAssignResponseEntity response, ServiceAssignAction action) async {
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const AssignAndCancelEmdadgarState.loaded());
        _safeEmit(
          AssignAndCancelEmdadgarState.showOperationSuccessMessage(
              response: response, operationAction: action),
        );
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const AssignAndCancelEmdadgarState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<void> getCheckDepotAndRoute() async {
    _safeEmit(AssignAndCancelEmdadgarState.checkDepotLoading(
        emdadgarId: selectedEmdadgar?.id ?? 0));

    final start = LocationParamEntity(
        latitude: selectedEmdadgar?.lastLocationLatitude ?? 0,
        longitude: selectedEmdadgar?.lastLocationLongitude ?? 0);

    final routeResult = await _getRoutes(start: start);
    if (routeResult != FetchResultType.success) {
      _emitFetchResultState(routeResult);
      return;
    }

    final checkDepotResult = await _getCheckDepot();
    if (checkDepotResult != FetchResultType.success) {
      _emitFetchResultState(checkDepotResult);
      return;
    }

    _safeEmit(
      const AssignAndCancelEmdadgarState.showEmdadgarInfoBottomSheet(),
    );
  }

  void _emitFetchResultState(FetchResultType result,
      {AssignAndCancelEmdadgarState? successState}) {
    switch (result) {
      case FetchResultType.success:
        if (successState != null) {
          _safeEmit(successState);
        }
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const AssignAndCancelEmdadgarState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<FetchResultType> _getCheckDepot() async {
    final param = CheckDepotParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      serviceRequestId: selectedRequest?.id,
      planningId: selectedEmdadgar?.planningId,
    );

    final result = await _getCheckDepotUseCase.call(param);

    late FetchResultType fetchResult;

    result.whenOrNull(
      success: (data, _, _) {
        checkDepotEntity = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );

    return fetchResult;
  }

  Future<FetchResultType> _getRoutes({
    required LocationParamEntity start,
    LocationParamEntity? destination,
  }) async {
    final param = RouteParamEntity(
      includeLegs: true,
      includeStepsPoints: true,
      start: start,
      destination: destination,
    );

    final result = await _getRouteUseCase(param);

    late FetchResultType fetchResult;

    result.whenOrNull(
      success: (data, _, _) {
        routeData = data;
        fetchResult = FetchResultType.success;
      },
      failure: (_, msg) {
        _errorMessage = _fallbackError(msg);
        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );

    return fetchResult;

  }

  void _safeEmit(AssignAndCancelEmdadgarState state) {
    if (!isClosed) emit(state);
  }

  void _emitError([String? message]) {
    _safeEmit(
      AssignAndCancelEmdadgarState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  String _fallbackError([String? msg]) {
    if (msg
        ?.trim()
        .isNotEmpty == true) {
      return msg!;
    }
    return 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
  }

  void retryLastAction() => _retryAction?.call();

  Future<void> showAssignConfirmBottomSheet() async {
    clearDescriptionController();
    _safeEmit(
        const AssignAndCancelEmdadgarState.showAssignConfirmBottomSheet());
  }

  void clearDescriptionController() {
    descriptionController.clear();
  }

  void clearFilterFields() {
    emdadgarNameController.clear();
    aidPerCodeController.clear();
    aidDistanceKmController.clear();

    agencyNameController.clear();
    agencyCodeController.clear();

    onlyReadyEmdadgar.value = false;
    requestCityEmdadgar.value = false;
    requestProvinceEmdadgar.value = false;
    limitedEmdadgar.value = false;
  }


  @override
  Future<void> close() {
    onlyReadyEmdadgar.dispose();
    requestCityEmdadgar.dispose();
    requestProvinceEmdadgar.dispose();
    limitedEmdadgar.dispose();

    emdadgarNameController.dispose();
    aidPerCodeController.dispose();
    aidDistanceKmController.dispose();
    agencyNameController.dispose();
    agencyCodeController.dispose();
    descriptionController.dispose();
    reasonListNotifier.dispose();
    selectedCancelReason.dispose();
    return super.close();
  }
}
