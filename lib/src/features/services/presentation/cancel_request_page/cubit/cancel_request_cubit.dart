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
import 'package:shamsi_date/shamsi_date.dart';

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
  String? _limitationDescription;
  bool _successFromInvoiceFlow = false;

  bool get successFromInvoiceFlow => _successFromInvoiceFlow;

  VoidCallback? _retryAction;

  bool get hasRetryAction => _retryAction != null;

  String? takeLimitationDescription() {
    final message = _limitationDescription;
    _limitationDescription = null;
    return message;
  }

  String _fallbackError([String? msg]) => msg?.trim().isNotEmpty == true
      ? msg!
      : 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';

  Future<void> init() async {
    _retryAction = init;
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _retryAction = null;
        _safeEmit(const CancelRequestState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const CancelRequestState.connectionError());
        break;

      case FetchResultType.expireToken:
        // Token expiration is handled globally by ApiResultConverter/AppEventBus.
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

    final cancelTypesResult = await _fetchCancelReasonList(
      type: _primaryCancelReasonType,
    );
    if (cancelTypesResult.result != FetchResultType.success) {
      return cancelTypesResult.result;
    }
    cancelRequestType = List<CancelRequestReasonEntity>.unmodifiable(
      cancelTypesResult.items,
    );

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

  Future<({FetchResultType result, List<CancelRequestReasonEntity> items})>
      _fetchCancelReasonList({required int type}) async {
    final param = getReasonParam(type);
    final result = await _getCancelReasonRequestUseCase(param);

    var fetchResult = FetchResultType.failure;
    var items = <CancelRequestReasonEntity>[];

    result.when(
      success: (data, _, _) {
        items = List<CancelRequestReasonEntity>.unmodifiable(data);
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

    return (result: fetchResult, items: items);
  }

  int get _primaryCancelReasonType {
    final requestStatus = RequestStatus.fromValue(selectedRequest?.requestStatus);
    return requestStatus.isBeforeDispatch
        ? ReasonType.beforeDispatch.value
        : ReasonType.afterDispatch.value;
  }

  CancelReasonParamEntity getReasonParam(int type) {
    return CancelReasonParamEntity(
      type: type,
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
    );
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
    _retryAction = () => setSelectedCancelType(value);
    selectedCancelType.value = value;
    selectedCancelReason.value = null;
    _limitationDescription = null;

    showSecondDropDown.value = value?.detailType != null;
    showDateTimeSection.value = value?.canCreateInvoice == true;

    // Clear the previous detail reasons immediately. The second dropdown must
    // never keep the list that belonged to the previously selected cancel type.
    cancelRequestReasonNotifier.value = const <CancelRequestReasonEntity>[];

    if (showSecondDropDown.value) {
      final cancelReasonsResult = await _fetchCancelReasonList(
        type: value!.detailType!,
      );

      if (!_handleFetchFailure(cancelReasonsResult.result)) return;

      // Assign a new list instance so ValueNotifier listeners are notified and
      // the second dropdown receives exactly the detail reasons from this call.
      cancelRequestReasonNotifier.value = cancelReasonsResult.items;
    }

    if (showDateTimeSection.value) {
      if (!_validateCustomerKilometer()) {
        _retryAction = null;
        return;
      }

      final followupsResult = await getEmdadgarFollowupsData();
      if (!_handleFetchFailure(followupsResult)) return;

      final serviceDetailResult = await getEmdadgarServiceDetail();
      if (!_handleFetchFailure(serviceDetailResult)) return;
    }

    _retryAction = null;
    _safeEmit(CancelRequestState.loaded(
      showSecondDropDown: isSecondDropDownVisible,
      showDateTimeSection: isDateTimeSectionVisible,
    ));
  }

  bool _handleFetchFailure(FetchResultType result) {
    switch (result) {
      case FetchResultType.success:
        return true;
      case FetchResultType.failure:
        _emitError();
        return false;
      case FetchResultType.connectionError:
        _safeEmit(const CancelRequestState.connectionError());
        return false;
      case FetchResultType.expireToken:
        // Token expiration is handled globally.
        return false;
    }
  }

  bool _validateCustomerKilometer() {
    final customerKilometer = selectedRequest?.kilometer;
    if (customerKilometer == null) {
      _errorMessage = 'کیلومتر خودرو اجباری می باشد';
      _emitError(_errorMessage);
      return false;
    }
    if (customerKilometer <= 0) {
      _errorMessage = 'کیلومتر خودرو باید بزرگتر از 0 باشد';
      _emitError(_errorMessage);
      return false;
    }
    return true;
  }

  Future<FetchResultType> getEmdadgarFollowupsData() async {
    final param = GetEmdadgarFollowupsDataParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      serviceRequestId: selectedRequest?.id,
      needHaml: false,
    );

    final result = await _getEmdadgarFollowupsDataUseCase(param);
    var fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, _) {
        dispatchDateTime = data.startTimeDate;
        cancelDateTime = data.arrivedTimeDate ?? DateTime.now();
        kilometerReadOnlyListenable.value = data.isKilometerEditable == false;
        _fillDateTimeControllers();
        fetchResult = FetchResultType.success;
      },
      failure: (_, message) {
        _errorMessage = _fallbackError(message);
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

  Future<FetchResultType> getEmdadgarServiceDetail() async {
    if (!_validateCustomerKilometer()) {
      return FetchResultType.failure;
    }

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
    var fetchResult = FetchResultType.failure;

    result.when(
      success: (data, _, _) {
        emdadgarServiceDetailEntity = data;
        final limitation = data.limitationDescription?.trim();
        _limitationDescription =
            limitation == null || limitation.isEmpty ? null : limitation;
        fetchResult = FetchResultType.success;
      },
      failure: (_, message) {
        _errorMessage = _fallbackError(message);
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

  void _fillDateTimeControllers() {
    dispatchDateController.text = _formatJalaliDate(dispatchDateTime);
    dispatchTimeController.text = _formatTime(dispatchDateTime);
    cancelDateController.text = _formatJalaliDate(cancelDateTime);
    cancelTimeController.text = _formatTime(cancelDateTime);
  }

  String _formatJalaliDate(DateTime? value) {
    if (value == null) return '';
    final jalali = Gregorian.fromDateTime(value).toJalali();
    final month = jalali.month.toString().padLeft(2, '0');
    final day = jalali.day.toString().padLeft(2, '0');
    return '${jalali.year}/$month/$day';
  }

  String _formatTime(DateTime? value) {
    if (value == null) return '';
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
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
          kilometerReadOnlyListenable.value =
              data.isDistanceKilometerEditable != true;

          final distanceKilometer = data.distanceKilometer;
          if (distanceKilometer != null) {
            kilometerController.text = distanceKilometer.toString();
          }
        },
        connectionError: () =>
            _safeEmit(const CancelRequestState.connectionError()),
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

  String? validateDescription(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'توضیحات اجباری است';
    }
    return null;
  }

  Future<void> submit() async {
    _retryAction = null;

    final cancelType = selectedCancelType.value;
    if (cancelType?.id == null) {
      _emitError('دلیل لغو را انتخاب کنید');
      return;
    }

    if (formKey.currentState?.validate() != true) {
      return;
    }

    if (cancelType?.canCreateInvoice != true) {
      _retryAction = submit;
      _safeEmit(const CancelRequestState.submitLoading());
      await submitCancelRequest();
      return;
    }

    if (!_validateCustomerKilometer()) {
      return;
    }

    final detail = emdadgarServiceDetailEntity;
    if (detail == null) {
      _emitError('اطلاعات سرویس برای ثبت فاکتور دریافت نشده است');
      return;
    }

    _retryAction = submit;
    _safeEmit(const CancelRequestState.submitLoading());

    final param = ServiceEvaluationParamEntity(
      serviceType: selectedRequest?.serviceType,
      serviceRequestId: selectedRequest?.id,
      cancelReasonId: cancelType?.id,
      cancelReasonDetailId: selectedCancelReason.value?.id,
      assignDate: dispatchDateTime,
      endWorkDate: cancelDateTime,
      distanceToCustomer: double.tryParse(kilometerController.text.trim()),
      customerKilometer: selectedRequest?.kilometer,
      description: descriptionController.text.trim(),
      servicesAndLaborsAndPartsEvaluationPayload:
          ServicesAndLaborsAndPartsEvaluationPayloadEntity(
        evaluationServices: [
          EvaluationServiceEntity(
            serviceType: detail.serviceType,
            serviceTypeId: detail.serviceTypeId ?? detail.serviceType?.value,
            serviceTypeTitle: detail.serviceTypeTitle,
            serviceCategoryId: detail.serviceCategoryId,
            serviceCategoryTitle: detail.serviceCategoryTitle,
            serviceCategoryCode: detail.serviceCategoryCode,
            serviceId: detail.serviceId,
            serviceTitle: detail.serviceTitle,
            serviceCode: detail.serviceCode,
            hasSubscription: detail.hasSubscription ?? false,
            defectInfoId: detail.defectInfoId,
            defectInfoTitle: detail.defectInfoTitle,
            productId: detail.productId,
            productTitle: detail.productTitle,
            garantyStartDate: detail.garantyStartDate,
            hasGaranty: detail.hasGaranty ?? false,
            subscriptionId: detail.subscriptionId,
            defectInfoProblemOrEzharCode:
                detail.defectInfoProblemOrEzharCode,
            isSubscribedByNationalCode: detail.isSubscribedByNationalCode,
            limitationDescription: detail.limitationDescription,
            evaluationLabors: const [],
          ),
        ],
      ),
    );

    final result = await _postEvaluationUseCase(param);
    result.whenOrNull(
      success: (data, _, _) async {
        final evaluationId = data.id?.trim();
        if (evaluationId == null || evaluationId.isEmpty) {
          _emitError('شناسه ارزیابی از سرور دریافت نشد');
          return;
        }

        emdadgarEvaluationId = evaluationId;
        await _loadCustomerPreInvoice(evaluationId);
      },
      failure: (error, failures) =>
          _emitError(failures ?? error.toString()),
      connectionError: () =>
          _safeEmit(const CancelRequestState.connectionError()),
    );
  }


  Future<void> _loadCustomerPreInvoice(String evaluationId) async {
    _retryAction = () => _loadCustomerPreInvoice(evaluationId);

    final invoiceParam = AcceptEvaluationParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      emdadgarEvaluationId: evaluationId,
    );
    final result = await _customerPreInvoiceOnTheFlyUseCase(invoiceParam);

    result.whenOrNull(
      success: (invoice, _, _) {
        _retryAction = null;
        _safeEmit(CancelRequestState.showPreInvoice(invoice: invoice ?? InvoiceEntity()));
      },
      failure: (error, failures) =>
          _emitError(failures ?? error.toString()),
      connectionError: () =>
          _safeEmit(const CancelRequestState.connectionError()),
    );
  }


  Future<void> submitCancelRequest() async {
    final param = CancelRequestParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      serviceRequestId: selectedRequest?.id,
      cancelReason: selectedCancelType.value?.id,
      cancelReasonDetailId: selectedCancelReason.value?.id,
      cancelDesc: descriptionController.text.trim(),
      needCopy: false,
    );
    final result = await _cancelServiceRequestUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        _retryAction = null;
        _successFromInvoiceFlow = false;
        _safeEmit(CancelRequestState.submitSuccess());
      },
      failure: (error, failures) => _emitError(failures ?? error.toString()),
      connectionError: () =>
          _safeEmit(const CancelRequestState.connectionError()),
    );
  }

  Future<void> acceptEvaluation() async {
    final evaluationId = emdadgarEvaluationId?.trim();
    if (evaluationId == null || evaluationId.isEmpty) {
      _retryAction = null;
      _emitError('شناسه ارزیابی معتبر نیست');
      return;
    }

    _retryAction = acceptEvaluation;
    _safeEmit(const CancelRequestState.submitLoading());
    final param = AcceptEvaluationParamEntity(
      serviceType: selectedRequest?.serviceType ?? ServiceType.reliefService,
      emdadgarEvaluationId: evaluationId,
    );

    final result = await _acceptEvaluationUseCase(param);
    result.whenOrNull(
      success: (data, failures, resultCode) {
        _retryAction = null;
        _successFromInvoiceFlow = true;
        _safeEmit(const CancelRequestState.submitSuccess());
      },
      failure: (error, failures) => _emitError(failures ?? error.toString()),
      connectionError: () =>
          _safeEmit(const CancelRequestState.connectionError()),
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
