import 'dart:async';

import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/string_ext.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:eks_sana_plus_org/src/features/finalize_invoice/domain/entities/distance_to_customer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/finalize_invoice/domain/entities/last_evaluation_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/ocr_configuration_kilometer_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/fetch_ocr_configuration_use_case.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_distance_to_customer_home_service_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_home_service_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/set_active_service_request_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/set_last_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/evaluation_draft.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/request/domain/entity/get_request_entity.dart';
import 'package:eks_sana_plus_org/src/network/network_state/error/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'home_service_evaluation_first_step_state.dart';


@injectable
class HomeServiceEvaluationFirstStepCubit extends Cubit<HomeServiceEvaluationFirstStepState> {

  final GetDistanceToCustomerHomeServiceUseCase _getDistanceToCustomerHomeServiceUseCase;
  final GetLastEvaluationHomeServiceUseCase _getLastEvaluationHomeServiceUseCase;
  final SetActiveServiceRequestUseCase _setActiveServiceRequestUseCase;
  final SetLastEvaluationUseCase _setLastEvaluationUseCase;
  final FetchOcrConfigurationUseCase _fetchOcrConfigurationUseCase;
  final EvaluationDraftStore _draft;

  HomeServiceEvaluationFirstStepCubit(
  this._getLastEvaluationHomeServiceUseCase,
  this._getDistanceToCustomerHomeServiceUseCase,
  this._setLastEvaluationUseCase,
  this._fetchOcrConfigurationUseCase,
  this._draft,
  this._setActiveServiceRequestUseCase,
      ) : super(const HomeServiceEvaluationFirstStepState.idle()) {
    _draftSub = _draft.stream.listen(_onDraftChanged);
    _recalcKmReadOnly();
  }



  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController arriveTimeController = TextEditingController();
  final TextEditingController reliefDistanceController = TextEditingController();
  final TextEditingController assignTrackerNameController = TextEditingController();
  final TextEditingController addDescriptionController = TextEditingController();

  final ValueNotifier<bool> validateKilometer = ValueNotifier<bool>(false);
  final TextEditingController customerCarKilometerController = TextEditingController();

  final BehaviorSubject<ActiveServiceRequestResponseEntity?> _activeServiceRequestSubject = BehaviorSubject<ActiveServiceRequestResponseEntity?>();
  BehaviorSubject<ActiveServiceRequestResponseEntity?> get activeServiceRequestStream => _activeServiceRequestSubject;

  final BehaviorSubject<EvaluationResponseEntity?> _evaluationSubject = BehaviorSubject<EvaluationResponseEntity?>();
  BehaviorSubject<EvaluationResponseEntity?> get evaluationSubject => _evaluationSubject;

  late final StreamSubscription _draftSub;


  final BehaviorSubject<bool?> _isKmImageMandatorySubject = BehaviorSubject<bool?>.seeded(null);
  final BehaviorSubject<bool?> _isKmInputEnabledSubject   = BehaviorSubject<bool?>.seeded(null);

  Stream<bool?> get isKmImageMandatory$ => _isKmImageMandatorySubject.stream.distinct();
  Stream<bool?> get isKmInputEnabled$   => _isKmInputEnabledSubject.stream.distinct();

  bool? get isKmImageMandatory => _isKmImageMandatorySubject.valueOrNull;
  bool? get isKmInputEnabled   => _isKmInputEnabledSubject.valueOrNull;

  final BehaviorSubject<bool> _kmReadOnlySubject = BehaviorSubject<bool>.seeded(true);
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
    if (draft.isKilometerValid != null && validateKilometer.value != draft.isKilometerValid) {
      validateKilometer.value = draft.isKilometerValid!;
    }
    _recalcKmReadOnly();
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

