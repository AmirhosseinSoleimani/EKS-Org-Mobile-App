import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/reason_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/services_and_labors_and_parts_evaluation_payload_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/accept_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_service_detail_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/post_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/cancel_request_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_reason_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/cancel_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/distance_kilometer_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/get_emdadgar_followups_data_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/cancel_service_request_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_cancel_reason_request_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_distance_kilometer_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_followups_data_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/use_case/customer_pre_invoice_on_the_fly_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
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
      this._getServiceDetailEvaluationUseCase,
      this._postEvaluationUseCase,
      this._cancelServiceRequestUseCase,
      this._customerPreInvoiceOnTheFlyUseCase,
      this._acceptEvaluationUseCase,
      this._getEmdadgarFollowupsDataUseCase,

      ) : super(const CancelRequestState.idle());

  final formKey = GlobalKey<FormState>();
  final validationNotifier = ValueNotifier<bool>(false);

  final GetCancelReasonRequestUseCase _getCancelReasonRequestUseCase;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetHomeServiceRequestByIdUseCase _getHomeServiceRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetDistanceKilometerUseCase _getDistanceKilometerUseCase;
  final GetServiceDetailEvaluationUseCase _getServiceDetailEvaluationUseCase;
  final PostEvaluationUseCase _postEvaluationUseCase;
  final CancelServiceRequestUseCase _cancelServiceRequestUseCase;
  final CustomerPreInvoiceOnTheFlyUseCase _customerPreInvoiceOnTheFlyUseCase;

  final AcceptEvaluationUseCase _acceptEvaluationUseCase;
  final GetEmdadgarFollowupsDataUseCase _getEmdadgarFollowupsDataUseCase;



  BaseRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  List<CancelRequestReasonEntity> cancelRequestType =
  <CancelRequestReasonEntity>[];


  EmdadgarServiceDetailEntity? emdadgarServiceDetailEntity;
  String? emdadgarEvaluationId;
  final cancelRequestReasonNotifier =
  ValueNotifier<List<CancelRequestReasonEntity>>([]);

  final kilometerReadOnlyListenable = ValueNotifier<bool>(true);
  final selectedCancelType = ValueNotifier<CancelRequestReasonEntity?>(null);
  final selectedCancelReason = ValueNotifier<CancelRequestReasonEntity?>(null);

  final showAllServices = ValueNotifier<bool>(false);

  DateTime? dispatchDateTime;
  final  dispatchDateController = TextEditingController();
  final  dispatchTimeController = TextEditingController();


  final  cancelDateController = TextEditingController();
  final  cancelTimeController = TextEditingController();

  DateTime?  cancelDateTime;

  final ValueNotifier<bool> isGettingDistanceKilometer = ValueNotifier(false);
  final ValueNotifier<bool> showDateTimeSection = ValueNotifier(false);
  final ValueNotifier<bool> showSecondDropDown = ValueNotifier(false);

  final TextEditingController kilometerController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? _errorMessage;

  VoidCallback? _retryAction;

  String _fallbackError([String? msg]) => msg?.trim().isNotEmpty == true
      ? msg!
      : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';

  Future<void> init() async {
    _retryAction = init;
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
  }

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

  Future<FetchResultType> _loadCancelReasonList({
    int? reasonId,
    required List<CancelRequestReasonEntity> list,
  }) async {
    CancelReasonParamEntity param = getReasonParam(reasonId);
    final result = await _getCancelReasonRequestUseCase(param);

    FetchResultType fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, _) {
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

  CancelReasonParamEntity getReasonParam(int? reasonId) {

    final requestStatus = RequestStatus.fromValue(selectedRequest?.requestStatus);
    final param = CancelReasonParamEntity(reasonId: reasonId,
    serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
    reasonType: requestStatus.isBeforeDispatch ? ReasonType.beforeDispatch: ReasonType.afterDispatch);
    return param;
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
    showSecondDropDown.value = (selectedCancelType.value?.detailType != null);

    if (showSecondDropDown.value) {
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

    showDateTimeSection.value =
    (selectedCancelType.value?.canCreateInvoice == true);

    if (showDateTimeSection.value) {
      await getEmdadgarFollowupsData();
      await getEmdadgarServiceDetail();
    }

    _safeEmit(CancelRequestState.loaded(
      showSecondDropDown: isSecondDropDownVisible,
      showDateTimeSection: isDateTimeSectionVisible,
    ));
  }

  Future<void> getEmdadgarFollowupsData() async {

    final param = GetEmdadgarFollowupsDataParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      serviceRequestId: selectedRequest?.id,
      needHaml: false,
    );

    final result = await _getEmdadgarFollowupsDataUseCase(param);

    result.whenOrNull(
      success: (data, _, _) {
        dispatchDateTime = data.startTimeDate;
        cancelDateTime = data.arrivedTimeDate ?? DateTime.now();
        kilometerReadOnlyListenable.value =
            data.isKilometerEditable == false;
      },
      connectionError: () => emit(const CancelRequestState.connectionError()),
      failure: (error, failures) => _emitError(failures ?? error.toString()),
    );
  }

  Future<void> getEmdadgarServiceDetail() async {
    int? defectId;
    if (selectedRequest is ReliefRequestEntity) {
      defectId = (selectedRequest as ReliefRequestEntity).defectId;
    }
    final param = ServiceDetailForEvaluationParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      serviceRequestId: selectedRequest?.id,
      aidServiceRequestId: selectedRequest?.id,
      emdadgarServiceCategoryId: 41,
      emdadgarDefectInfoId: defectId,
      evaluationCustomerKilometer: selectedRequest?.kilometer,
    );

    final result = await _getServiceDetailEvaluationUseCase(param);

    result.whenOrNull(
      success: (data, _, _) {
        emdadgarServiceDetailEntity = data;
      },
      connectionError: () => emit(const CancelRequestState.connectionError()),
      failure: (error, failures) => _emitError(failures ?? error.toString()),
    );
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
        success: (data, _, _) {
          if (data.distanceKilometer == null) return;
          kilometerController.text = data.distanceKilometer.toString();
          kilometerReadOnlyListenable.value =
              data.isDistanceKilometerEditable == false;
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
    dispatchDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setDispatchTime(DateTime time) {
    final current = dispatchDateTime ?? DateTime.now();
    dispatchDateTime = DateTime(
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
    cancelDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      current.hour,
      current.minute,
    );
  }

  void setCancelTime(DateTime time) {
    final current = cancelDateTime ?? DateTime.now();
    cancelDateTime = DateTime(
      current.year,
      current.month,
      current.day,
      time.hour,
      time.minute,
    );
  }

  bool get isSecondDropDownVisible =>
      showSecondDropDown.value;

  bool get isDateTimeSectionVisible =>
      showDateTimeSection.value;

  Future<void> submit() async {
    _retryAction = submit;
    _safeEmit(const CancelRequestState.submitLoading());

    if (selectedCancelType.value?.canCreateInvoice == false) {
      await submitCancelRequest();
    } else {
      final param = ServiceEvaluationParamEntity(
          serviceType: selectedRequest?.serviceType,
          serviceRequestId: selectedRequest?.id,
          cancelReasonId: selectedCancelType.value?.id,
          cancelReasonDetailId: selectedCancelReason.value?.id,
          assignDate: dispatchDateTime,
          endWorkDate: cancelDateTime,
          distanceToCustomer: double.tryParse(kilometerController.text),
          customerKilometer: selectedRequest?.kilometer,

          description: descriptionController.text,
          servicesAndLaborsAndPartsEvaluationPayload: ServicesAndLaborsAndPartsEvaluationPayloadEntity(
            evaluationServices: [
              EvaluationServiceEntity(
                serviceType: emdadgarServiceDetailEntity?.serviceType,
                serviceId: emdadgarServiceDetailEntity?.serviceId,
                serviceTypeTitle: emdadgarServiceDetailEntity?.serviceTypeTitle,
                defectInfoId: emdadgarServiceDetailEntity?.defectInfoId,
                hasGaranty: emdadgarServiceDetailEntity?.hasGaranty ?? false,
                hasSubscription: emdadgarServiceDetailEntity?.hasSubscription ??
                    false,
                isSubscribedByNationalCode: emdadgarServiceDetailEntity
                    ?.isSubscribedByNationalCode,
                serviceCategoryCode: emdadgarServiceDetailEntity
                    ?.serviceCategoryCode,
                serviceCategoryId: emdadgarServiceDetailEntity
                    ?.serviceCategoryId,
                serviceCategoryTitle: emdadgarServiceDetailEntity
                    ?.serviceCategoryTitle,
                serviceCode: emdadgarServiceDetailEntity?.serviceCode,
                serviceTitle: emdadgarServiceDetailEntity?.serviceTitle,
                serviceTypeId: emdadgarServiceDetailEntity?.serviceTypeId,
              ),
            ],
          )

      );
      final result = await _postEvaluationUseCase(param);
      result.whenOrNull(
        success: (data, failures, resultCode) async {
          if (data.id != null) {
            emdadgarEvaluationId = data.id;
            final param = AcceptEvaluationParamEntity(
              serviceType: selectedRequest?.serviceType ??
                  ServiceType.reliefService,
              emdadgarEvaluationId: data.id.toString(),
            );
            final customerPreInvoiceResult = await _customerPreInvoiceOnTheFlyUseCase(
                param);
            customerPreInvoiceResult.whenOrNull(
              success: (data, failures, resultCode) {
                if (data != null) {
                  _safeEmit(CancelRequestState.showPreInvoice(invoice: data));
                }
              },
              failure: (error, failures) =>
                  _emitError(failures ?? error.toString()),
              connectionError: () =>
                  emit(const CancelRequestState.connectionError()),
            );
          }
        },
        failure: (error, failures) => _emitError(failures ?? error.toString()),
        connectionError: () => emit(const CancelRequestState.connectionError()),
      );
    }
  }

  Future<void> submitCancelRequest() async {
    final param = CancelRequestParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      serviceRequestId: selectedRequest?.id,
      cancelReason: selectedCancelType.value?.id,
      cancelReasonDetailId: selectedCancelReason.value?.id,
      cancelDesc: descriptionController.text,
      needCopy: false,
    );
    final result = await _cancelServiceRequestUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        _safeEmit(CancelRequestState.submitSuccess());
      },
      failure: (error, failures) => _emitError(failures ?? error.toString()),
      connectionError: () => emit(const CancelRequestState.connectionError()),
    );
  }

  Future<void> acceptEvaluation () async {
    _safeEmit(CancelRequestState.submitLoading());
    final param = AcceptEvaluationParamEntity(serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
        emdadgarEvaluationId: emdadgarEvaluationId.toString());

    final result = await _acceptEvaluationUseCase(param);
    result.whenOrNull(
      success: (data, failures, resultCode) {
        _safeEmit(CancelRequestState.submitSuccess());
      },
      failure: (error, failures) => _emitError(failures ?? error.toString()),
      connectionError: () => emit(const CancelRequestState.connectionError()),
    );
  }

  void _safeEmit(CancelRequestState state) {
    if (!isClosed) emit(state);
  }


  void retryLastAction() => _retryAction?.call();

  @override
  Future<void> close() {
    validationNotifier.dispose();

    cancelRequestReasonNotifier.dispose();
    kilometerReadOnlyListenable.dispose();
    selectedCancelType.dispose();
    selectedCancelReason.dispose();
    showAllServices.dispose();

    dispatchDateController.dispose();
    dispatchTimeController.dispose();
    cancelDateController.dispose();
    cancelTimeController.dispose();

    isGettingDistanceKilometer.dispose();
    showDateTimeSection.dispose();
    showSecondDropDown.dispose();

    kilometerController.dispose();
    descriptionController.dispose();

    return super.close();
  }

}
