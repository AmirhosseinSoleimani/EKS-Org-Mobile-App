import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/labor_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/last_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_marks_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_price_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_categories_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_defects_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_labor_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_last_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_mark_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_price_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_service_detail_evaluation_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../evaluation/domain/entities/defect_entity.dart';
import 'evaluation_initial_form_controller.dart';

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
      this._getLaborListUseCase,)
      : super(const EvaluationAidServiceRequestState.idle());

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

  String? _errorMessage;
  ReliefRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  ResponseLastEvaluationEntity? lastEvaluationEntity;
  EmdadgarServiceDetailEntity? emdadgarServiceDetailEntity;

  final form = EvaluationInitialFormController();


  List<DefectEntity> defectList = <DefectEntity>[];
  final selectedDefect = ValueNotifier<DefectEntity?>(null);

  final List<ServiceCategoryEntity> serviceCategoryList = [];
  final selectedServiceCategory = ValueNotifier<ServiceCategoryEntity?>(null);

  VoidCallback? _retryAction;

  Timer? _laborSearchDebounce;
  Timer? _partSearchDebounce;

  final laborSearchController = TextEditingController();
  final laborPriceController = TextEditingController();

  final partSearchController = TextEditingController();
  final partPriceController = TextEditingController();
  final partCountController = TextEditingController(text: '1');

  final selectedLabor = ValueNotifier<LaborEntity?>(null);
  final selectedLaborCostCenter = ValueNotifier<AllowableCostCenterEntity?>(
      null);

  final selectedPart = ValueNotifier<PartEntity?>(null);
  final selectedPartCostCenter = ValueNotifier<AllowableCostCenterEntity?>(
      null);
  final selectedPartMark = ValueNotifier<PartMarkEntity?>(null);

  final List<LaborEntity> laborList = [];
  List<AllowableCostCenterEntity> laborCostCenterList = [];

  List<PartEntity> partList = [];
  List<AllowableCostCenterEntity> partCostCenterList = [];
  List<PartMarkEntity> partMarkList = [];

  final List<PartEntity> selectedParts = [];

  bool get hasSelectedParts => selectedParts.isNotEmpty;

  final isLaborLoading = ValueNotifier<bool>(false);
  final isPartLoading = ValueNotifier<bool>(false);
  final isPartMarkLoading = ValueNotifier<bool>(false);
  final isPartPriceLoading = ValueNotifier<bool>(false);

  void onLaborSearchChanged(String query) {
    _laborSearchDebounce?.cancel();

    final trimmedQuery = query.trim();

    if (trimmedQuery.length < 3) {
      laborList.clear();
      isLaborLoading.value = false;
      return;
    }

    _laborSearchDebounce = Timer(
      const Duration(seconds: 1),
          () => _searchLabors(trimmedQuery),
    );
  }

  Future<void> _searchLabors(String query) async {
    isLaborLoading.value = true;

    final param = LaborListParamEntity(serviceType: ServiceType.reliefService,
        defectId: selectedRequest?.defectId ?? 0,
        serviceRequestId: selectedRequest?.id,
        hasSubscription: emdadgarServiceDetailEntity?.hasSubscription,
        kilometer: lastEvaluationEntity?.lastEvaluation?.customerKilometer,
        emdadServiceId: emdadgarServiceDetailEntity?.serviceId,
        hasGaranty: emdadgarServiceDetailEntity?.hasGaranty,
        searchText: query,
        workOrderCode: emdadgarServiceDetailEntity?.defectInfoProblemOrEzharCode
    );
    final result = await _getLaborListUseCase(param);
    result.whenOrNull(
      success: (data, failures, resultCode) {
        laborList.clear();
        laborList.addAll(data);
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
        _emitError(_errorMessage);
      },
      connectionError: () =>
          _safeEmit(const EvaluationAidServiceRequestState.connectionError()),
    );
    isLaborLoading.value = false;
  }

  void selectLabor(LaborEntity item) {
    selectedLabor.value = item;
    laborSearchController.text = item.label;

    laborCostCenterList = item.allowableCostCenterList ?? [];
    selectedLaborCostCenter.value = _findDefaultCostCenter(laborCostCenterList);
    _setLaborPriceByCostCenter();
  }

  void _setLaborPriceByCostCenter() {
    final labor = selectedLabor.value;
    final costCenter = selectedLaborCostCenter.value;

    if (labor == null || costCenter == null) {
      laborPriceController.clear();
      return;
    }

    final price = _resolveLaborPrice(
      labor: labor,
      costCenter: costCenter,
    );

    laborPriceController.text = _formatPrice(price);
  }

  String _resolveLaborPrice({
    required LaborEntity labor,
    required AllowableCostCenterEntity costCenter,
  }) {
    switch (costCenter.code) {
      case 'Company':
      case 'Garanty':
        return labor.companyPrice ?? '0';

      case 'Customer':
      default:
        return labor.customerPrice ?? '0';
    }
  }

  void onPartSearchChanged(String query) {
    _partSearchDebounce?.cancel();

    final trimmedQuery = query.trim();

    if (trimmedQuery.length < 3) {
      partList = [];
      isPartLoading.value = false;
      return;
    }

    _partSearchDebounce = Timer(
      const Duration(seconds: 1),
          () => _searchParts(trimmedQuery),
    );
  }

  Future<void> _searchParts(String query) async {
    isPartLoading.value = true;

    final param = PartListParamEntity(
      serviceType: ServiceType.reliefService,
      defectId: selectedRequest?.defectId ?? 0,
      serviceRequestId: selectedRequest?.id,
      hasSubscription: emdadgarServiceDetailEntity?.hasSubscription,
      kilometer: lastEvaluationEntity?.lastEvaluation?.customerKilometer,
      emdadServiceId: emdadgarServiceDetailEntity?.serviceId,
      hasGaranty: emdadgarServiceDetailEntity?.hasGaranty,
      searchText: query,
      workOrderCode: emdadgarServiceDetailEntity?.defectInfoProblemOrEzharCode,
      laborGroupId: selectedLabor.value?.laborGroupId,
      laborId: selectedLabor.value?.id,
    );
    final result = await _getPartListUseCase(param);
    result.whenOrNull(
      success: (data, failures, resultCode) {
        partList.clear();
        partList.addAll(data);
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
        _emitError(_errorMessage);
      },
      connectionError: () =>
          _safeEmit(const EvaluationAidServiceRequestState.connectionError()),
    );

    isPartLoading.value = false;
  }

  Future<void> selectPart(PartEntity item) async {
    selectedPart.value = item;
    partSearchController.text = item.label;

    partCostCenterList = item.allowableCostCenterList ?? [];
    selectedPartCostCenter.value = _findDefaultCostCenter(partCostCenterList);

    partMarkList = [];
    selectedPartMark.value = null;
    partPriceController.clear();

    await _getPartMarks(item);
  }

  void selectPartCostCenter(AllowableCostCenterEntity item) {
    selectedPartCostCenter.value = item;
  }

  Future<void> _getPartMarks(PartEntity part) async {
    isPartMarkLoading.value = true;
    final param = PartMarksParamEntity(
      serviceType: ServiceType.reliefService,
      serviceRequestId: selectedRequest?.id,
      defectId: selectedRequest?.defectId ?? 0,
      serial: selectedPart.value?.serial ?? '',
      partGroupId: selectedPart.value?.partGroupId ?? 0,
    );
    final result = await _getPartMarkListUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        partMarkList.clear();
        partMarkList.addAll(data);
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
        _emitError(_errorMessage);
      },
      connectionError: () =>
          _safeEmit(const EvaluationAidServiceRequestState.connectionError()),
    );
    isPartMarkLoading.value = false;
  }

  Future<void> selectPartMark(PartMarkEntity item) async {
    selectedPartMark.value = item;
    await _getPartPrice();
  }

  Future<void> _getPartPrice() async {
    final part = selectedPart.value;
    final mark = selectedPartMark.value;

    if (part == null || mark == null) return;

    isPartPriceLoading.value = true;

    final param = PartPriceParamEntity(
      serial: selectedPart.value?.serial ?? '',
      mark: mark.mark,
    );

    final result = await _getPartPriceUseCase(param);


    result.whenOrNull(
      success: (data, failures, resultCode) {
        partPriceController.text = _formatPrice(
          data.price?.toString() ?? '0',
        );
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
        _emitError(_errorMessage);
      },
      connectionError: () =>
          _safeEmit(const EvaluationAidServiceRequestState.connectionError()),
    );

    isPartPriceLoading.value = false;
  }

  void addAnotherPart() {
    final part = selectedPart.value;
    if (part == null) return;

    selectedParts.add(part);

    _clearCurrentPartInputs();
  }

  void _clearCurrentPartInputs() {
    selectedPart.value = null;
    selectedPartCostCenter.value = null;
    selectedPartMark.value = null;

    partSearchController.clear();
    partPriceController.clear();
    partCountController.text = '1';

    partList = [];
    partCostCenterList = [];
    partMarkList = [];
  }

  AllowableCostCenterEntity? _findDefaultCostCenter(
      List<AllowableCostCenterEntity> items,) {
    if (items.isEmpty) return null;

    return items.firstWhere(
          (item) => item.selected == true,
      orElse: () => items.first,
    );
  }

  String _formatPrice(String value) {
    return value;
  }

  void selectLaborCostCenter(AllowableCostCenterEntity item) {
    selectedLaborCostCenter.value = item;
    _setLaborPriceByCostCenter();
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
      return defectListResult;
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

  Future<void> submit () async {}

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
        form.fillFromLastEvaluation(data.lastEvaluation);
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
      emdadgarDefectInfoId: selectedRequest?.defectId ?? 0,
      emdadgarServiceCategoryId: selectedRequest?.emdadServiceCategoryId ?? 0,
      serviceRequestId: selectedRequest?.id ?? 0,
      evaluationCustomerKilometer:
      lastEvaluationEntity?.lastEvaluation?.customerKilometer,
    );
    final result = await _getServiceDetailEvaluationUseCase(param);

    late FetchResultType fetchResult = FetchResultType.failure;
    result.whenOrNull(
      success: (data, _, _) {
        emdadgarServiceDetailEntity = data;
        form.setServiceTitle(data.serviceTitle);
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
    _laborSearchDebounce?.cancel();
    _partSearchDebounce?.cancel();

    laborSearchController.dispose();
    laborPriceController.dispose();

    partSearchController.dispose();
    partPriceController.dispose();
    partCountController.dispose();

    selectedLabor.dispose();
    selectedLaborCostCenter.dispose();
    selectedPart.dispose();
    selectedPartCostCenter.dispose();
    selectedPartMark.dispose();

    return super.close();
  }
}
