import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/distance_kilometer_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_cancel_reason_request_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_distance_kilometer_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cancel_request_cubit.freezed.dart';
part 'cancel_request_state.dart';

@injectable
class CancelRequestCubit extends Cubit<CancelRequestState> {
  CancelRequestCubit(
    this._getCancelReasonRequestUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getHomeServiceRequestByIdUseCase,
    this._getDistanceKilometerUseCase,
    this._getEmdadgarInfoUseCase,
  ) : super(const CancelRequestState.idle());

  final formKey = GlobalKey<FormState>();
  final validationNotifier = ValueNotifier<bool>(false);

  final GetCancelReasonRequestUseCase _getCancelReasonRequestUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetDistanceKilometerUseCase _getDistanceKilometerUseCase;

  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  List<CancelRequestReasonEntity> cancelRequestType =
      <CancelRequestReasonEntity>[];

  final cancelRequestReasonNotifier =
  ValueNotifier<List<CancelRequestReasonEntity>>([]);

  final isDistanceKilometerEditable = ValueNotifier<bool>(true);
  final selectedCancelType = ValueNotifier<CancelRequestReasonEntity?>(null);
  final selectedCancelReason = ValueNotifier<CancelRequestReasonEntity?>(null);

  final showAllServices = ValueNotifier<bool>(false);

  final dispatchDateTimeNotifier = ValueNotifier<DateTime?>(null);

  DateTime? get dispatchDateTime => dispatchDateTimeNotifier.value;

  final cancelDateTimeNotifier = ValueNotifier<DateTime?>(null);
  DateTime? get cancelDateTime => cancelDateTimeNotifier.value;

  final ValueNotifier<bool> isGettingDistanceKilometer = ValueNotifier(false);

  final TextEditingController kilometerController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? _errorMessage;

  String _fallbackError([String? msg]) => msg?.trim().isNotEmpty == true
      ? msg!
      : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';


  ///fake init
  Future<void> init() async {
    // -----------------------------
    // 1) Selected Request (فیک)
    // -----------------------------
    selectedRequest = ReliefRequestEntity(
      id: 1234567,
      requestStatus: RequestStatus.inProgress.value,
      carName: "تیبا",
      licensePlate: "21 الف 123",
      provinceName: "تهران",
      aidAddress: "خیابان آزادی، نبش بهبودی",
      latitude: 35.7321,
      longitude: 51.4129,
    );

    // -----------------------------
    // 2) Emdadgar Info (فیک)
    // -----------------------------
    emdadgarInfo = EmdadgarInfoEntity(
      id: 9988,
      agencyName: "میلاد توسعه‌چی",
      mobile: "09120000000",
      nationalCode: "1234567890",
    );

    // -----------------------------
    // 3) Cancel Reason List (فیک)
    // -----------------------------
    cancelRequestType = [
      CancelRequestReasonEntity(id: 1, title: "عدم رضایت مشتری"),
      CancelRequestReasonEntity(id: 2, title: "عدم نیاز به سرویس"),
      CancelRequestReasonEntity(id: 3, title: "اشتباه در ثبت درخواست"),
    ];

    cancelRequestReasonNotifier.value = cancelRequestType;

    // -----------------------------
    // 4) انتخاب Reason و Type
    // -----------------------------
    selectedCancelType.value = cancelRequestType.first;
    selectedCancelReason.value = cancelRequestType[1];

    // -----------------------------
    // 5) تاریخ‌های فیک
    // -----------------------------
    dispatchDateTimeNotifier.value =
        DateTime.now().subtract(const Duration(hours: 2));

    cancelDateTimeNotifier.value = DateTime.now();

    // -----------------------------
    // 6) TextFields مقدار دهی
    // -----------------------------
    kilometerController.text = "12";
    descriptionController.text = "تست توضیحات لغو درخواست";

    // -----------------------------
    // 7) وضعیت تنظیمات دیگر
    // -----------------------------
    isDistanceKilometerEditable.value = true;

    showAllServices.value = true;

    // -----------------------------
    // 8) در نهایت emit
    // -----------------------------
    _safeEmit(const CancelRequestState.loaded());
  }

