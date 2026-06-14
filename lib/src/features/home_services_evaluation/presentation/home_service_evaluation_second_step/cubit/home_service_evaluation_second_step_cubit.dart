import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_image_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/service_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_active_service_request_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_services_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/post_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/network/network_state/error/network_exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'home_service_evaluation_second_step_state.dart';



@injectable
class HomeServiceEvaluationSecondStepCubit extends Cubit<HomeServiceEvaluationSecondStepState> {

  final GetActiveServiceRequestUseCase _getActiveServiceRequestUseCase;
  final GetLastEvaluationUseCase _getLastEvaluationUseCase;
  final PostEvaluationUseCase _postEvaluationUseCase;
  final GetServicesUseCase _getServicesUseCase;

  HomeServiceEvaluationSecondStepCubit(
      this._getActiveServiceRequestUseCase,
      this._getLastEvaluationUseCase,
      this._postEvaluationUseCase,
      this._getServicesUseCase,
      ) : super(const HomeServiceEvaluationSecondStepState.idle());

  final BehaviorSubject<ActiveServiceRequestResponseEntity?> _activeServiceRequestSubject = BehaviorSubject<ActiveServiceRequestResponseEntity?>();
  BehaviorSubject<ActiveServiceRequestResponseEntity?> get activeServiceRequestStream => _activeServiceRequestSubject;

  final BehaviorSubject<bool?> _addOtherServiceSubject = BehaviorSubject<bool?>();
  BehaviorSubject<bool?> get addOtherServiceSubject => _addOtherServiceSubject;

  final BehaviorSubject<LastEvaluationEntity?> _lastEvaluationSubject = BehaviorSubject<LastEvaluationEntity?>();
  LastEvaluationEntity? get lastEvaluationValue => _lastEvaluationSubject.value;

  static List<EvaluationServiceEntity>? selectedServiceList = [];

  static List<EvaluationServiceEntity>? customerServiceList = [];

  static List<EvaluationImageEntity>? evaluationKilometerImageList = [];

  int id = 0;

  @override
  close() async {
    super.close();
    _activeServiceRequestSubject.close();
    _addOtherServiceSubject.close();
    _lastEvaluationSubject.close();
  }

  initState() async{
    emit(const HomeServiceEvaluationSecondStepState.loading());
    final activeServiceRequestResult = await _getActiveServiceRequest();
    final getLastEvaluationResult = await _getLastEvaluation();
    if(getLastEvaluationResult && activeServiceRequestResult) {
      emit(const HomeServiceEvaluationSecondStepState.success());
      customerServiceList = [];
      selectedServiceList = [];
      final evaluationServiceList = _lastEvaluationSubject.valueOrNull?.servicesAndLaborsAndPartsEvaluationPayloadEntity?.evaluationServiceEntity ?? [];
      for(final i in evaluationServiceList) {
        if(i.isCustomerSelected == true) {
          customerServiceList?.add(i);
        }else {
          selectedServiceList?.add(i);
        }
      }
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
            HomeServiceEvaluationSecondStepState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? ''),
            ),
          );
          resultValue = false;
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(
          HomeServiceEvaluationSecondStepState.error(dialogDataModel: DialogDataModel(title: '', description: msg ?? ''),),
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
          _lastEvaluationSubject.add(data);
          resultValue = true;
        } else {
          emit(
            HomeServiceEvaluationSecondStepState.error(
              dialogDataModel: DialogDataModel(
                  title: '', description: failures?.listToString() ?? ''),
            ),
          );
          resultValue = false;
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(
          HomeServiceEvaluationSecondStepState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? ''),
          ),
        );
        resultValue = false;
      },
    );
    return resultValue;
  }

  Future<void> postEvaluation() async {
    emit(const HomeServiceEvaluationSecondStepState.submitLoading());
    final lastEvaluationEntity = _lastEvaluationSubject.value;
    lastEvaluationEntity?.servicesAndLaborsAndPartsEvaluationPayloadEntity?.evaluationServiceEntity =[];
    lastEvaluationEntity?.servicesAndLaborsAndPartsEvaluationPayloadEntity?.evaluationServiceEntity?.addAll(customerServiceList ?? []);
    lastEvaluationEntity?.servicesAndLaborsAndPartsEvaluationPayloadEntity?.evaluationServiceEntity?.addAll(selectedServiceList ?? []);
    if(evaluationKilometerImageList?.isNotEmpty ?? false) {
      lastEvaluationEntity?.images ??= [];
      lastEvaluationEntity?.images = evaluationKilometerImageList;
    }
    bool? imageMandatory = (lastEvaluationEntity?.servicesAndLaborsAndPartsEvaluationPayloadEntity?.evaluationServiceEntity ?? []).any((i) => i.isImageMandatory == true)||
        (lastEvaluationEntity?.servicesAndLaborsAndPartsEvaluationPayloadEntity?.evaluationServiceEntity ?? []).expand((service) => service.evaluationLabors ?? []).any((labor) => (labor as EvaluationLaborResponseEntity).isImageMandatory == true);
    if(imageMandatory ?? false) {
      emit(const HomeServiceEvaluationSecondStepState.submitNeedPhotoSuccess());
      return;
    } else {
      final result = await _postEvaluationUseCase.call(lastEvaluationEntity);
      result.whenOrNull(
        success: (data, failures, resultCode) async {
          if (resultCode == 0) {
            id = data?.id ?? 0;
            emit(const HomeServiceEvaluationSecondStepState.submitSuccess());
          } else {
            emit(
              HomeServiceEvaluationSecondStepState.submitError(
                dialogDataModel: DialogDataModel(
                    title: '', description: failures?.listToString() ?? ''),
              ),
            );
          }
        },
        failure: (NetworkExceptions error, msg) {
          emit(
            HomeServiceEvaluationSecondStepState.submitError(
              dialogDataModel: DialogDataModel(title: '', description: msg ?? ''),
            ),
          );
        },
      );
    }
  }

  Future<void> fetchOtherService() async {
    emit(const HomeServiceEvaluationSecondStepState.otherServiceLoading());
    try {
      final evaluationEntity = EvaluationServiceEntity(
        serviceType: 2,
        serviceCategoryId: 61,
        serviceCategoryCode: "",
        serviceCategoryTitle: "تعمیرات در محل",
        serviceId: 1145,
        serviceCode: "99",
        serviceTitle: "سایر خدمات",
        isSubscribedByNationalCode: true,
        serviceTypeTitle: "",
        hasGaranty: false,
        hasSubscription: false,
        isCustomerSelected: false,
        isImageMandatory: false,
      );
      HomeServiceEvaluationSecondStepCubit.selectedServiceList?.add(evaluationEntity);
      addOtherServiceSubject.add(true);
      emit(const HomeServiceEvaluationSecondStepState.otherServiceSuccess());
    } catch(e) {
      emit(HomeServiceEvaluationSecondStepState.error(
          dialogDataModel: DialogDataModel(title: '', description: 'درخواست با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید')));
    }
  }

  Future<void> deleteCustomerEvaluationService({EvaluationServiceEntity? evaluationServiceEntity}) async{
    customerServiceList?.remove(evaluationServiceEntity);
    refresh();
  }

  Future<void> deleteSelectedEvaluationService({EvaluationServiceEntity? evaluationServiceEntity}) async{
    selectedServiceList?.remove(evaluationServiceEntity);
    _addOtherServiceSubject.add(false);
    refresh();
  }

  refresh() {
    emit(const HomeServiceEvaluationSecondStepState.idle());
    emit(const HomeServiceEvaluationSecondStepState.success());
  }
}
