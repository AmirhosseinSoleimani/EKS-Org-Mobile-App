import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_active_service_request_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_services_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/service_list/cubit/service_list_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class ServiceListCubit extends Cubit<ServiceListState> {
  final GetServicesUseCase _getServicesUseCase;
  final GetActiveServiceRequestUseCase _getActiveServiceRequestUseCase;
  final GetLastEvaluationUseCase _getLastEvaluationUseCase;

  ServiceListCubit(
    this._getServicesUseCase,
    this._getActiveServiceRequestUseCase,
    this._getLastEvaluationUseCase,
  ) : super(const ServiceListState.idle());

  final TextEditingController searchLaborController = TextEditingController();

  final BehaviorSubject<ActiveServiceRequestResponseEntity?>
  _activeServiceRequestSubject =
      BehaviorSubject<ActiveServiceRequestResponseEntity?>();

  BehaviorSubject<ActiveServiceRequestResponseEntity?>
  get activeServiceRequestSubject => _activeServiceRequestSubject;

  final BehaviorSubject<LastEvaluationEntity?> _lastEvaluationSubject =
      BehaviorSubject<LastEvaluationEntity?>();

  BehaviorSubject<LastEvaluationEntity?> get lastEvaluationSubject =>
      _lastEvaluationSubject;

  final BehaviorSubject<List<EmdadServiceResultEntity>?>
  _serviceResponseSubject = BehaviorSubject<List<EmdadServiceResultEntity>?>();

  BehaviorSubject<List<EmdadServiceResultEntity>?> get serviceResponseSubject =>
      _serviceResponseSubject;

  initState() async {
    emit(const ServiceListState.loading());
    final activeServiceRequestResult = await _getActiveServiceRequest();
    final lastEvaluationResult = await _getLastEvaluation();
    if (lastEvaluationResult && activeServiceRequestResult) {
      emit(const ServiceListState.success());
    }
  }

  Future<bool> _getActiveServiceRequest() async {
    bool resultValue = false;
    final result = await _getActiveServiceRequestUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _activeServiceRequestSubject.value = data;
          resultValue = true;
        } else {
          emit(
            ServiceListState.error(
              bottomSheetMessage: BottomSheetMessageModel(
                title: '',
                message: failures?.listToString() ?? '',
              ),
            ),
          );
          resultValue = false;
        }
      },
      failure: (error, msg) {
        emit(
          ServiceListState.error(
            bottomSheetMessage: BottomSheetMessageModel(
              title: '',
              message: msg ?? '',
            ),
          ),
        );
        resultValue = false;
      },
    );
    return resultValue;
  }

  Future<bool> _getLastEvaluation() async {
    bool resultValue = false;
    final result = await _getLastEvaluationUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _lastEvaluationSubject.value = data;
          resultValue = true;
        } else {
          emit(
            ServiceListState.error(
              bottomSheetMessage: BottomSheetMessageModel(
                title: '',
                message: failures?.listToString() ?? '',
              ),
            ),
          );
          resultValue = false;
        }
      },
      failure: (error, msg) {
        emit(
          ServiceListState.error(
            bottomSheetMessage: BottomSheetMessageModel(
              title: '',
              message: msg ?? '',
            ),
          ),
        );
        resultValue = false;
      },
    );
    return resultValue;
  }

  Future<void> getAllServices(String? value) async {
    emit(const ServiceListState.getServiceLoading());
    final result = await _getServicesUseCase.call(
      ServiceRequestEntity(
        serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
        serviceType: ServiceType.homeService,
        nationalCode: _activeServiceRequestSubject.valueOrNull?.nationalNumber,
        kilometer: _lastEvaluationSubject.valueOrNull?.customerKilometer,
        planningId: _activeServiceRequestSubject.valueOrNull?.planningId,
        defectId: _activeServiceRequestSubject.valueOrNull?.defectId,
        carInfoGuid: _activeServiceRequestSubject.valueOrNull?.carGuid,
        serviceName: value,
      ),
    );
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _serviceResponseSubject.add(data?.serviceList);
          emit(const ServiceListState.getServiceSuccess());
        } else {
          emit(
            ServiceListState.error(
              bottomSheetMessage: BottomSheetMessageModel(
                title: '',
                message: failures?.listToString() ?? '',
              ),
            ),
          );
        }
      },
      failure: (error, msg) {
        emit(
          ServiceListState.error(
            bottomSheetMessage: BottomSheetMessageModel(
              title: '',
              message: msg ?? '',
            ),
          ),
        );
      },
    );
  }

  Future<void> selectService({required int index}) async {
    emit(const ServiceListState.selectServiceLoading());
    final evaluationEntity = EvaluationServiceEntity(
      serviceType: _serviceResponseSubject.valueOrNull?[index].serviceType,
      serviceCategoryId:
          _serviceResponseSubject.valueOrNull?[index].serviceCategoryId,
      serviceCategoryCode:
          _serviceResponseSubject.valueOrNull?[index].serviceCategoryCode,
      serviceCategoryTitle:
          _serviceResponseSubject.valueOrNull?[index].serviceCategoryTitle,
      serviceId: _serviceResponseSubject.valueOrNull?[index].serviceId,
      serviceCode: _serviceResponseSubject.valueOrNull?[index].serviceCode,
      serviceTitle: _serviceResponseSubject.valueOrNull?[index].serviceTitle,
      isSubscribedByNationalCode: _serviceResponseSubject
          .valueOrNull?[index]
          .isSubscribedByNationalCode,
      serviceTypeTitle:
          _serviceResponseSubject.valueOrNull?[index].serviceTypeTitle,
      subscriptionId:
          _serviceResponseSubject.valueOrNull?[index].subscriptionId,
      limitationDescription:
          _serviceResponseSubject.valueOrNull?[index].limitedDescription,
      defectInfoProblemOrEzharCode:
          _serviceResponseSubject.valueOrNull?[index].workOrderCode,
      hasGaranty: _activeServiceRequestSubject.valueOrNull?.guaranty,
      hasSubscription: _activeServiceRequestSubject.valueOrNull?.subscription,
      defectInfoId: _activeServiceRequestSubject.valueOrNull?.defectId,
      defectInfoTitle: _activeServiceRequestSubject.valueOrNull?.defectTitle,
      isCustomerSelected: false,
      isImageMandatory:
          _serviceResponseSubject.valueOrNull?[index].imageMandatory,
    );
    HomeServiceEvaluationSecondStepCubit.selectedServiceList?.add(
      evaluationEntity,
    );
    emit(const ServiceListState.selectServiceSuccess());
  }
}