  initState({GetRequestEntity? requestEntity}) async{
    emit(const HomeServiceEvaluationFirstStepState.loading());
    _activeServiceRequestSubject.add(requestEntity?.toActiveServiceRequestResponseEntity());
    try {
      final setActiveServiceError = await _setActiveServiceRequest(entity: _activeServiceRequestSubject.valueOrNull);
      if (setActiveServiceError != null) {
        emit(HomeServiceEvaluationFirstStepState.error(
          dialogDataModel: DialogDataModel(title: 'خطا', description: setActiveServiceError),
        ));
        return;
      }
      final lastEvaluationError = await _getLastEvaluation(
        lastEvaluationEntity: LastEvaluationRequestEntity(
          serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id ?? 0,
          serviceType: _activeServiceRequestSubject.valueOrNull?.serviceType,
          emdadgarId: _activeServiceRequestSubject.valueOrNull?.emdadgarId,
        ),
      );
      if (lastEvaluationError != null) {
        emit(HomeServiceEvaluationFirstStepState.error(
          dialogDataModel: DialogDataModel(title: 'خطا', description: lastEvaluationError),
        ));
        return;
      }
      final distanceToCustomerError = await _getDistanceToCustomer(
        serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id ?? 0,
        serviceType: _activeServiceRequestSubject.valueOrNull?.serviceType ?? 0,
      );
      if (distanceToCustomerError != null) {
        emit(HomeServiceEvaluationFirstStepState.error(
          dialogDataModel: DialogDataModel(title: 'خطا', description: distanceToCustomerError),
        ));
        return;
      }
      final ocrConfigurationError = await _fetchOcrConfiguration(
        serviceType: _activeServiceRequestSubject.valueOrNull?.serviceType ?? 0,
      );
      if (ocrConfigurationError != null) {
        emit(HomeServiceEvaluationFirstStepState.error(
          dialogDataModel: DialogDataModel(title: 'خطا', description: ocrConfigurationError),
        ));
        return;
      }
      HomeServiceEvaluationSecondStepCubit.selectedServiceList?.clear();
      HomeServiceEvaluationSecondStepCubit.customerServiceList?.clear();
      emit(const HomeServiceEvaluationFirstStepState.success());
    } catch(e) {
      emit(
        HomeServiceEvaluationFirstStepState.error(
          dialogDataModel: DialogDataModel(
            title: 'خطا',
            description: 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید',
          ),
        ),
      );
    }
  }

