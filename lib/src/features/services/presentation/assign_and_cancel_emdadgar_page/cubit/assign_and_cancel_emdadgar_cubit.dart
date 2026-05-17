import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/reason_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/data/models/emdadgar/emdadgar_model.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/check_depot_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/service_assign_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/check_depot_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_assign_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_cancel_reason_request_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_check_depot_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_non_cooperation_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/service_assign_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
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

enum ServiceAssignAction {
  assignEmdadgar,
  cancelMission,
  nonCooperation,
}


@injectable
class AssignAndCancelEmdadgarCubit extends Cubit<AssignAndCancelEmdadgarState> {
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
  AreaBaseEntity? _areaBaseEntity;
  CheckDepotEntity? checkDepotEntity;

  final emdadgarNameController = TextEditingController();
  final aidPerCodeController = TextEditingController();
  final aidDistanceKmController = TextEditingController();
  final descriptionController = TextEditingController();

  final ValueNotifier<bool> onlyReadyEmdadgar = ValueNotifier<bool>(false);
  final ValueNotifier<bool> requestCityEmdadgar = ValueNotifier<bool>(false);
  final ValueNotifier<bool> requestProvinceEmdadgar = ValueNotifier<bool>(
      false);
  final ReasonListNotifier =
  ValueNotifier<List<CancelRequestReasonEntity>>([]);

  final selectedCancelReason = ValueNotifier<CancelRequestReasonEntity?>(null);

  VoidCallback? _retryAction;

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

  Future<void> initNonCooperation() async {
    _retryAction = initNonCooperation;
    final requestStatus = RequestStatus.fromValue(
        selectedRequest?.requestStatus);
    final param = CancelReasonParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      reasonType: requestStatus.isBeforeDispatch
          ? ReasonType.beforeDispatch
          : ReasonType.afterDispatch,);


    final result = await _getCancelReasonRequestUseCase(param);

