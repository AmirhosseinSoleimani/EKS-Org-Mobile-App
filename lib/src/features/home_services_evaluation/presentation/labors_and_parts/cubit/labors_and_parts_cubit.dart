import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/evaluation_part_response_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/active_service_request_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/labor_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_mark_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_price_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/part_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/reusable_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_active_service_request_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_labor_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_last_evaluation_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_part_mark_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_part_price_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_part_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/get_reusable_price_usecase.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/labors_and_parts/cubit/labors_and_parts_state.dart';
import 'package:eks_sana_plus_org/src/network/network_state/error/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class LaborsAndPartsCubit extends Cubit<LaborsAndPartsState> {

  final GetActiveServiceRequestUseCase _getActiveServiceRequestUseCase;
  final GetLastEvaluationUseCase _getLastEvaluationUseCase;
  final GetLaborUseCase _getLaborUseCase;
  final GetPartUseCase _getPartUseCase;
  final GetPartMarkHomeServiceUseCase _getPartMarkHomeServiceUseCase;
  final GetPartPriceHomeServiceUseCase _getPartPriceHomeServiceUseCase;
  final GetReusablePriceUseCase _getReusablePriceUseCase;

  LaborsAndPartsCubit(
      this._getLaborUseCase,
      this._getPartUseCase,
      this._getPartMarkHomeServiceUseCase,
      this._getLastEvaluationUseCase,
      this._getActiveServiceRequestUseCase,
      this._getPartPriceHomeServiceUseCase,
      this._getReusablePriceUseCase
      ) : super(const LaborsAndPartsState.idle());

  final TextEditingController searchLaborController = TextEditingController();
  final TextEditingController searchPartController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController countController = TextEditingController(text: '1');
  final TextEditingController reusableTitleController = TextEditingController();
  final TextEditingController reusablePriceController = TextEditingController();
  final TextEditingController searchReusablePartController = TextEditingController();


  final BehaviorSubject<ActiveServiceRequestResponseEntity?> _activeServiceRequestSubject = BehaviorSubject<ActiveServiceRequestResponseEntity?>();
  BehaviorSubject<ActiveServiceRequestResponseEntity?> get activeServiceRequestSubject => _activeServiceRequestSubject;

  final BehaviorSubject<LastEvaluationEntity?> _lastEvaluationSubject = BehaviorSubject<LastEvaluationEntity?>();
  BehaviorSubject<LastEvaluationEntity?> get lastEvaluationSubject => _lastEvaluationSubject;

  final BehaviorSubject<List<LaborResponseEntity?>> _laborResponseListSubject = BehaviorSubject<List<LaborResponseEntity?>>();
  BehaviorSubject<List<LaborResponseEntity?>> get laborResponseListSubject => _laborResponseListSubject;

  final BehaviorSubject<List<PartResponseEntity?>> _partResponseListSubject = BehaviorSubject<List<PartResponseEntity?>>();
  BehaviorSubject<List<PartResponseEntity?>> get partResponseListSubject => _partResponseListSubject;

  final BehaviorSubject<String> _priceLaborSubject = BehaviorSubject<String>.seeded('');
  BehaviorSubject<String?> get priceLaborSubject => _priceLaborSubject;

  final BehaviorSubject<String> _pricePartSubject = BehaviorSubject<String>.seeded('');
  BehaviorSubject<String?> get pricePartSubject => _pricePartSubject;

  final BehaviorSubject<ReusableEntity?> _reusableSubject = BehaviorSubject<ReusableEntity?>();
  BehaviorSubject<ReusableEntity?> get reusableSubject => _reusableSubject;


  LaborResponseEntity? selectLaborResponseEntity = LaborResponseEntity();
  CostCenterEntity? selectLaborCostCenterEntity = CostCenterEntity();
  PartResponseEntity? selectPartResponseEntity = PartResponseEntity();
  CostCenterEntity? selectPartCostCenterEntity = CostCenterEntity();
  final List<PartMarkResponseEntity?> markList = [];
  List<String> overlapCodes = [];
  String? maxPartPrice;

  @override
  close() async {
    super.close();
    _activeServiceRequestSubject.close();
    _reusableSubject.close();
    _priceLaborSubject.close();
    _partResponseListSubject.close();
    _lastEvaluationSubject.close();
    _laborResponseListSubject.close();
    _pricePartSubject.close();

  }

  initState() async{
    emit(const LaborsAndPartsState.loading());
    final activeServiceRequestResult = await _getActiveServiceRequest();
    final lastEvaluationResult = await _getLastEvaluation();
    if(activeServiceRequestResult != 'Success') {
      return emit(LaborsAndPartsState.error(dialogDataModel: DialogDataModel(title: '', description: activeServiceRequestResult)));
    }else if(lastEvaluationResult != 'Success') {
      return emit(LaborsAndPartsState.error(dialogDataModel: DialogDataModel(title: '', description: lastEvaluationResult)));
    } else {
      emit(const LaborsAndPartsState.success());
    }
  }

  Future<String> _getActiveServiceRequest() async {
    String resultMessage = '';
    final result = await _getActiveServiceRequestUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _activeServiceRequestSubject.value = data;
          resultMessage = 'Success';
        } else {

          resultMessage = failures?.listToString() ?? '';
        }
      },
      failure: (NetworkExceptions error, msg) {
        resultMessage = msg ?? '';
      },
    );
    return resultMessage;
  }

  Future<String> _getLastEvaluation() async {
    String resultMessage = '';
    final result = await _getLastEvaluationUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _lastEvaluationSubject.value= data;
          resultMessage = 'Success';
        } else {
          resultMessage = failures?.listToString() ?? '';
        }
      },
      failure: (NetworkExceptions error, msg) {
        resultMessage = msg ?? '';
      },
    );
    return resultMessage;
  }

  void selectLabor({LaborResponseEntity? entity}) {
    selectLaborResponseEntity = entity;
    if(selectLaborResponseEntity?.allowableCostCenterList?.isNotEmpty ?? false) {
      (selectLaborResponseEntity?.allowableCostCenterList?[0].id == 0) ?
      _priceLaborSubject.add(selectLaborResponseEntity?.customerPrice.toString() ?? '0'):
      _priceLaborSubject.add(entity?.companyPrice.toString() ?? '0');
      selectLaborCostCenterEntity = selectLaborResponseEntity?.allowableCostCenterList?[0];
    } else {
      _priceLaborSubject.add('0');
    }
  }

  Future<void> selectPart({PartResponseEntity? partResponseEntity, EvaluationPartResponseEntity? evaluationPartEntity, bool? isEditablePart}) async{
    emit(const LaborsAndPartsState.loading());
    final activeServiceRequestResult = await _getActiveServiceRequest();
    if(activeServiceRequestResult != 'Success') {
      return emit(LaborsAndPartsState.error(dialogDataModel: DialogDataModel(title: '', description: activeServiceRequestResult)));
    }
    final lastEvaluationResult = await _getLastEvaluation();
    if(lastEvaluationResult != 'Success') {
      return emit(LaborsAndPartsState.error(dialogDataModel: DialogDataModel(title: '', description: lastEvaluationResult)));
    }
    if(isEditablePart ?? false) {
      selectPartResponseEntity = PartResponseEntity(
        name: evaluationPartEntity?.partName ?? '',
        serial: evaluationPartEntity?.serial.toString(),
        partGroupId: evaluationPartEntity?.partGroupId,
        partGroupName: evaluationPartEntity?.partGroupName,
        allowableCostCenterList: [evaluationPartEntity?.costCenterObject ?? CostCenterEntity()],
        mark: evaluationPartEntity?.mark,
        garantyDurationDayKilometer: evaluationPartEntity?.garantyDurationDayKilometer,
        garantyKilometerKilometer: evaluationPartEntity?.garantyKilometerKilometer,
      );
      selectPartCostCenterEntity = evaluationPartEntity?.costCenterObject ?? CostCenterEntity();
    } else {
      selectPartResponseEntity = partResponseEntity;
      if(selectPartResponseEntity?.allowableCostCenterList?.isNotEmpty ?? false) {
        selectPartCostCenterEntity = selectPartResponseEntity?.allowableCostCenterList?.first;
      }
    }
    final partMarkResult = await _getPartMark();
    if(partMarkResult == 'Success') {
      return emit(const LaborsAndPartsState.success());
    } else {
      return emit(LaborsAndPartsState.error(dialogDataModel: DialogDataModel(title: '', description: partMarkResult)));
    }
  }

  Future<void> getLabors({required String value, required int serviceIndex})async{
    emit(const LaborsAndPartsState.loading());
    final evaluationService = HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex];
    final laborRequestEntity = LaborRequestEntity(
    serviceType: 2,
    searchText: value,
    serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
    kilometer: _lastEvaluationSubject.valueOrNull?.customerKilometer,
    hasGaranty: evaluationService?.hasGaranty,
    guarantyStartDate: evaluationService?.garantyStartDate,
    hasSubscription: evaluationService?.hasSubscription,
    workOrderCode: evaluationService?.defectInfoProblemOrEzharCode,
    emdadProductId: evaluationService?.productId,
    emdadServiceId: evaluationService?.serviceId,
    );
    final result = await _getLaborUseCase.call(laborRequestEntity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _laborResponseListSubject.add(data);
          emit(const LaborsAndPartsState.success());
        } else {
          emit(LaborsAndPartsState.error(dialogDataModel: DialogDataModel(title: 'خطا', description: failures?.listToString() ?? 'بروز خطا در سیستم')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(LaborsAndPartsState.error(
            dialogDataModel: DialogDataModel(title: 'خطا', description: msg ?? 'بروز خطا در سیستم')));
      },
    );
  }

  Future<void> getPart({required String value, required int laborIndex, required int serviceIndex})async{
    emit(const LaborsAndPartsState.loading());
    final evaluationService = HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex];
    final partRequestEntity = PartRequestEntity(
      serviceType: 2,
      serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
      searchText: value,
      laborId: evaluationService?.evaluationLabors?[laborIndex].laborId,
      laborGroupId: evaluationService?.evaluationLabors?[laborIndex].laborGroupId,
      guarantyStartDate: evaluationService?.garantyStartDate,
      hasGaranty: evaluationService?.hasGaranty,
      hasSubscription: evaluationService?.hasSubscription,
      kilometer: _lastEvaluationSubject.valueOrNull?.customerKilometer,
      emdadProductId: evaluationService?.productId,
      emdadServiceId: evaluationService?.serviceId,
      workOrderCode: evaluationService?.serviceCode
    );
    final result = await _getPartUseCase.call(partRequestEntity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _partResponseListSubject.add(data);
          emit(const LaborsAndPartsState.success());
        } else {
          emit(LaborsAndPartsState.error(dialogDataModel: DialogDataModel(title: 'خطا', description: failures?.listToString() ?? 'بروز خطا در سیستم')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(LaborsAndPartsState.error(
            dialogDataModel: DialogDataModel(title: 'خطا', description: msg ?? 'بروز خطا در سیستم')));
      },
    );
  }

  Future<void> getCustomerPart({required String value, required int laborIndex, required int serviceIndex})async{
    emit(const LaborsAndPartsState.loading());
    final evaluationService = HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex];
    final partRequestEntity = PartRequestEntity(
        serviceType: 2,
        serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
        searchText: value,
        laborId: evaluationService?.evaluationLabors?[laborIndex].laborId,
        laborGroupId: evaluationService?.evaluationLabors?[laborIndex].laborGroupId,
        guarantyStartDate: evaluationService?.garantyStartDate,
        hasGaranty: evaluationService?.hasGaranty,
        hasSubscription: evaluationService?.hasSubscription,
        kilometer: _lastEvaluationSubject.valueOrNull?.customerKilometer,
        emdadProductId: evaluationService?.productId,
        emdadServiceId: evaluationService?.serviceId,
        workOrderCode: evaluationService?.serviceCode
    );
    final result = await _getPartUseCase.call(partRequestEntity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _partResponseListSubject.add(data);
          emit(const LaborsAndPartsState.success());
        } else {
          emit(LaborsAndPartsState.error(dialogDataModel: DialogDataModel(title: 'خطا', description: failures?.listToString() ?? 'بروز خطا در سیستم')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(LaborsAndPartsState.error(
            dialogDataModel: DialogDataModel(title: 'خطا', description: msg ?? 'بروز خطا در سیستم')));
      },
    );
  }

  Future<void> submitCustomerPart({required int serviceIndex, required int laborIndex, required int partIndex, bool? isEditablePart}) async{
    emit(const LaborsAndPartsState.submitLoading());
    if(selectPartResponseEntity?.mark == 'لطفا یک گزینه را انتخاب کنید') {
      emit(LaborsAndPartsState.notice(
          dialogDataModel: DialogDataModel(title: '', description: 'انتخاب مارک اجباری می باشد')));
      return;
    }
    if(isEditablePart ?? false) {
      final partsEvaluation = HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex].evaluationLabors?[laborIndex].parts;
      final partSelected = partsEvaluation?[partIndex];
      partSelected?.mark = selectPartResponseEntity?.mark;
      partSelected?.partPrice = int.tryParse(priceController.text);
      partSelected?.count = int.tryParse(countController.text);
      emit(const LaborsAndPartsState.submitEditPartMarkSuccess());
    }else {
      print(HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex].evaluationLabors?[laborIndex].parts?[partIndex].partGroupName);
      HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex].evaluationLabors?[laborIndex].parts?[partIndex] = EvaluationPartResponseModel(
        mark: selectPartResponseEntity?.mark,
        partPrice: int.tryParse(priceController.text),
        partGroupId: selectPartResponseEntity?.partGroupId,
        partGroupName: selectPartResponseEntity?.partGroupName,
        partName: selectPartResponseEntity?.name,
        laborCode: HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex].evaluationLabors?[laborIndex].laborCode,
        laborName: HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex].evaluationLabors?[laborIndex].laborName,
        laborId: HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex].evaluationLabors?[laborIndex].laborId,
        costCenterObject: selectPartCostCenterEntity,
        count: int.tryParse(countController.text),
        costCenterList: selectPartResponseEntity?.allowableCostCenterList,
        reusablePartName: _reusableSubject.valueOrNull?.name,
        reusablePartSerial: _reusableSubject.valueOrNull?.serial,
        reusablePrice: _reusableSubject.valueOrNull?.price,
        garantyKilometerKilometer: selectPartResponseEntity?.garantyKilometerKilometer,
        garantyDurationDayKilometer: selectPartResponseEntity?.garantyDurationDayKilometer,
        isReusable: _reusableSubject.valueOrNull?.hasReusable,
        serial: int.tryParse(selectPartResponseEntity?.serial ?? '0'),
      );
      emit(const LaborsAndPartsState.submitAddPartMarkSuccess());
      print('555555555555555');
    }
  }

  Future<String> _getPartMark() async {
    String resultMessage = '';
    PartMarkRequestEntity entity = PartMarkRequestEntity(
      serial: selectPartResponseEntity?.serial,
      serviceRequestId: _activeServiceRequestSubject.valueOrNull?.id,
      defectId: _activeServiceRequestSubject.valueOrNull?.defectId,
      partGroupId: selectPartResponseEntity?.partGroupId,
      serviceType: 2
    );
    final result = await _getPartMarkHomeServiceUseCase.call(entity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        markList.clear();
        markList.add(const PartMarkResponseEntity(mark: 'لطفا یک گزینه را انتخاب کنید'));
        if (resultCode == 0) {
          markList.addAll(data);
          selectPartResponseEntity = selectPartResponseEntity?.copyWith(mark: markList.first?.mark);
          resultMessage = 'Success';
        }else {
          resultMessage = failures?.listToString() ?? '';
        }
      },
      failure: (NetworkExceptions error, msg) {
        resultMessage = msg ??'خطای غیر منتظره با پشتیبانی تماس بگیرید';
      },
    );
    return resultMessage;
  }

  Future<void> getPartPrice({String? mark}) async {
    emit(const LaborsAndPartsState.partPriceLoading());
    selectPartResponseEntity?.mark = mark;
    final result = await _getPartPriceHomeServiceUseCase.call(PartPriceRequestEntity(
      mark: mark,
      serviceType: 2,
      serial: selectPartResponseEntity?.serial
    ));
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          maxPartPrice = data?.price.toString();
          _reusableSubject.add(
              ReusableEntity(
            hasReusable: data?.hasReusable ?? false,
            isActive: data?.hasReusable ?? false,
            name: '',
            price: -1,
          ),
          );
          if(mark == '500') {
            priceController.text = '';
          }else {
            priceController.text = data?.price.toString() ?? '-';
            _pricePartSubject.add(priceController.text);
          }
          emit(const LaborsAndPartsState.partPriceSuccess());
      } else {
          emit(LaborsAndPartsState.error(
              dialogDataModel:
              DialogDataModel(title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(LaborsAndPartsState.error(
            dialogDataModel:
            DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<void> getReusablePrice({String? serial, String? name}) async {
    emit(const LaborsAndPartsState.reusablePriceLoading());
    final result = await _getReusablePriceUseCase.call(
      PartPriceRequestEntity(
        serial: serial ?? '',
        serviceType: 2
      )
    );
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          reusablePriceController.text = data?.reusablePrice.toString() ?? '-';
          reusableTitleController.text = name ?? '';
          reusableSubject.add(ReusableEntity(
            name: name,
            price: data?.reusablePrice,
            isActive: true,
            hasReusable: true,
            serial: serial
          ));
          emit(const LaborsAndPartsState.reusablePriceSuccess());
        } else {
          emit(LaborsAndPartsState.error(
              dialogDataModel: DialogDataModel(
                  title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(LaborsAndPartsState.error(
            dialogDataModel:
            DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<void> submitPart({required int serviceIndex, required int laborIndex, required int partIndex, bool? isEditablePart}) async{
    emit(const LaborsAndPartsState.submitLoading());
    if(selectPartResponseEntity?.mark == 'لطفا یک گزینه را انتخاب کنید') {
      emit(LaborsAndPartsState.notice(
          dialogDataModel: DialogDataModel(title: '', description: 'انتخاب مارک اجباری می باشد')));
      return;
    }
    if(isEditablePart ?? false) {
      final partsEvaluation = HomeServiceEvaluationSecondStepCubit.customerServiceList?[serviceIndex].evaluationLabors?[laborIndex].parts;
      final partSelected = partsEvaluation?[partIndex];
      partSelected?.mark = selectPartResponseEntity?.mark;
      partSelected?.partPrice = int.tryParse(priceController.text);
      partSelected?.count = int.tryParse(countController.text);
      emit(const LaborsAndPartsState.submitEditPartMarkSuccess());
    }else {
      HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex].evaluationLabors?[laborIndex].parts?.add(
          EvaluationPartResponseEntity(
            mark: selectPartResponseEntity?.mark,
            partPrice: int.tryParse(priceController.text),
            partGroupId: selectPartResponseEntity?.partGroupId,
            partGroupName: selectPartResponseEntity?.partGroupName,
            partName: selectPartResponseEntity?.name,
            laborCode: HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex].evaluationLabors?[laborIndex].laborCode,
            laborName: HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex].evaluationLabors?[laborIndex].laborName,
            laborId: HomeServiceEvaluationSecondStepCubit.selectedServiceList?[serviceIndex].evaluationLabors?[laborIndex].laborId,
            costCenterObject: selectPartCostCenterEntity,
            count: int.tryParse(countController.text),
            costCenterList: selectPartResponseEntity?.allowableCostCenterList,
            reusablePartName: _reusableSubject.valueOrNull?.name,
            reusablePartSerial: _reusableSubject.valueOrNull?.serial,
            reusablePrice: _reusableSubject.valueOrNull?.price,
            garantyKilometerKilometer: selectPartResponseEntity?.garantyKilometerKilometer,
            garantyDurationDayKilometer: selectPartResponseEntity?.garantyDurationDayKilometer,
            isReusable: _reusableSubject.valueOrNull?.hasReusable,
            serial: int.tryParse(selectPartResponseEntity?.serial ?? '0'),
          ),
      );
      emit(const LaborsAndPartsState.submitAddPartMarkSuccess());
    }
  }
}
