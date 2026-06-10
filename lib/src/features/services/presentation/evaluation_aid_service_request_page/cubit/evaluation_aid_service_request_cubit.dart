import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/fetch_result_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/emdadgar_service_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/evaluation_service_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/last_evaluation_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/aid_service_evaluation_submit_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/labor_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/last_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_marks_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_price_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/services_and_labors_and_parts_evaluation_entity.dart';
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
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/submit_evaluation_for_aid_service_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/emdadgar/emdadgar_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/service_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/fetch_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_emdadgar_info_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/get_relief_request_by_id_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/enums/add_part_and_labor_sheet_mode.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
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
    this._getLaborListUseCase,
    this._submitEvaluationForAidServiceUseCase,
  ) : super(const EvaluationAidServiceRequestState.idle());

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

  String? _errorMessage;
  ReliefRequestEntity? selectedRequest;
  EmdadgarInfoEntity? emdadgarInfo;
  ResponseLastEvaluationEntity? lastEvaluationEntity;
  EmdadgarServiceDetailEntity? emdadgarServiceDetailEntity;

  AddPartAndLaborSheetMode addPartAndLaborSheetMode =
      AddPartAndLaborSheetMode.create;

  EvaluationSelectedLaborEntity? editingOriginalLabor;

  final form = EvaluationInitialFormController();

  final expandedLaborPartListIdsNotifier = ValueNotifier<Set<int>>({});

  bool get hasSelectedLabors => selectedLaborsNotifier.value.isNotEmpty;

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

  final laborListNotifier = ValueNotifier<List<LaborEntity>>([]);
  final isLaborLoading = ValueNotifier<bool>(false);


  final laborCostCenterListNotifier = ValueNotifier<List<AllowableCostCenterEntity>>([]);

  final partListNotifier = ValueNotifier<List<PartEntity>>([]);
  final isPartLoading = ValueNotifier<bool>(false);

  final partCostCenterListNotifier =
  ValueNotifier<List<AllowableCostCenterEntity>>([]);
  final partMarkListNotifier = ValueNotifier<List<PartMarkEntity>>([]);

  final selectedPartsNotifier =
      ValueNotifier<List<EvaluationSelectedPartEntity>>([]);

  bool get hasSelectedParts => selectedPartsNotifier.value.isNotEmpty;

  final selectedLaborsNotifier = ValueNotifier<
      List<EvaluationSelectedLaborEntity>>([]);

  List<EvaluationSelectedLaborEntity> get selectedLabors =>
      selectedLaborsNotifier.value;


  final isPartMarkLoading = ValueNotifier<bool>(false);
  final isPartPriceLoading = ValueNotifier<bool>(false);

  void prepareCreateLaborAndPartSheet() {
    addPartAndLaborSheetMode = AddPartAndLaborSheetMode.create;
    editingOriginalLabor = null;

    _clearAddPartAndLaborSheetInputs();
  }

  void onLaborSearchChanged(String query) {
    _laborSearchDebounce?.cancel();

    final trimmedQuery = query.trim();

    if (trimmedQuery.length < 3) {
      laborListNotifier.value = [];
      isLaborLoading.value = false;
      return;
    }
    isLaborLoading.value = true;

    _laborSearchDebounce = Timer(
      const Duration(seconds: 1),
          () => _searchLabors(trimmedQuery),
    );
  }

  bool saveLaborAndPartsFromSheet() {
    final selectedLaborItem = _buildSelectedLaborFromSheet();

    if (selectedLaborItem == null) return false;

    switch (addPartAndLaborSheetMode) {
      case AddPartAndLaborSheetMode.create:
        _addSelectedLabor(selectedLaborItem);
        break;

      case AddPartAndLaborSheetMode.editLabor:
      case AddPartAndLaborSheetMode.addPartToLabor:
        final updated = _replaceEditingLabor(selectedLaborItem);

        if (!updated) {
          return false;
        }

        break;
    }

    _clearAddPartAndLaborSheetInputs();

    addPartAndLaborSheetMode = AddPartAndLaborSheetMode.create;
    editingOriginalLabor = null;

    return true;
  }

  void _addSelectedLabor(EvaluationSelectedLaborEntity labor) {
    selectedLaborsNotifier.value = [
      ...selectedLaborsNotifier.value,
      labor,
    ];
  }

  bool _replaceEditingLabor(EvaluationSelectedLaborEntity updatedLabor) {
    final originalLabor = editingOriginalLabor;

    if (originalLabor == null) {
      _emitError('اجرت انتخاب‌شده برای بروزرسانی پیدا نشد');
      return false;
    }

    var replaced = false;

    final updatedItems = selectedLaborsNotifier.value.map((item) {
      if (!replaced && _isSameLaborObject(item, originalLabor)) {
        replaced = true;
        return updatedLabor;
      }

      return item;
    }).toList();

    if (!replaced) {
      _emitError('اجرت انتخاب‌شده برای بروزرسانی در لیست پیدا نشد');
      return false;
    }

    selectedLaborsNotifier.value = updatedItems;
    return true;
  }

  bool _isSameLaborObject(EvaluationSelectedLaborEntity first,
      EvaluationSelectedLaborEntity second,) {
    return identical(first, second) || first == second;
  }



  void _clearAddPartAndLaborSheetInputs() {
    selectedLabor.value = null;
    selectedLaborCostCenter.value = null;

    laborSearchController.clear();
    laborPriceController.clear();

    laborListNotifier.value = [];
    laborCostCenterListNotifier.value = [];

    _clearCurrentPartInputs();

    selectedPartsNotifier.value = [];
  }

  EvaluationSelectedLaborEntity? _buildSelectedLaborFromSheet() {
    final labor = selectedLabor.value;
    final costCenter = selectedLaborCostCenter.value;

    if (labor == null || costCenter == null) {
      _emitError('لطفاً نام اجرت و مرکز هزینه اجرت را انتخاب کنید');
      return null;
    }

    final price = _parsePrice(laborPriceController.text);

    return EvaluationSelectedLaborEntity(
      labor: labor,
      costCenter: costCenter,
      price: price,
      evaluationParts: List<EvaluationSelectedPartEntity>.from(
        selectedPartsNotifier.value,
      ),
    );
  }

  Future<void> _searchLabors(String query) async {
    isLaborLoading.value = true;

    final items = await _fetchLaborList(query);

    laborListNotifier.value = items;
    isLaborLoading.value = false;
  }

  void _fillLaborSheetFromSelectedLabor(EvaluationSelectedLaborEntity labor,) {
    selectedLabor.value = labor.labor;
    laborSearchController.text = labor.labor.label;

    final costCenters = labor.labor.allowableCostCenterList ?? [];

    laborCostCenterListNotifier.value =
    List<AllowableCostCenterEntity>.from(costCenters);

    selectedLaborCostCenter.value = _findMatchingCostCenter(
      costCenters: costCenters,
      previousCostCenter: labor.costCenter,
    );

    laborPriceController.text = _formatPrice(
      labor.price.toString(),
    );
  }

  AllowableCostCenterEntity? _findMatchingCostCenter({
    required List<AllowableCostCenterEntity> costCenters,
    required AllowableCostCenterEntity previousCostCenter,
  }) {
    if (costCenters.isEmpty) return null;

    final previousId = previousCostCenter.id;
    final previousCode = previousCostCenter.code;

    for (final item in costCenters) {
      final sameId = previousId != null && item.id == previousId;
      final sameCode = previousCode != null && item.code == previousCode;

      if (sameId || sameCode) {
        return item;
      }
    }

    return _findDefaultCostCenter(costCenters);
  }

  LaborEntity? _findFreshLaborInList({
    required List<LaborEntity> items,
    required EvaluationSelectedLaborEntity source,
  }) {
    for (final item in items) {
      if (source.laborId != null && item.id == source.laborId) {
        return item;
      }
    }

    for (final item in items) {
      if (source.laborCode.isNotEmpty && item.code == source.laborCode) {
        return item;
      }
    }

    return null;
  }

  Future<List<LaborEntity>> _fetchLaborList(String query) async {
    final param = LaborListParamEntity(
      serviceType: ServiceType.reliefService,
      defectId: selectedRequest?.defectId ?? 0,
      serviceRequestId: selectedRequest?.id,
      hasSubscription: emdadgarServiceDetailEntity?.hasSubscription,
      kilometer: int.tryParse(form.kilometerController.text.trim()),
      emdadServiceId: emdadgarServiceDetailEntity?.serviceId,
      hasGaranty: emdadgarServiceDetailEntity?.hasGaranty,
      searchText: query,
      workOrderCode: emdadgarServiceDetailEntity?.defectInfoProblemOrEzharCode,
    );

    final result = await _getLaborListUseCase(param);

    List<LaborEntity> items = [];

    result.whenOrNull(
      success: (data, failures, resultCode) {
        items = List<LaborEntity>.from(data);
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
        _emitError(_errorMessage);
      },
      connectionError: () {
        _safeEmit(
          const EvaluationAidServiceRequestState.connectionError(),
        );
      },
    );

    return items;
  }

  void selectLabor(LaborEntity item) {
    selectedLabor.value = item;
    laborSearchController.text = item.label;

    final costCenters = item.allowableCostCenterList ?? [];

    laborCostCenterListNotifier.value = List<AllowableCostCenterEntity>.from(costCenters);

    selectedLaborCostCenter.value = _findDefaultCostCenter(costCenters);
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
      partListNotifier.value = [];
      isPartLoading.value = false;
      return;
    }

    isPartLoading.value = true;
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
        partListNotifier.value = List<PartEntity>.from(data);
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

    final costCenters = item.allowableCostCenterList ?? [];

    partCostCenterListNotifier.value = costCenters;
    partCostCenterListNotifier.value =
    List<AllowableCostCenterEntity>.from(costCenters);

    selectedPartCostCenter.value = _findDefaultCostCenter(costCenters);

    partMarkListNotifier.value = [];

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
      serial: part.serial ?? '',
      partGroupId: part.partGroupId ?? 0,
    );

    final result = await _getPartMarkListUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        partMarkListNotifier.value = List<PartMarkEntity>.from(data);
      },
      failure: (error, failures) {
        partMarkListNotifier.value = [];

        _errorMessage = _fallbackError(failures ?? error.toString());
        _emitError(_errorMessage);
      },
      connectionError: () {
        partMarkListNotifier.value = [];

        _safeEmit(
          const EvaluationAidServiceRequestState.connectionError(),
        );
      },
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
    final selectedPartItem = _buildSelectedPartEntity();

    if (selectedPartItem == null) {
      return;
    }
    selectedPartsNotifier.value = [
      ...selectedPartsNotifier.value,
      selectedPartItem,
    ];

    _clearCurrentPartInputs();
  }

  void removeSelectedPartAt(int index) {
    final items = [...selectedPartsNotifier.value];

    if (index < 0 || index >= items.length) return;

    items.removeAt(index);
    selectedPartsNotifier.value = items;
  }

  EvaluationSelectedPartEntity? _buildSelectedPartEntity() {
    final part = selectedPart.value;
    final mark = selectedPartMark.value;
    final costCenter = selectedPartCostCenter.value;

    if (part == null || mark == null || costCenter == null) {
      return null;
    }

    return EvaluationSelectedPartEntity(
      part: part,
      mark: mark,
      costCenter: costCenter,
      count: int.tryParse(partCountController.text) ?? 1,
      price: _parsePrice(partPriceController.text),
    );
  }

  int _parsePrice(String value) {
    final normalized = value.replaceAll(',', '').trim();
    return int.tryParse(normalized) ?? 0;
  }

  void _clearCurrentPartInputs() {
    selectedPart.value = null;
    selectedPartCostCenter.value = null;
    selectedPartMark.value = null;

    partSearchController.clear();
    partPriceController.clear();
    partCountController.text = '1';

    partListNotifier.value = [];

    partCostCenterListNotifier.value = [];
    partCostCenterListNotifier.value = [];

    partMarkListNotifier.value.clear();
    partMarkListNotifier.value = [];

    isPartLoading.value = false;
    isPartMarkLoading.value = false;
    isPartPriceLoading.value = false;
  }

  void removeSelectedLabor(EvaluationSelectedLaborEntity labor) {
    selectedLaborsNotifier.value = selectedLaborsNotifier.value
        .where((item) => !_isSameLaborObject(item, labor))
        .toList();

    final laborId = labor.laborId;

    if (laborId != null) {
      final expandedIds = {...expandedLaborPartListIdsNotifier.value};
      expandedIds.remove(laborId);
      expandedLaborPartListIdsNotifier.value = expandedIds;
    }
  }

  Future<bool> editSelectedLabor(EvaluationSelectedLaborEntity labor,) async {
    addPartAndLaborSheetMode = AddPartAndLaborSheetMode.editLabor;
    editingOriginalLabor = labor;

    _clearAddPartAndLaborSheetInputs();

    _fillLaborSheetFromSelectedLabor(labor);

    selectedPartsNotifier.value = List<EvaluationSelectedPartEntity>.from(
      labor.evaluationParts,
    );

    return true;
  }

  Future<bool> addPartToSelectedLabor(
      EvaluationSelectedLaborEntity labor,) async {
    addPartAndLaborSheetMode = AddPartAndLaborSheetMode.addPartToLabor;
    editingOriginalLabor = labor;

    _clearAddPartAndLaborSheetInputs();

    _fillLaborSheetFromSelectedLabor(labor);

    selectedPartsNotifier.value = List<EvaluationSelectedPartEntity>.from(
      labor.evaluationParts,
    );

    _clearCurrentPartInputs();

    return true;
  }

  void removePartFromSelectedLabor({
    required int laborIndex,
    required int partIndex,
  }) {
    final labors = [...selectedLaborsNotifier.value];

    if (laborIndex < 0 || laborIndex >= labors.length) return;

    final labor = labors[laborIndex];
    final parts = [...labor.evaluationParts];

    if (partIndex < 0 || partIndex >= parts.length) return;

    parts.removeAt(partIndex);

    labors[laborIndex] = labor.copyWith(
      evaluationParts: parts,
    );

    selectedLaborsNotifier.value = labors;
  }

  void toggleSelectedLaborPartsVisibility(EvaluationSelectedLaborEntity labor) {
    final laborId = labor.laborId;
    if (laborId == null) return;

    final current = {...expandedLaborPartListIdsNotifier.value};

    if (current.contains(laborId)) {
      current.remove(laborId);
    } else {
      current.add(laborId);
    }

    expandedLaborPartListIdsNotifier.value = current;
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
    if (value.isEmpty) return '';

    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) return '';

    return digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
    );
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


  Future<void> submitEvaluationForAidService() async {
    if (selectedLaborsNotifier.value.isEmpty) {
      _emitError('حداقل یک اجرت باید انتخاب شود');
      return;
    }

    _safeEmit(const EvaluationAidServiceRequestState.submitLoading());

    final param = _buildEvaluationSubmitEntity();

    final result = await _submitEvaluationForAidServiceUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        /*PostEvaluationResponseEntity*/
        _safeEmit(const EvaluationAidServiceRequestState.submitSuccess());
      },
      failure: (error, failures) {
        _errorMessage = _fallbackError(failures ?? error.toString());
        _emitError(_errorMessage);
      },
      connectionError: () {
        _safeEmit(
          const EvaluationAidServiceRequestState.connectionError(),
        );
      },
    );
  }

  AidServiceEvaluationSubmitParamEntity _buildEvaluationSubmitEntity() {
    return AidServiceEvaluationSubmitParamEntity(
      serviceRequestId: selectedRequest?.id,
      serviceType: selectedRequest?.serviceType?.value,
      emdadgarId: emdadgarInfo?.id,
      serviceCategoryId: selectedServiceCategory.value?.id ??
          emdadgarServiceDetailEntity?.serviceCategoryId,
      customerKilometer: int.tryParse(form.kilometerController.text),
      distanceToCustomer: int.tryParse(form.customerDistanceController.text),
      assignDate: JalaliDateHelper.formatServerDateTime(form.assignDateTime),
      arriveDate: JalaliDateHelper.formatServerDateTime(form.arriveDateTime),
      //todo create endDateTime
      //endWorkDate: JalaliDateHelper.formatServerIsoDateTime(form.endDateTime),
      confirmValidation: false,
      defectInfoId: selectedRequest?.defectId,
      description: form.descriptionController.text.trim(),
      servicesAndLaborsAndPartsEvaluationPayload:
      ServicesAndLaborsAndPartsEvaluationEntity(
        evaluationServices: [
          _buildEvaluationServiceEntity(),
        ],
      ),
    );
  }

  EvaluationServiceEntity _buildEvaluationServiceEntity() {
    return EvaluationServiceEntity(
      serviceTypeId: selectedRequest?.serviceType?.value,
      serviceTypeTitle: selectedRequest?.serviceType?.label,
      serviceType: selectedRequest?.serviceType,
      serviceId: emdadgarServiceDetailEntity?.serviceId,
      serviceTitle: emdadgarServiceDetailEntity?.serviceTitle,
      serviceCode: emdadgarServiceDetailEntity?.serviceCode,
      serviceCategoryId: selectedServiceCategory.value?.id ??
          emdadgarServiceDetailEntity?.serviceCategoryId,
      serviceCategoryTitle: selectedServiceCategory.value?.title ??
          emdadgarServiceDetailEntity?.serviceCategoryTitle,
      serviceCategoryCode: selectedServiceCategory.value?.code ??
          emdadgarServiceDetailEntity?.serviceCategoryCode,
      defectInfoId: selectedRequest?.defectId,
      defectInfoTitle: emdadgarServiceDetailEntity?.defectInfoTitle,
      defectInfoProblemOrEzharCode:
      emdadgarServiceDetailEntity?.defectInfoProblemOrEzharCode,

      hasGaranty: emdadgarServiceDetailEntity?.hasGaranty ?? false,
      hasSubscription: emdadgarServiceDetailEntity?.hasSubscription ?? false,
      isSubscribedByNationalCode:
      emdadgarServiceDetailEntity?.isSubscribedByNationalCode ?? false,
      limitationDescription:
      emdadgarServiceDetailEntity?.limitationDescription ?? '',
      subscriptionId: lastEvaluationEntity?.lastEvaluation
          ?.servicesAndLaborsAndPartsEvaluationPayload?.evaluationServices
          ?.first.subscriptionId,
      evaluationLabors: selectedLaborsNotifier.value,
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
    selectedLaborsNotifier.dispose();
    selectedPartsNotifier.dispose();
    laborListNotifier.dispose();
    laborCostCenterListNotifier.dispose();
    isLaborLoading.dispose();
    partListNotifier.dispose();
    partCostCenterListNotifier.dispose();
    partMarkListNotifier.dispose();
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
    isPartLoading.dispose();
    isPartMarkLoading.dispose();
    isPartPriceLoading.dispose();

    return super.close();
  }
}