  Future<String?> _setActiveServiceRequest({ActiveServiceRequestResponseEntity? entity}) async {
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
      failure: (NetworkExceptions error, msg) {
        if (errMsg!.isEmpty) errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
      },
    );
    return (errMsg != null && errMsg!.isNotEmpty) ? errMsg : null;
  }

  Future<String?> _getLastEvaluation({LastEvaluationRequestEntity? lastEvaluationEntity}) async {
    final result = await _getLastEvaluationHomeServiceUseCase.call(lastEvaluationEntity ?? LastEvaluationRequestEntity());
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
      failure: (NetworkExceptions error, msg) {
        errMsg = (msg ?? error.toString()).trim();
        if (errMsg!.isEmpty) errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
      },
    );
    return (errMsg != null && errMsg!.isNotEmpty) ? errMsg : null;
  }

  Future<String?> _getDistanceToCustomer({int? serviceRequestId, int? serviceType}) async {
    final result = await _getDistanceToCustomerHomeServiceUseCase.call(DistanceToCustomerRequestEntity(
      serviceRequestId: serviceRequestId,
      needHaml: true,
      serviceType: serviceType,
    ));
    String? errMsg;
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          final currentEval = _evaluationSubject.valueOrNull;
          if (_evaluationSubject.valueOrNull?.lastEvaluationEntity?.distanceToCustomer == null ||
              reliefDistanceController.text.isEmpty) {
            reliefDistanceController.text = data?.drivenDistance?.toString() ?? '';
            final updatedLast = currentEval?.lastEvaluationEntity?.copyWith(
              distanceToCustomer: double.tryParse(reliefDistanceController.text) ?? 0,
            );
            final updatedEval = currentEval?.copyWith(
              lastEvaluationEntity: updatedLast,
            );
            if (updatedEval != null) {
              _evaluationSubject.add(updatedEval);
            }
          }
          assignTrackerNameController.text = data?.startTimeFollowUpName?.toString() ?? '';
          startTimeController.text = data?.startTime?.toString().convertNumberWithLanguage() ?? '';
          arriveTimeController.text = data?.arrivedTime?.toString().convertNumberWithLanguage() ?? '';
          final updatedLast = _evaluationSubject.valueOrNull
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
      failure: (NetworkExceptions error, msg) {
        errMsg = (msg ?? error.toString()).trim();
        if (errMsg!.isEmpty) errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
      },
    );
    return (errMsg != null && errMsg!.isNotEmpty) ? errMsg : null;
  }

  Future<String?> _fetchOcrConfiguration({int? serviceType}) async {
    final result = await _fetchOcrConfigurationUseCase.call(OcrConfigurationKilometerRequestEntity(
      serviceType: serviceType,
    ));
    String? errMsg;
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _isKmImageMandatorySubject.add(data?.isSavingImageMandatory);
          _isKmInputEnabledSubject.add(data?.isKilometerInputEnabled);
          _recalcKmReadOnly();
        } else {
          errMsg = failures?.listToString().trim();
          if (errMsg == null || errMsg!.isEmpty) {
            errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
          }
        }
      },
      failure: (NetworkExceptions error, msg) {
        errMsg = (msg ?? error.toString()).trim();
        if (errMsg!.isEmpty) errMsg = 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
      },
    );
    return (errMsg != null && errMsg!.isNotEmpty) ? errMsg : null;
  }

  Future<void> submit() async{
    emit(const HomeServiceEvaluationFirstStepState.submitLoading());

    final isMandatoryPhoto = _isKmImageMandatorySubject.valueOrNull == true;
    final hasPhoto = _draft.value.kilometerPhoto != null;


    if (isMandatoryPhoto && !hasPhoto) {
      emit(HomeServiceEvaluationFirstStepState.submitError(
        dialogDataModel: DialogDataModel(
          title: '',
          description: 'بارگذاری تصویر کیلومتر الزامی است',
        ),
      ));
      return;
    }

    final text = customerCarKilometerController.text.trim();
    if(text.isEmpty) {
      emit(HomeServiceEvaluationFirstStepState.submitError(
        dialogDataModel: DialogDataModel(title: '', description: 'کیلومتر خودرو مشتری نمی‌تواند خالی باشد'),
      ));
      return ;
    }
    int customerKilometer = int.tryParse(text) ?? 0;
    if(activeServiceRequestStream.valueOrNull?.saipaKilometer != null) {
      if(((activeServiceRequestStream.valueOrNull!.saipaKilometer ?? 0) > 0)) {
        if(activeServiceRequestStream.valueOrNull!.saipaKilometer! > customerKilometer) {
          emit(HomeServiceEvaluationFirstStepState.submitError(
            dialogDataModel: DialogDataModel(title: '', description: 'کیلومتر خودرو مشتری نمی تواند کمتر از آخرین کیلومتر ثبت شده در سایپایدک باشد'),
          ));
          return ;
        }
      }
    }
    final current = _evaluationSubject.valueOrNull?.lastEvaluationEntity ?? LastEvaluationEntity();
    final updated = current.copyWith(
      customerKilometer: customerKilometer,
      description: addDescriptionController.text,
    );
    _evaluationSubject.valueOrNull?.lastEvaluationEntity = updated;
    _evaluationSubject.add(_evaluationSubject.valueOrNull);
    final result = await _setLastEvaluationUseCase.call(_evaluationSubject.valueOrNull?.lastEvaluationEntity ?? LastEvaluationEntity());
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          emit(const HomeServiceEvaluationFirstStepState.submitSuccess());
        } else {
          emit(
            HomeServiceEvaluationFirstStepState.error(
              dialogDataModel: DialogDataModel(
                  title: '', description: failures?.listToString() ?? ''),
            ),
          );
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(
          HomeServiceEvaluationFirstStepState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? ''),
          ),
        );
      },
    );
  }
}
