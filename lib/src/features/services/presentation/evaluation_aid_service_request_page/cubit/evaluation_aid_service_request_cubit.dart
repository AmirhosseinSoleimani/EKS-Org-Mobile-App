import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/RepresentationParamEntity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/last_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/representation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_categories_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_defects_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_labor_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_last_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_mark_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_price_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_representation_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_service_detail_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/submit_evaluation_for_aid_service_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/builders/aid_service_evaluation_submit_param_builder.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/controllers/evaluation_labor_part_context.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/controllers/evaluation_labor_part_controller.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/cubit/evaluation_transport_Information_form_controller.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/enums/add_part_and_labor_sheet_mode.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../evaluation/domain/entities/defect_entity.dart';
import 'evaluation_main_form_controller.dart';

part 'evaluation_aid_service_request_cubit.freezed.dart';
part 'evaluation_aid_service_request_state.dart';

@injectable

class EvaluationAidServiceRequestCubit extends Cubit<EvaluationAidServiceRequestState> {
  EvaluationAidServiceRequestCubit(this._fetchSelectedRequestItemUseCase,
      this._getReliefRequestByIdUseCase,
      this._getEmdadgarInfoUseCase,
      this._getCategoriesListUseCase,
      this._getPartListUseCase,
      this._getPartMarkListUseCase,
      this._getPartPriceUseCase,
      this._getDefectsListUseCase,
      this._getServiceDetailEvaluationUseCase,
      this._getLastEvaluationUseCase,
      this._getLaborListUseCase,
      this._submitEvaluationForAidServiceUseCase,
      this._getRepresentationListUseCase,)
      : super(const EvaluationAidServiceRequestState.idle()) {
    laborPart = EvaluationLaborPartController(
      getLaborListUseCase: _getLaborListUseCase,
      getPartListUseCase: _getPartListUseCase,
      getPartMarkListUseCase: _getPartMarkListUseCase,
      getPartPriceUseCase: _getPartPriceUseCase,
      readContext: () =>
          EvaluationLaborPartContext(
            selectedRequest: selectedRequest,
            emdadgarServiceDetailEntity: emdadgarServiceDetailEntity,
            lastEvaluationEntity: lastEvaluationEntity,
            customerKilometerText: mainForm.kilometerController.text,
          ),
      onError: _emitError,
      onConnectionError: () =>
          _safeEmit(
            const EvaluationAidServiceRequestState.connectionError(),
          ),
    );
  }

  late final EvaluationLaborPartController laborPart;

  final FetchSelectedRequestItemUseCase _fetchSelectedRequestItemUseCase;
  final GetReliefRequestByIdUseCase _getReliefRequestByIdUseCase;
  final GetEmdadgarInfoUseCase _getEmdadgarInfoUseCase;
  final GetCategoriesListUseCase _getCategoriesListUseCase;
  final GetLaborListUseCase _getLaborListUseCase;
  final GetPartListUseCase _getPartListUseCase;
  final GetPartMarkListUseCase _getPartMarkListUseCase;
  final GetPartPriceUseCase _getPartPriceUseCase;
  final GetDefectsListUseCase _getDefectsListUseCase;
  final GetServiceDetailEvaluationUseCase _getServiceDetailEvaluationUseCase;
  final GetLastEvaluationUseCase _getLastEvaluationUseCase;
  final SubmitEvaluationForAidServiceUseCase
  _submitEvaluationForAidServiceUseCase;
  final GetRepresentationListUseCase _getRepresentationListUseCase;

  String? _errorMessage;
  ReliefRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  ResponseLastEvaluationEntity? lastEvaluationEntity;
  EmdadgarServiceDetailEntity? emdadgarServiceDetailEntity;

  final mainForm = EvaluationMainFormController();

  final transportForm =
  EvaluationTransportInformationFormController<RepresentationEntity>();

  List<DefectEntity> defectList = <DefectEntity>[];
  final selectedDefect = ValueNotifier<DefectEntity?>(null);

  final List<ServiceCategoryEntity> serviceCategoryList = [];
  final selectedServiceCategory = ValueNotifier<ServiceCategoryEntity?>(null);

  VoidCallback? _retryAction;

  AddPartAndLaborSheetMode get addPartAndLaborSheetMode => laborPart.mode;

  EvaluationSelectedLaborEntity? get editingOriginalLabor =>
      laborPart.editingOriginalLabor;

  ValueNotifier<Set<int>> get expandedLaborPartListIdsNotifier =>
      laborPart.expandedLaborPartListIdsNotifier;