  /*Future<void> init() async {
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const CancelRequestState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const CancelRequestState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }*/

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedServiceRequest();
    if (selectedResult != FetchResultType.success) {
      return selectedResult;
    }

    _safeEmit(const CancelRequestState.loading());

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

    final listResult = await _loadCancelReasonList(list: cancelRequestType);
    if (listResult != FetchResultType.success) {
      return listResult;
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

  Future<FetchResultType> _loadCancelReasonList({
    int? reasonId,
    required List<CancelRequestReasonEntity> list,
  }) async {
    final param = CancelReasonParamEntity(reasonId: reasonId);
    final result = await _getCancelReasonRequestUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, __) {
        list.clear();
        list.addAll(data);
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

  void _emitError([String? message]) {
    _safeEmit(
      CancelRequestState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: message ?? _errorMessage ?? _fallbackError(),
        ),
      ),
    );
  }

  Future<void> setSelectedCancelReason(CancelRequestReasonEntity? value) async {
    selectedCancelReason.value = value;
  }

  Future<void> setSelectedCancelType(CancelRequestReasonEntity? value) async {
    selectedCancelType.value = value;

    selectedCancelReason.value = null;

    final fetchResult = await _loadCancelReasonList(
      reasonId: value?.id,
      list: cancelRequestReasonNotifier.value,
    );

    switch (fetchResult) {
      case FetchResultType.success:
        break;
      case FetchResultType.failure:
        _emitError();
        break;
      case FetchResultType.connectionError:
        _safeEmit(const CancelRequestState.connectionError());
        break;
      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }


  Future<void> getDistanceKilometer() async {
    if (isGettingDistanceKilometer.value) return;

    isGettingDistanceKilometer.value = true;
    try {
      final param = DistanceKilometerParamEntity(
        serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
        startDate: dispatchDateTime,
        endDate: cancelDateTime,
        imei: emdadgarInfo?.nImei,
        needHaml: false,
      );

      final result = await _getDistanceKilometerUseCase(param);

      result.whenOrNull(
        success: (data, _, __) {
          if (data.distanceKilometer == null) return;
          kilometerController.text = data.distanceKilometer.toString();
          isDistanceKilometerEditable.value =
              data.isDistanceKilometerEditable ?? true;
        },
        connectionError: () => emit(const CancelRequestState.connectionError()),
        failure: (error, failures) => _emitError(failures ?? error.toString()),
      );
    } finally {
      isGettingDistanceKilometer.value = false;
    }
  }


  void setDispatchDate(DateTime? date) {
    if (date == null) return;
    final current = dispatchDateTime ?? DateTime.now();
    dispatchDateTimeNotifier.value = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setDispatchTime(DateTime time) {
    final current = dispatchDateTime ?? DateTime.now();
    dispatchDateTimeNotifier.value = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  void setCancelDate(DateTime? date) {
    if (date == null) return;
    final current = cancelDateTime ?? DateTime.now();
    cancelDateTimeNotifier.value = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setCancelTime(DateTime time) {
    final current = cancelDateTime ?? DateTime.now();
    cancelDateTimeNotifier.value = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  bool get hasAssignedEmdadgar {
    final request = selectedRequest;
    if (request == null) return false;

    return !notAssignedStatuses.contains(
        RequestStatus.fromValue(request.requestStatus));
  }

  Future<void> submit() async {
    _safeEmit(const CancelRequestState.submitLoading());

    await Future.delayed(const Duration(seconds: 2));

    _safeEmit(const CancelRequestState.submitSuccess());
  }

  void _safeEmit(CancelRequestState state) {
    if (!isClosed) emit(state);
  }

}
