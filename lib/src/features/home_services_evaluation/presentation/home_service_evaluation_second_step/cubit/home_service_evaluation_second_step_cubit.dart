import 'dart:async';
import 'dart:ui';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_image_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_active_service_request_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/post_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entity/evaluation_part_response_entity.dart';
import 'home_service_evaluation_second_step_state.dart';

@injectable
class HomeServiceEvaluationSecondStepCubit
    extends Cubit<HomeServiceEvaluationSecondStepState> {
  final GetActiveServiceRequestUseCase _getActiveServiceRequestUseCase;
  final GetLastEvaluationUseCase _getLastEvaluationUseCase;
  final PostEvaluationUseCase _postEvaluationUseCase;

  HomeServiceEvaluationSecondStepCubit(
    this._getActiveServiceRequestUseCase,
    this._getLastEvaluationUseCase,
    this._postEvaluationUseCase,
  ) : super(const HomeServiceEvaluationSecondStepState.idle());
  final BehaviorSubject<bool> _openOtherServiceForm =
  BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<bool> get openOtherServiceForm =>
      _openOtherServiceForm;
  final BehaviorSubject<ActiveServiceRequestResponseEntity?>
  _activeServiceRequestSubject =
      BehaviorSubject<ActiveServiceRequestResponseEntity?>();

  BehaviorSubject<ActiveServiceRequestResponseEntity?>
  get activeServiceRequestStream => _activeServiceRequestSubject;

  final BehaviorSubject<bool?> _addOtherServiceSubject =
      BehaviorSubject<bool?>.seeded(false);

  BehaviorSubject<bool?> get addOtherServiceSubject => _addOtherServiceSubject;

  final BehaviorSubject<LastEvaluationEntity?> _lastEvaluationSubject =
      BehaviorSubject<LastEvaluationEntity?>();

  LastEvaluationEntity? get lastEvaluationValue =>
      _lastEvaluationSubject.valueOrNull;

  static List<EvaluationServiceEntity>? selectedServiceList = [];

  static List<EvaluationServiceEntity>? customerServiceList = [];

  static List<EvaluationImageEntity>? evaluationKilometerImageList = [];

  int id = 0;
  VoidCallback? _retryAction;

  void retryLastAction() => _retryAction?.call();

  @override
  Future<void> close() async {
    await _activeServiceRequestSubject.close();
    await _addOtherServiceSubject.close();
    await _lastEvaluationSubject.close();
    return super.close();
  }

  Future<void> initState() async {
    _retryAction = initState;

    emit(const HomeServiceEvaluationSecondStepState.loading());

    final activeServiceRequestResult = await _getActiveServiceRequest();
    if (!activeServiceRequestResult) return;

    final lastEvaluationResult = await _getLastEvaluation();
    if (!lastEvaluationResult) return;

    _fillEvaluationServices();

    emit(const HomeServiceEvaluationSecondStepState.success());
  }

  Future<bool> _getActiveServiceRequest() async {
    bool resultValue = false;

    final result = await _getActiveServiceRequestUseCase.call();

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (resultCode == 0 && data != null) {
          _activeServiceRequestSubject.add(data);
          resultValue = true;
        } else {
          _emitError(failures?.listToString() ?? '');
          resultValue = false;
        }
      },
      failure: (error, failures) {
        _emitError(failures ?? '');
        resultValue = false;
      },
    );

    return resultValue;
  }

  Future<bool> _getLastEvaluation() async {
    bool resultValue = false;

    final result = await _getLastEvaluationUseCase.call();

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (resultCode == 0 && data != null) {
          _lastEvaluationSubject.add(data);
          resultValue = true;
        } else {
          _emitError(failures?.listToString() ?? '');
          resultValue = false;
        }
      },
      failure: (error, msg) {
        _emitError(msg ?? '');
        resultValue = false;
      },
    );

    return resultValue;
  }

  void _fillEvaluationServices() {
    customerServiceList = [];
    selectedServiceList = [];

    final evaluationServiceList =
        _lastEvaluationSubject
            .valueOrNull
            ?.servicesAndLaborsAndPartsEvaluationPayloadEntity
            ?.evaluationServiceEntity ??
        [];

    for (final service in evaluationServiceList) {
      if (service.isCustomerSelected == true) {
        customerServiceList?.add(service);
      } else {
        selectedServiceList?.add(service);
      }
    }

    _addOtherServiceSubject.add(
      selectedServiceList?.any((e) => e.serviceCode == '99') == true,
    );
  }

  Future<void> postEvaluation() async {
    _retryAction = postEvaluation;
    emit(const HomeServiceEvaluationSecondStepState.submitLoading());

    final lastEvaluationEntity = _lastEvaluationSubject.valueOrNull;

    if (lastEvaluationEntity == null) {
      _emitSubmitError('اطلاعات ارزیابی یافت نشد');
      return;
    }

    final payload =
        lastEvaluationEntity.servicesAndLaborsAndPartsEvaluationPayloadEntity ??
        ServicesAndLaborsAndPartsEvaluationPayloadEntity();

    payload.evaluationServiceEntity = [
      ...?customerServiceList,
      ...?selectedServiceList,
    ];

    lastEvaluationEntity.servicesAndLaborsAndPartsEvaluationPayloadEntity =
        payload;

    if (evaluationKilometerImageList?.isNotEmpty == true) {
      lastEvaluationEntity.images = evaluationKilometerImageList;
    }

    final imageMandatory = _hasMandatoryImage(
      payload.evaluationServiceEntity ?? [],
    );

    if (imageMandatory) {
      emit(const HomeServiceEvaluationSecondStepState.submitNeedPhotoSuccess());
      return;
    }

    final result = await _postEvaluationUseCase.call(lastEvaluationEntity);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (resultCode == 0) {
          id = int.tryParse( data?.id.toString() ?? '0') ?? 0;
          emit(const HomeServiceEvaluationSecondStepState.submitSuccess());
        } else {
          _emitSubmitError(failures?.listToString() ?? '');
        }
      },
      failure: (error, msg) {
        _emitSubmitError(msg ?? '');
      },
    );
  }

  bool _hasMandatoryImage(List<EvaluationServiceEntity> services) {
    final hasServiceMandatoryImage = services.any(
      (service) => service.isImageMandatory == true,
    );

    final hasLaborMandatoryImage = services
        .expand<EvaluationLaborResponseEntity>(
          (service) => service.evaluationLabors ?? [],
        )
        .any((labor) => labor.isImageMandatory == true);

    return hasServiceMandatoryImage || hasLaborMandatoryImage;
  }

  Future<void> fetchOtherService() async {
    emit(const HomeServiceEvaluationSecondStepState.otherServiceLoading());

    try {
      final alreadyAdded =
          selectedServiceList?.any((service) => service.serviceCode == '99') ==
          true;

      if (alreadyAdded) {
        emit(const HomeServiceEvaluationSecondStepState.otherServiceSuccess());
        return;
      }

      final evaluationEntity = EvaluationServiceEntity(
        serviceType: ServiceType.homeService.value,
        serviceCategoryId: 61,
        serviceCategoryCode: '',
        serviceCategoryTitle: 'تعمیرات در محل',
        serviceId: 1145,
        serviceCode: '99',
        serviceTitle: 'سایر خدمات',
        isSubscribedByNationalCode: true,
        serviceTypeTitle: '',
        hasGaranty: false,
        hasSubscription: false,
        isCustomerSelected: false,
        isImageMandatory: false,
      );

      selectedServiceList?.add(evaluationEntity);

      _addOtherServiceSubject.add(true);
      _openOtherServiceForm.add(true);

      emit(const HomeServiceEvaluationSecondStepState.otherServiceSuccess());
    } catch (_) {
      _emitError('درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید');
    }
  }

  Future<void> deleteCustomerEvaluationService({
    EvaluationServiceEntity? evaluationServiceEntity,
  }) async {
    customerServiceList?.remove(evaluationServiceEntity);
    refresh();
  }

  Future<void> deleteSelectedEvaluationService({
    EvaluationServiceEntity? evaluationServiceEntity,
  }) async {
    selectedServiceList?.remove(evaluationServiceEntity);

    final hasOtherService =
        selectedServiceList?.any((service) => service.serviceCode == '99') ==
        true;

    _addOtherServiceSubject.add(hasOtherService);

    refresh();
  }

  void refresh() {
    emit(const HomeServiceEvaluationSecondStepState.idle());
    emit(const HomeServiceEvaluationSecondStepState.success());
  }

  void _emitError(String message) {
    emit(
      HomeServiceEvaluationSecondStepState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: _safeMessage(message),
        ),
      ),
    );
  }

  void _emitSubmitError(String message) {
    emit(
      HomeServiceEvaluationSecondStepState.submitError(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: _safeMessage(message),
        ),
      ),
    );
  }

  String _safeMessage(String message) {
    final trimmed = message.trim();

    if (trimmed.isNotEmpty) return trimmed;

    return 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
  }

  void deletePart({
    required int serviceIndex,
    required int laborIndex,
    required EvaluationPartResponseEntity part,
    required bool isCustomer,
  }) {
    final list = isCustomer
        ? customerServiceList
        : selectedServiceList;

    list?[serviceIndex]
        .evaluationLabors?[laborIndex]
        .parts
        ?.remove(part);

    refresh();
  }

  void deleteLabor({
    required int serviceIndex,
    required int laborIndex,
    required bool isCustomer,
  }) {
    final list = isCustomer
        ? customerServiceList
        : selectedServiceList;

    final service = list?[serviceIndex];

    if (service == null) return;

    if (laborIndex < 0 ||
        laborIndex >= (service.evaluationLabors?.length ?? 0)) {
      return;
    }

    service.evaluationLabors?.removeAt(laborIndex);

    refresh();
  }
}