  TextEditingController get laborSearchController =>
      laborPart.laborSearchController;

  TextEditingController get laborPriceController =>
      laborPart.laborPriceController;

  TextEditingController get partSearchController =>
      laborPart.partSearchController;

  TextEditingController get partPriceController =>
      laborPart.partPriceController;

  TextEditingController get partCountController =>
      laborPart.partCountController;

  ValueNotifier<LaborEntity?> get selectedLabor => laborPart.selectedLabor;

  ValueNotifier<AllowableCostCenterEntity?> get selectedLaborCostCenter =>
      laborPart.selectedLaborCostCenter;

  ValueNotifier<PartEntity?> get selectedPart => laborPart.selectedPart;

  ValueNotifier<AllowableCostCenterEntity?> get selectedPartCostCenter =>
      laborPart.selectedPartCostCenter;

  ValueNotifier<PartMarkEntity?> get selectedPartMark =>
      laborPart.selectedPartMark;

  ValueNotifier<List<LaborEntity>> get laborListNotifier =>
      laborPart.laborListNotifier;

  ValueNotifier<bool> get isLaborLoading => laborPart.isLaborLoading;

  ValueNotifier<
      List<AllowableCostCenterEntity>> get laborCostCenterListNotifier =>
      laborPart.laborCostCenterListNotifier;

  ValueNotifier<List<PartEntity>> get partListNotifier =>
      laborPart.partListNotifier;

  ValueNotifier<bool> get isPartLoading => laborPart.isPartLoading;

  ValueNotifier<
      List<AllowableCostCenterEntity>> get partCostCenterListNotifier =>
      laborPart.partCostCenterListNotifier;

  ValueNotifier<List<PartMarkEntity>> get partMarkListNotifier =>
      laborPart.partMarkListNotifier;

  ValueNotifier<List<EvaluationSelectedPartEntity>> get selectedPartsNotifier =>
      laborPart.selectedPartsNotifier;

  ValueNotifier<
      List<EvaluationSelectedLaborEntity>> get selectedLaborsNotifier =>
      laborPart.selectedLaborsNotifier;

  ValueNotifier<bool> get isPartMarkLoading => laborPart.isPartMarkLoading;

  ValueNotifier<bool> get isPartPriceLoading => laborPart.isPartPriceLoading;

  bool get hasSelectedParts => laborPart.hasSelectedParts;

  bool get hasSelectedLabors => laborPart.hasSelectedLabors;

  List<EvaluationSelectedLaborEntity> get selectedLabors =>
      laborPart.selectedLabors;

  void prepareCreateLaborAndPartSheet() => laborPart.prepareCreateSheet();

  void onLaborSearchChanged(String query) =>
      laborPart.onLaborSearchChanged(query);

  bool saveLaborAndPartsFromSheet() => laborPart.saveLaborAndPartsFromSheet();

  void selectLabor(LaborEntity item) => laborPart.selectLabor(item);

  void selectLaborCostCenter(AllowableCostCenterEntity item) =>
      laborPart.selectLaborCostCenter(item);

  void onPartSearchChanged(String query) =>
      laborPart.onPartSearchChanged(query);

  Future<void> selectPart(PartEntity item) => laborPart.selectPart(item);

  void selectPartCostCenter(AllowableCostCenterEntity item) =>
      laborPart.selectPartCostCenter(item);

  Future<void> selectPartMark(PartMarkEntity item) =>
      laborPart.selectPartMark(item);

  bool addAnotherPart() => laborPart.addAnotherPart();

  void removeSelectedPartAt(int index) => laborPart.removeSelectedPartAt(index);

  void removeSelectedLabor(EvaluationSelectedLaborEntity labor) =>
      laborPart.removeSelectedLabor(labor);

  Future<bool> editSelectedLabor(EvaluationSelectedLaborEntity labor) =>
      laborPart.editSelectedLabor(labor);

  Future<bool> addPartToSelectedLabor(EvaluationSelectedLaborEntity labor) =>
      laborPart.addPartToSelectedLabor(labor);

  void removePartFromSelectedLabor(
      {required int laborIndex, required int partIndex}) =>
      laborPart.removePartFromSelectedLabor(
          laborIndex: laborIndex, partIndex: partIndex);

  void toggleSelectedLaborPartsVisibility(
      EvaluationSelectedLaborEntity labor) =>
      laborPart.toggleSelectedLaborPartsVisibility(labor);


