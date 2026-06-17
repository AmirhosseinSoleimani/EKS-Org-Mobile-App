import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/ocr_configuration_kilometer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/fetch_ocr_configuration_use_case.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_distance_to_customer_home_service_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_home_service_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/set_active_service_request_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/set_last_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/evaluation_draft.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_first_step/controllers/evaluation_main_form_controller.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_first_step/mapper/home_service_request_entity_mapper.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_home_service_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'home_service_evaluation_first_step_state.dart';

@injectable
class HomeServiceEvaluationFirstStepCubit
    extends Cubit<HomeServiceEvaluationFirstStepState> {
  final GetDistanceToCustomerHomeServiceUseCase
  _getDistanceToCustomerHomeServiceUseCase;
  final GetLastEvaluationHomeServiceUseCase
  _getLastEvaluationHomeServiceUseCase;
  final SetActiveServiceRequestUseCase _setActiveServiceRequestUseCase;
  final SetLastEvaluationUseCase _setLastEvaluationUseCase;
  final EvaluationDraftStore _draft;
  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetHomeServiceRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;

  HomeServiceEvaluationFirstStepCubit(
    this._getLastEvaluationHomeServiceUseCase,
    this._getDistanceToCustomerHomeServiceUseCase,
    this._setLastEvaluationUseCase,
    this._draft,
    this._setActiveServiceRequestUseCase,
    this._fetchSelectedRequestItemUseCase,
    this._getReliefRequestByIdUseCase,
    this._getEmdadgarInfoUseCase,
  ) : super(const HomeServiceEvaluationFirstStepState.idle()) {
    _draftSub = _draft.stream.listen(_onDraftChanged);
    _recalcKmReadOnly();
  }

  HomeServiceRequestEntity? requestEntity;
  EmdadgarInfoEntity? emdadgarInfo;
    EvaluationMainFormController? mainForm;
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController arriveTimeController = TextEditingController();
  final TextEditingController reliefDistanceController =
      TextEditingController();
  final TextEditingController assignTrackerNameController =
      TextEditingController();
  final TextEditingController addDescriptionController =
      TextEditingController();

  final ValueNotifier<bool> validateKilometer = ValueNotifier<bool>(false);
  final TextEditingController customerCarKilometerController =
      TextEditingController();

  final BehaviorSubject<ActiveServiceRequestResponseEntity?>
  _activeServiceRequestSubject =
      BehaviorSubject<ActiveServiceRequestResponseEntity?>();

  BehaviorSubject<ActiveServiceRequestResponseEntity?>
  get activeServiceRequestStream => _activeServiceRequestSubject;

  final BehaviorSubject<EvaluationResponseEntity?> _evaluationSubject =
      BehaviorSubject<EvaluationResponseEntity?>();

  BehaviorSubject<EvaluationResponseEntity?> get evaluationSubject =>
      _evaluationSubject;

  late final StreamSubscription _draftSub;

  final BehaviorSubject<bool?> _isKmImageMandatorySubject =
      BehaviorSubject<bool?>.seeded(null);
  final BehaviorSubject<bool?> _isKmInputEnabledSubject =
      BehaviorSubject<bool?>.seeded(null);

  Stream<bool?> get isKmImageMandatory$ =>
      _isKmImageMandatorySubject.stream.distinct();

  Stream<bool?> get isKmInputEnabled$ =>
      _isKmInputEnabledSubject.stream.distinct();

  bool? get isKmImageMandatory => _isKmImageMandatorySubject.valueOrNull;

  bool? get isKmInputEnabled => _isKmInputEnabledSubject.valueOrNull;

  final BehaviorSubject<bool> _kmReadOnlySubject = BehaviorSubject<bool>.seeded(
    true,
  );

  Stream<bool> get kmReadOnly$ => _kmReadOnlySubject.stream.distinct();

  bool get kilometerFieldReadOnly {
    final inputEnabled = _isKmInputEnabledSubject.valueOrNull == true;
    return !inputEnabled;
  }

  void _recalcKmReadOnly() {
    _kmReadOnlySubject.add(kilometerFieldReadOnly);
  }

  void _onDraftChanged(EvaluationDraft draft) {
    if (draft.customerKilometer != null) {
      final txt = draft.customerKilometer.toString().padLeft(6, '0');
      if (customerCarKilometerController.text != txt) {
        customerCarKilometerController.text = txt;
      }
    }
    if (draft.isKilometerValid != null &&
        validateKilometer.value != draft.isKilometerValid) {
      validateKilometer.value = draft.isKilometerValid!;
    }
    _recalcKmReadOnly();
  }

  Future<void> initState() async {
    emit(const HomeServiceEvaluationFirstStepState.loading());
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:

        emit(const HomeServiceEvaluationFirstStepState.success());
        break;

      case FetchResultType.failure:
        emit(
          HomeServiceEvaluationFirstStepState.error(
            message: BottomSheetMessageModel(
              title: '',
              message: 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید',
            ),
          ),
        );
        break;

      case FetchResultType.connectionError:
        emit(
          HomeServiceEvaluationFirstStepState.error(
            message: BottomSheetMessageModel(
              title: '',
              message: 'ارتباط با سرور برقرار نشد',
            ),
          ),
        );
        break;

      case FetchResultType.expireToken:
        emit(
          HomeServiceEvaluationFirstStepState.error(
            message: BottomSheetMessageModel(
              title: '',
              message: 'نشست شما منقضی شده است. لطفا دوباره وارد شوید',
            ),
          ),
        );
        break;
    }

    mainForm = EvaluationMainFormController(_syncToCubit);
  }
  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedRequest();

    if (selectedResult != FetchResultType.success) {
      return selectedResult;
    }

    final requestResult = await _fetchServiceRequestData();

    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    final emdadgarResult = await _fetchEmdadgarInfo();

    if (emdadgarResult != FetchResultType.success) {
      return emdadgarResult;
    }

    final setActiveServiceError = await _setActiveServiceRequest(
      entity: _activeServiceRequestSubject.valueOrNull,
    );

    if (setActiveServiceError != null) {
      return FetchResultType.failure;
    }

    final request = _activeServiceRequestSubject.valueOrNull;

    final lastEvaluationError = await _getLastEvaluation(
      lastEvaluationEntity: LastEvaluationRequestEntity(
        serviceRequestId: request?.id ?? 0,
        serviceType: ServiceType.fromValue(request?.serviceType),
        emdadgarId: request?.emdadgarId,
      ),
    );

    if (lastEvaluationError != null) {
      return FetchResultType.failure;
    }

    final distanceToCustomerError = await _getDistanceToCustomer(
      serviceRequestId: request?.id ?? 0,
      serviceType: request?.serviceType ?? 0,
    );

    if (distanceToCustomerError != null) {
      return FetchResultType.failure;
    }

    HomeServiceEvaluationSecondStepCubit.selectedServiceList?.clear();
    HomeServiceEvaluationSecondStepCubit.customerServiceList?.clear();

    return FetchResultType.success;
  }

  void _syncToCubit() {
    final form = mainForm;

    final eval = _evaluationSubject.valueOrNull?.lastEvaluationEntity;

    final updated = eval?.copyWith(
      assignDate: form?.assignDateTime?.toIso8601String(),
      arriveDate: form?.arriveDateTime?.toIso8601String(),
      customerKilometer: int.tryParse(form?.kilometerController.text??'0'),
      distanceToCustomer:
      double.tryParse(form?.customerDistanceController.text ?? '0'),
    );

    if (updated != null) {
      _evaluationSubject.add(
        _evaluationSubject.valueOrNull?.copyWith(
          lastEvaluationEntity: updated,
        ),
      );
    }
  }

  Future<FetchResultType> _fetchSelectedRequest() async {
    final result = await _fetchSelectedRequestItemUseCase.call();

    if (result == null || result is! HomeServiceRequestEntity) {
      _emitError('درخواست انتخاب شده یافت نشد');
      return FetchResultType.failure;
    }

    requestEntity = result;

    return FetchResultType.success;
  }

  Future<FetchResultType> _fetchEmdadgarInfo() async {
    final request = requestEntity;

    if (request?.id == null) {
      _emitError('شناسه درخواست معتبر نیست');
      return FetchResultType.failure;
    }

    final result = await _getEmdadgarInfoUseCase.call(
      ServiceRequestParamEntity(
        serviceRequestId: request?.id,
        serviceType: request?.serviceType?.value,
      ),
    );

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (resultCode == 0) {
          emdadgarInfo = data;
          fetchResult = FetchResultType.success;
        } else {
          final message = failures?.listToString().trim();

          _emitError(
            message == null || message.isEmpty
                ? 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید'
                : message,
          );

          fetchResult = FetchResultType.failure;
        }
      },
      failure: (error, failures) {
        _emitError(
          (failures == null || failures.trim().isEmpty)
              ? 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید'
              : failures,
        );

        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );

    return fetchResult;
  }

  Future<FetchResultType> _fetchServiceRequestData() async {
    final id = requestEntity?.id;

    if (id == null || id == 0) {
      _emitError('شناسه درخواست معتبر نیست');
      return FetchResultType.failure;
    }

    final result = await _getReliefRequestByIdUseCase.call(id);

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (resultCode == 0 && data != null) {
          requestEntity = data;

          _activeServiceRequestSubject.add(
            data.toActiveServiceRequestResponseEntity(),
          );

          fetchResult = FetchResultType.success;
        } else {
          final message = failures?.listToString().trim();

          _emitError(
            message == null || message.isEmpty
                ? 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید'
                : message,
          );

          fetchResult = FetchResultType.failure;
        }
      },
      failure: (error, failures) {
        _emitError(
          (failures == null || failures.trim().isEmpty)
              ? 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید'
              : failures,
        );

        fetchResult = FetchResultType.failure;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
    );

    return fetchResult;
  }

  Future<String?> _setActiveServiceRequest({
    ActiveServiceRequestResponseEntity? entity,
  }) async {
    final result = await _setActiveServiceRequestUseCase.call(entity);
    String? errMsg;
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode != 0) {
          errMsg = failures?.listToString().trim();
          if (errMsg == null || errMsg!.isEmpty) {
            errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
          }
        }
      },
      failure: (error, failures) {
        if (errMsg!.isEmpty) {
          errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
        }
      },
    );
    return (errMsg != null && errMsg!.isNotEmpty) ? errMsg : null;
  }

  Future<String?> _getLastEvaluation({
    LastEvaluationRequestEntity? lastEvaluationEntity,
  }) async {
    final result = await _getLastEvaluationHomeServiceUseCase.call(
      lastEvaluationEntity ??
          LastEvaluationRequestEntity(serviceType: ServiceType.homeService),
    );
    String? errMsg;
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _evaluationSubject.add(data);
        } else {
          errMsg = failures?.listToString().trim();
          if (errMsg == null || errMsg!.isEmpty) {
            errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
          }
        }
      },
      failure: (error, failures) {
        errMsg = (failures ?? error.toString()).trim();
        if (errMsg!.isEmpty) {
          errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
        }
      },
    );
    return (errMsg != null && errMsg!.isNotEmpty) ? errMsg : null;
  }

  Future<String?> _getDistanceToCustomer({
    int? serviceRequestId,
    int? serviceType,
  }) async {
    final result = await _getDistanceToCustomerHomeServiceUseCase.call(
      DistanceToCustomerRequestEntity(
        serviceRequestId: serviceRequestId,
        needHaml: true,
        serviceType: ServiceType.fromValue(serviceType),
      ),
    );
    String? errMsg;
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          final currentEval = _evaluationSubject.valueOrNull;
          if (_evaluationSubject
                      .valueOrNull
                      ?.lastEvaluationEntity
                      ?.distanceToCustomer ==
                  null ||
              reliefDistanceController.text.isEmpty) {
            reliefDistanceController.text =
                data?.drivenDistance?.toString() ?? '';
            final updatedLast = currentEval?.lastEvaluationEntity?.copyWith(
              distanceToCustomer:
                  double.tryParse(reliefDistanceController.text) ?? 0,
            );
            final updatedEval = currentEval?.copyWith(
              lastEvaluationEntity: updatedLast,
            );
            if (updatedEval != null) {
              _evaluationSubject.add(updatedEval);
            }
          }
          assignTrackerNameController.text =
              data?.startTimeFollowUpName?.toString() ?? '';
          startTimeController.text =
              data?.startTime?.toString().convertNumberWithLanguage() ?? '';
          arriveTimeController.text =
              data?.arrivedTime?.toString().convertNumberWithLanguage() ?? '';
          final updatedLast = _evaluationSubject
              .valueOrNull
              ?.lastEvaluationEntity
              ?.copyWith(
                arriveDate: data?.arrivedTimeDate,
                assignDate: data?.startTimeDate,
                endWorkDate: data?.endTimeDate,
                arriveTrackerName: data?.arrivedTimeFollowUpName,
                assignTrackerName: data?.startTimeFollowUpName,
                endWorkTrackerName: data?.endTimeFollowUpName,
              );
          final updatedEval2 = _evaluationSubject.valueOrNull?.copyWith(
            lastEvaluationEntity: updatedLast,
          );

          if (updatedEval2 != null) {
            _evaluationSubject.add(updatedEval2);
          }
        } else {
          errMsg = failures?.listToString().trim();
          if (errMsg == null || errMsg!.isEmpty) {
            errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
          }
        }
      },
      failure: (error, failures) {
        errMsg = (failures ?? error.toString()).trim();
        if (errMsg!.isEmpty) {
          errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
        }
      },
    );
    return (errMsg != null && errMsg!.isNotEmpty) ? errMsg : null;
  }

  Future<void> submit() async {
    emit(const HomeServiceEvaluationFirstStepState.submitLoading());

    final isMandatoryPhoto = _isKmImageMandatorySubject.valueOrNull == true;
    final hasPhoto = _draft.value.kilometerPhoto != null;

    if (isMandatoryPhoto && !hasPhoto) {
      emit(
        HomeServiceEvaluationFirstStepState.submitError(
          message: BottomSheetMessageModel(
            title: 'خطا',
            message: 'بارگذاری تصویر کیلومتر الزامی است',
          ),
        ),
      );
      return;
    }

    final text = customerCarKilometerController.text.trim();
    if (text.isEmpty) {
      emit(
        HomeServiceEvaluationFirstStepState.submitError(
          message: BottomSheetMessageModel(
            title: '',
            message: 'کیلومتر خودرو مشتری نمی‌تواند خالی باشد',
          ),
        ),
      );
      return;
    }
    int customerKilometer = int.tryParse(text) ?? 0;
    if (activeServiceRequestStream.valueOrNull?.saipaKilometer != null) {
      if (((activeServiceRequestStream.valueOrNull!.saipaKilometer ?? 0) > 0)) {
        if (activeServiceRequestStream.valueOrNull!.saipaKilometer! >
            customerKilometer) {
          emit(
            HomeServiceEvaluationFirstStepState.submitError(
              message: BottomSheetMessageModel(
                title: '',
                message:
                    'کیلومتر خودرو مشتری نمی تواند کمتر از آخرین کیلومتر ثبت شده در سایپایدک باشد',
              ),
            ),
          );
          return;
        }
      }
    }
    final current =
        _evaluationSubject.valueOrNull?.lastEvaluationEntity ??
        LastEvaluationEntity();
    final updated = current.copyWith(
      customerKilometer: customerKilometer,
      description: addDescriptionController.text,
    );
    _evaluationSubject.valueOrNull?.lastEvaluationEntity = updated;
    _evaluationSubject.add(_evaluationSubject.valueOrNull);
    final result = await _setLastEvaluationUseCase.call(
      _evaluationSubject.valueOrNull?.lastEvaluationEntity ??
          LastEvaluationEntity(),
    );
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          emit(const HomeServiceEvaluationFirstStepState.submitSuccess());
        } else {
          emit(
            HomeServiceEvaluationFirstStepState.error(
              message: BottomSheetMessageModel(
                title: 'خطا',
                message: failures?.listToString() ?? '',
              ),
            ),
          );
        }
      },
      failure: (error, failures) {
        emit(
          HomeServiceEvaluationFirstStepState.error(
            message: BottomSheetMessageModel(
              title: '',
              message: failures ?? '',
            ),
          ),
        );
      },
    );
  }

  void _emitError(String message) {
    emit(
      HomeServiceEvaluationFirstStepState.error(
        message: BottomSheetMessageModel(title: 'خطا', message: message),
      ),
    );
  }

  @override
  Future<void> close() async {
    _draft.clear();
    await _activeServiceRequestSubject.close();
    await _draftSub.cancel();
    await _evaluationSubject.close();
    await _isKmImageMandatorySubject.close();
    await _isKmInputEnabledSubject.close();
    await _kmReadOnlySubject.close();
    return super.close();
  }
}