    result.whenOrNull(
      success: (data, _, _) {
        ReasonListNotifier.value.clear();
        ReasonListNotifier.value.addAll(data);
        _safeEmit(AssignAndCancelEmdadgarState.loaded());
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

  /*  final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }


    final routesResult = await _getRoutes();
    if (routesResult != FetchResultType.success) {
      return routesResult;
    }
    */

    final emdadgarListResult = await _getEmdadgarList();
    if (emdadgarListResult != FetchResultType.success) {
      return emdadgarListResult;
    }

  /*  final areaBaseInfoResult = await _getAreaBaseInfo();
    if (areaBaseInfoResult != FetchResultType.success) {
      return areaBaseInfoResult;
    }*/

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


  Future<FetchResultType> _getRoutes() async {
    final param = RouteParamEntity(includeLegs: true, includeStepsPoints: true,
        start: LocationParamEntity(
          latitude: selectedEmdadgar?.lastLocationLatitude ?? 0,
          longitude: selectedEmdadgar?.lastLocationLongitude ?? 0,));

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

  Future<FetchResultType> _getAreaBaseInfo() async {
    final param = AreaBaseInfoParamEntity(
        latitude: selectedRequest?.latitude,
        longitude: selectedRequest?.longitude
    );

    final result = await _getAreaBaseInfoUseCase(param);

    late FetchResultType fetchResult;

    result.whenOrNull(
      success: (data, _, _) {
        _areaBaseEntity = data;
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
///faker method
  Future<FetchResultType> _getEmdadgarList() async {
    // شبیه‌سازی تاخیر شبکه
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> fakeJsonList = [
      {
        "id": 13395,
        "agencyName": "ابراهيم فرجي",
        "plakText": "63 ط 699 44",
        "khodroTypeText": "زامیاد",
        "distanceKmToOrigin": 4.82,
        'statusTitle': 'در حال ماموریت',
        "priority": 1,
        "isActive": true,
        "emdadgars": [
          {
            "aidPerName": "محمد زمانی",
            "report": {
              "daily": {"successCount": 5, "cancelCount": 1},
              "weekly": {"successCount": 20, "cancelCount": 3}
            }
          }
        ]
      },
      {
        "id": 13639,
        "agencyName": "خسرو محمدي نژاد روشنده",
        "plakText": "45 ط 757 38",
        "khodroTypeText": "سایپا 151",
        "distanceKmToOrigin": 4.98,
        'statusTitle': 'آماده خدمت',
        "priority": 2,
        "isActive": true,
        "emdadgars": [
          {
            "aidPerName": "خسرو محمدی نژاد",
            "report": {
              "daily": {"successCount": 2, "cancelCount": 0},
              "weekly": {"successCount": 12, "cancelCount": 1}
            }
          }
        ]
      },
      {
        "id": 14000,
        "agencyName": "نمایندگی مرکزی میلاد",
        "plakText": "22 ج 114 10",
        "khodroTypeText": "نیسان یدک‌کش",
        "distanceKmToOrigin": 2.5,
        "priority": 3,
        'statusTitle': 'در حال ماموریت',
        "isActive": true,
        "emdadgars": [
          {
            "aidPerName": "میلاد برنامه‌نویس",
            "report": {
              "daily": {"successCount": 10, "cancelCount": 0},
              "weekly": {"successCount": 45, "cancelCount": 2}
            }
          }
        ]
      }
    ];

    final items = fakeJsonList.map((json) => EmdadgarModel.fromJson(json)).toList();

    emdadgarList.clear();
    emdadgarList.addAll(items);

    return FetchResultType.success;
  }

/*
  Future<FetchResultType> _getEmdadgarList() async {
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
  }*/
  Future<void> setSelectedCancelReason(CancelRequestReasonEntity? value) async {
    selectedCancelReason.value = value;
  }

  Future<void> setSelectedEmdadgar(EmdadgarEntity value) async {
    selectedEmdadgar = value;
  }


  Future<void> executeServiceAssign(ServiceAssignAction action) async {
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
      emdadgarID: selectedEmdadgar?.id,
      distance: int.tryParse(
          selectedEmdadgar?.distanceKmToOrigin.toString() ?? '0'),
      emdadgarPriority: selectedEmdadgar?.priority,
      /* distanceTitle:,
      duration: ,
      durationTitle: ,
      type:*/

    );
    final result = await _serviceAssignUseCase.call(param);
    result.whenOrNull(
      success: (data, _, _) {
        _safeEmit(
          AssignAndCancelEmdadgarState.assignSuccess(response: data),
        );
      },
      failure: (error, failures) => _emitError(failures ?? error.toString()),
      connectionError: () =>
          _safeEmit(const AssignAndCancelEmdadgarState.connectionError()),
    );
  }

  ///fakeer method
  Future<void> checkDepotAndOpen(EmdadgarEntity entity) async {
    emit(AssignAndCancelEmdadgarState.checkDepotLoading(
      emdadgarId: entity.id!,
    ));
    await Future.delayed(Duration(seconds: 2));

    checkDepotEntity = CheckDepotEntity(allowMark500: true,launchDepotIsEnable: true);
    _safeEmit(const AssignAndCancelEmdadgarState.checkDepotSuccess());
  }

 /* Future<void> checkDepotAndOpen(EmdadgarEntity entity) async {
    emit(AssignAndCancelEmdadgarState.checkDepotLoading(
      emdadgarId: entity.id!,
    ));

    final param = CheckDepotParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      serviceRequestId: selectedRequest?.id,
      planningId: selectedEmdadgar?.planningId,
    );


    final result = await _getCheckDepotUseCase.call(param);

    result.whenOrNull(
      success: (data, _, _) {
        checkDepotEntity = data;
        _safeEmit(const AssignAndCancelEmdadgarState.checkDepotSuccess());
      },
      failure: (error, failures) => _emitError(failures ?? error.toString()),
      connectionError: () =>
          _safeEmit(const AssignAndCancelEmdadgarState.connectionError()),
    );
  }*/




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
}