  Future<void> getRepresentationList() async {
    transportForm.setRepresentationLoading(true);
    final param =  RepresentationParamEntity();
    final result = await _getRepresentationListUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        transportForm.setRepresentationList(data);

        transportForm.syncSelectedRepresentationByValue(
          lastEvaluationEntity?.lastEvaluation,
        );
      },
      failure: (error, failures) {
        transportForm.clearRepresentationList();

        _errorMessage = _fallbackError(failures ?? error.toString());
        _emitError(_errorMessage);
      },
      connectionError: () {
        transportForm.clearRepresentationList();

        _safeEmit(
          const EvaluationAidServiceRequestState.connectionError(),
        );
      },
    );

    transportForm.setRepresentationLoading(false);
  }

  void fillTransportFormFromLastEvaluation() {
    final lastEvaluation = lastEvaluationEntity?.lastEvaluation;

    if (lastEvaluation == null) return;

    transportForm.fillFromLastEvaluation(
      acceptanceCode: lastEvaluation.acceptanceCode,
      transportDistanceKm: lastEvaluation.distanceHamlCustomer,
      endWorkDate: transportForm.formattedEndWorkDateTimeForServer,
      representationValue: lastEvaluation.id,
    );
  }


  Future<void> init() async {
    _retryAction = init;
    final result = await _initializeData();

    switch (result) {
      case FetchResultType.success:
        _safeEmit(const EvaluationAidServiceRequestState.loaded());
        break;

      case FetchResultType.failure:
        _emitError();
        break;

      case FetchResultType.connectionError:
        _safeEmit(const EvaluationAidServiceRequestState.connectionError());
        break;

      case FetchResultType.expireToken:
        _emitError('نشست شما منقضی شده است. لطفا دوباره وارد شوید');
        break;
    }
  }

  Future<FetchResultType> _initializeData() async {
    final selectedResult = await _fetchSelectedRequest();
    if (selectedResult != FetchResultType.success) return selectedResult;

    _safeEmit(const EvaluationAidServiceRequestState.loading());

    final requestResult = await _fetchServiceRequestData();
    if (requestResult != FetchResultType.success) {
      return requestResult;
    }

    final emdadgarResult = await _fetchEmdadgarInfo();
    if (emdadgarResult != FetchResultType.success) {
      return emdadgarResult;
    }

    final defectListResult = await _getDefectList();
    if (defectListResult != FetchResultType.success) {
      return defectListResult;
    }

    final categoryListResult = await getCategoryList();
    if (categoryListResult != FetchResultType.success) {
      return categoryListResult;
    }

    final lastEvaluationResult = await getLastEvaluation();
    if (lastEvaluationResult != FetchResultType.success) {
      return lastEvaluationResult;
    }

    final serviceDetailResult = await getServiceDetailEvaluation();
    if (serviceDetailResult != FetchResultType.success) {
      return serviceDetailResult;
    }

    return FetchResultType.success;
  }

  Future<FetchResultType> _fetchSelectedRequest() async {
    try {
      final request = await _fetchSelectedRequestItemUseCase.call();
      if (request is ReliefRequestEntity) {
        selectedRequest = request;
        return FetchResultType.success;
      }
      return FetchResultType.failure;
    } catch (_) {
      _errorMessage = _fallbackError();
      return FetchResultType.failure;
    }
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

  Future<FetchResultType> _getDefectList() async {
    final result = await _getDefectsListUseCase(selectedRequest?.id);
    late FetchResultType fetchResult;

    result.when(
      success: (data, _, _) {
        defectList.clear();
        defectList.addAll(data);
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

  Future<FetchResultType> _fetchServiceRequestData() async {
    final id = selectedRequest?.id ?? 0;

    final result = await _getReliefRequestByIdUseCase(id);

    FetchResultType fetchResult = FetchResultType.failure;

    result.whenOrNull(
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
    );
    return fetchResult;
  }


  Future<void> submitEvaluationForAidService() async {
    if (!laborPart.hasSelectedLabors) {
      _emitError('حداقل یک اجرت باید انتخاب شود');
      return;
    }

    _safeEmit(const EvaluationAidServiceRequestState.submitLoading());

    final param = AidServiceEvaluationSubmitParamBuilder.build(
      selectedRequest: selectedRequest,
      emdadgarInfo: emdadgarInfo,
      lastEvaluationEntity: lastEvaluationEntity,
      emdadgarServiceDetailEntity: emdadgarServiceDetailEntity,
      selectedServiceCategory: selectedServiceCategory.value,
      mainForm: mainForm,
      transportForm: transportForm,
      selectedLabors: laborPart.selectedLabors,
      selectedDefect: selectedDefect.value,
    );

    final result = await _submitEvaluationForAidServiceUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        _safeEmit(const EvaluationAidServiceRequestState.submitSuccess());
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
        _emitError(_errorMessage);
      },
      connectionError: () {
        _safeEmit(const EvaluationAidServiceRequestState.connectionError());
      },
    );
  }

  bool isBottomSheetOpen = false;

  void markBottomSheetOpen() {
    isBottomSheetOpen = true;
  }

  void markBottomSheetClosed() {
    isBottomSheetOpen = false;
  }

  Future<void> selectDefect(DefectEntity defect) async {
    _retryAction = () => selectDefect(defect);

    selectedDefect.value = defect;

    await _getServiceDetailAndHandleResult();
  }

  Future<void> setSelectedServiceCategory(
      ServiceCategoryEntity category,) async {
    _retryAction = () => setSelectedServiceCategory(category);

    selectedServiceCategory.value = category;

    await _getServiceDetailAndHandleResult();
  }

  Future<bool> _getServiceDetailAndHandleResult() async {
    final result = await getServiceDetailEvaluation();

    if (result == FetchResultType.success) {
      return true;
    }

    if (result == FetchResultType.connectionError) {
      _safeEmit(const EvaluationAidServiceRequestState.connectionError());
      return false;
    }

    _emitError(_errorMessage);
    return false;
  }

  Future<FetchResultType> getCategoryList() async {
    _retryAction = getCategoryList;

    final param = CategoryParamEntity(serviceType: ServiceType.reliefService,
        planningId: selectedRequest?.planningId ?? 0);
    final result = await _getCategoriesListUseCase(param);


    late FetchResultType fetchResult = FetchResultType.failure;
    result.whenOrNull(
      success: (data, _, _) {
        serviceCategoryList.clear();
        serviceCategoryList.addAll(data);
        fetchResult = FetchResultType.success;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
      },
    );

    return fetchResult;
  }

  Future<FetchResultType> getLastEvaluation() async {
    _retryAction = getLastEvaluation;

    final param = LastEvaluationParamEntity(
      serviceType: ServiceType.reliefService,
      emdadgarId: emdadgarInfo?.id,
      serviceRequestId: selectedRequest?.id ?? 0,
    );
    final result = await _getLastEvaluationUseCase(param);

    late FetchResultType fetchResult = FetchResultType.failure;
    result.whenOrNull(
      success: (data, _, _) {
        lastEvaluationEntity = data;
        mainForm.fillFromLastEvaluation(data.lastEvaluation);
        fetchResult = FetchResultType.success;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
      },
    );

    return fetchResult;
  }
  Future<FetchResultType> getServiceDetailEvaluation() async {
    _retryAction = getServiceDetailEvaluation;

    final param = ServiceDetailForEvaluationParamEntity(
      serviceType: ServiceType.reliefService,
      aidServiceRequestId: selectedRequest?.id,
      emdadgarDefectInfoId:
      selectedDefect.value?.id ?? selectedRequest?.defectId ?? 0,
      emdadgarServiceCategoryId:
      selectedServiceCategory.value?.id ??
          selectedRequest?.emdadServiceCategoryId ??
          0,
      serviceRequestId: selectedRequest?.id ?? 0,
      evaluationCustomerKilometer:
      lastEvaluationEntity?.lastEvaluation?.customerKilometer,
    );

    final result = await _getServiceDetailEvaluationUseCase(param);

    late FetchResultType fetchResult = FetchResultType.failure;
    result.whenOrNull(
      success: (data, _, _) {
        emdadgarServiceDetailEntity = data;
        mainForm.setServiceTitle(data.serviceTitle);
        fetchResult = FetchResultType.success;
      },
      connectionError: () {
        fetchResult = FetchResultType.connectionError;
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
      },
    );

    return fetchResult;
  }

  void _safeEmit(EvaluationAidServiceRequestState state) {
    if (!isClosed) emit(state);
  }

  void _emitError([String? message]) {
    _safeEmit(
      EvaluationAidServiceRequestState.error(
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

  @override
  Future<void> close() {
    laborPart.dispose();
    mainForm.dispose();
    transportForm.dispose();
    selectedDefect.dispose();
    selectedServiceCategory.dispose();
    return super.close();
  }
}
