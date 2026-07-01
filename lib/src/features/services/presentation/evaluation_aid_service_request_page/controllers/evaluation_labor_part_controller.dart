import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/allowable_cost_center_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_labor_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/labor_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_list_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_marks_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/part_price_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/part_mark_entity.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_labor_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_mark_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/usecase/get_part_price_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/enums/add_part_and_labor_sheet_mode.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/helpers/evaluation_cost_center_resolver.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/evaluation_aid_service_request_page/helpers/evaluation_price_formatter.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter/material.dart';

import 'evaluation_labor_part_context.dart';

typedef EvaluationLaborPartContextReader =
    EvaluationLaborPartContext Function();
typedef EvaluationLaborPartErrorCallback = void Function(String message);
typedef EvaluationLaborPartConnectionErrorCallback = void Function();

class EvaluationLaborPartController {
  EvaluationLaborPartController({
    required GetLaborListUseCase getLaborListUseCase,
    required GetPartListUseCase getPartListUseCase,
    required GetPartMarkListUseCase getPartMarkListUseCase,
    required GetPartPriceUseCase getPartPriceUseCase,
    required EvaluationLaborPartContextReader readContext,
    required EvaluationLaborPartErrorCallback onError,
    required EvaluationLaborPartConnectionErrorCallback onConnectionError,
    Duration searchDelay = const Duration(seconds: 1),
  }) : _getLaborListUseCase = getLaborListUseCase,
       _getPartListUseCase = getPartListUseCase,
       _getPartMarkListUseCase = getPartMarkListUseCase,
       _getPartPriceUseCase = getPartPriceUseCase,
       _readContext = readContext,
       _onError = onError,
       _onConnectionError = onConnectionError,
       _searchDelay = searchDelay;

  final GetLaborListUseCase _getLaborListUseCase;
  final GetPartListUseCase _getPartListUseCase;
  final GetPartMarkListUseCase _getPartMarkListUseCase;
  final GetPartPriceUseCase _getPartPriceUseCase;
  final EvaluationLaborPartContextReader _readContext;
  final EvaluationLaborPartErrorCallback _onError;
  final EvaluationLaborPartConnectionErrorCallback _onConnectionError;
  final Duration _searchDelay;

  Timer? _laborSearchDebounce;
  Timer? _partSearchDebounce;
  int _laborSearchToken = 0;
  int _partSearchToken = 0;

  AddPartAndLaborSheetMode mode = AddPartAndLaborSheetMode.create;
  EvaluationSelectedLaborEntity? editingOriginalLabor;

  final expandedLaborPartListIdsNotifier = ValueNotifier<Set<int>>({});

  final laborSearchController = TextEditingController();
  final laborPriceController = TextEditingController();

  final partSearchController = TextEditingController();
  final partPriceController = TextEditingController();
  final partCountController = TextEditingController(text: '1');

  final selectedLabor = ValueNotifier<LaborEntity?>(null);
  final selectedLaborCostCenter = ValueNotifier<AllowableCostCenterEntity?>(
    null,
  );

  final selectedPart = ValueNotifier<PartEntity?>(null);
  final selectedPartCostCenter = ValueNotifier<AllowableCostCenterEntity?>(
    null,
  );
  final selectedPartMark = ValueNotifier<PartMarkEntity?>(null);

  final laborListNotifier = ValueNotifier<List<LaborEntity>>([]);
  final laborCostCenterListNotifier =
      ValueNotifier<List<AllowableCostCenterEntity>>([]);
  final isLaborLoading = ValueNotifier<bool>(false);

  final partListNotifier = ValueNotifier<List<PartEntity>>([]);
  final partCostCenterListNotifier =
      ValueNotifier<List<AllowableCostCenterEntity>>([]);
  final partMarkListNotifier = ValueNotifier<List<PartMarkEntity>>([]);
  final isPartLoading = ValueNotifier<bool>(false);
  final isPartMarkLoading = ValueNotifier<bool>(false);
  final isPartPriceLoading = ValueNotifier<bool>(false);

  final selectedPartsNotifier =
      ValueNotifier<List<EvaluationSelectedPartEntity>>([]);
  final selectedLaborsNotifier =
      ValueNotifier<List<EvaluationSelectedLaborEntity>>([]);

  bool get hasSelectedParts => selectedPartsNotifier.value.isNotEmpty;

  bool get hasSelectedLabors => selectedLaborsNotifier.value.isNotEmpty;

  List<EvaluationSelectedLaborEntity> get selectedLabors =>
      selectedLaborsNotifier.value;

  void prepareCreateSheet() {
    mode = AddPartAndLaborSheetMode.create;
    editingOriginalLabor = null;
    _clearSheetInputs();
  }

  void onLaborSearchChanged(String query) {
    _laborSearchDebounce?.cancel();
    final token = ++_laborSearchToken;
    final trimmedQuery = query.trim();

    if (trimmedQuery.length < 3) {
      laborListNotifier.value = [];
      isLaborLoading.value = false;
      return;
    }

    isLaborLoading.value = true;
    _laborSearchDebounce = Timer(
      _searchDelay,
      () => _searchLabors(trimmedQuery, token),
    );
  }

  Future<void> _searchLabors(String query, int token) async {
    isLaborLoading.value = true;

    final items = await _fetchLaborList(query);

    if (token == _laborSearchToken) {
      laborListNotifier.value = items;
      isLaborLoading.value = false;
    }
  }

  Future<List<LaborEntity>> _fetchLaborList(String query) async {
    final context = _readContext();
    final request = context.selectedRequest;
    final detail = context.emdadgarServiceDetailEntity;

    final param = LaborListParamEntity(
      serviceType: ServiceType.reliefService,
      defectId: request?.defectId ?? 0,
      serviceRequestId: request?.id,
      hasSubscription: detail?.hasSubscription,
      kilometer: int.tryParse(context.customerKilometerText.trim()),
      emdadServiceId: detail?.serviceId,
      hasGaranty: detail?.hasGaranty,
      searchText: query,
      workOrderCode: detail?.defectInfoProblemOrEzharCode,
    );

    final result = await _getLaborListUseCase(param);
    var items = <LaborEntity>[];

    result.whenOrNull(
      success: (data, failures, resultCode) {
        items = List<LaborEntity>.from(data);
      },
      failure: (error, failures) {
        _emitError(failures ?? error.toString());
      },
      connectionError: _onConnectionError,
    );

    return items;
  }

  void selectLabor(LaborEntity item) {
    selectedLabor.value = item;
    laborSearchController.text = item.label;

    final costCenters = item.allowableCostCenterList ?? [];
    laborCostCenterListNotifier.value = List<AllowableCostCenterEntity>.from(
      costCenters,
    );
    selectedLaborCostCenter.value = EvaluationCostCenterResolver.findDefault(
      costCenters,
    );

    _setLaborPriceByCostCenter();
  }

  void selectLaborCostCenter(AllowableCostCenterEntity item) {
    selectedLaborCostCenter.value = item;
    _setLaborPriceByCostCenter();
  }

  void _setLaborPriceByCostCenter() {
    final labor = selectedLabor.value;
    final costCenter = selectedLaborCostCenter.value;

    if (labor == null || costCenter == null) {
      laborPriceController.clear();
      return;
    }

    final price = EvaluationCostCenterResolver.resolveLaborPrice(
      labor: labor,
      costCenter: costCenter,
    );

    laborPriceController.text = EvaluationPriceFormatter.format(price);
  }

  void onPartSearchChanged(String query) {
    _partSearchDebounce?.cancel();
    final token = ++_partSearchToken;
    final trimmedQuery = query.trim();

    if (trimmedQuery.length < 3) {
      partListNotifier.value = [];
      isPartLoading.value = false;
      return;
    }

    isPartLoading.value = true;
    _partSearchDebounce = Timer(
      _searchDelay,
      () => _searchParts(trimmedQuery, token),
    );
  }

  Future<void> _searchParts(String query, int token) async {
    isPartLoading.value = true;

    final context = _readContext();
    final request = context.selectedRequest;
    final detail = context.emdadgarServiceDetailEntity;
    final lastEvaluation = context.lastEvaluationEntity?.lastEvaluation;

    final param = PartListParamEntity(
      serviceType: ServiceType.reliefService,
      defectId: request?.defectId ?? 0,
      serviceRequestId: request?.id,
      hasSubscription: detail?.hasSubscription,
      kilometer: lastEvaluation?.customerKilometer,
      emdadServiceId: detail?.serviceId,
      hasGaranty: detail?.hasGaranty,
      searchText: query,
      workOrderCode: detail?.defectInfoProblemOrEzharCode,
      laborGroupId: selectedLabor.value?.laborGroupId,
      laborId: selectedLabor.value?.id,
    );

    final result = await _getPartListUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        if (token == _partSearchToken) {
          partListNotifier.value = List<PartEntity>.from(data);
        }
      },
      failure: (error, failures) {
        _emitError(failures ?? error.toString());
      },
      connectionError: _onConnectionError,
    );

    if (token == _partSearchToken) {
      isPartLoading.value = false;
    }
  }

  Future<void> selectPart(PartEntity item) async {
    selectedPart.value = item;
    partSearchController.text = item.label;

    final costCenters = item.allowableCostCenterList ?? [];
    partCostCenterListNotifier.value = List<AllowableCostCenterEntity>.from(
      costCenters,
    );
    selectedPartCostCenter.value = EvaluationCostCenterResolver.findDefault(
      costCenters,
    );

    partMarkListNotifier.value = [];
    selectedPartMark.value = null;
    partPriceController.clear();

    await _getPartMarks(item);
  }

  void selectPartCostCenter(AllowableCostCenterEntity item) {
    selectedPartCostCenter.value = item;
  }

  Future<void> _getPartMarks(PartEntity part) async {
    final context = _readContext();
    final request = context.selectedRequest;

    isPartMarkLoading.value = true;

    final param = PartMarksParamEntity(
      serviceType: ServiceType.reliefService,
      serviceRequestId: request?.id,
      defectId: request?.defectId ?? 0,
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
        _emitError(failures ?? error.toString());
      },
      connectionError: () {
        partMarkListNotifier.value = [];
        _onConnectionError();
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
      serial: part.serial ?? '',
      mark: mark.mark,
    );

    final result = await _getPartPriceUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) {
        partPriceController.text = EvaluationPriceFormatter.format(data.price);
      },
      failure: (error, failures) {
        _emitError(failures ?? error.toString());
      },
      connectionError: _onConnectionError,
    );

    isPartPriceLoading.value = false;
  }

  bool addAnotherPart() {
    final selectedPartItem = _buildSelectedPartEntity();

    if (selectedPartItem == null) {
      _emitError('لطفاً قطعه، برند و مرکز هزینه قطعه را انتخاب کنید');
      return false;
    }

    selectedPartsNotifier.value = [
      ...selectedPartsNotifier.value,
      selectedPartItem,
    ];

    _clearCurrentPartInputs();
    return true;
  }

  void removeSelectedPartAt(int index) {
    final items = [...selectedPartsNotifier.value];

    if (index < 0 || index >= items.length) return;

    items.removeAt(index);
    selectedPartsNotifier.value = items;
  }

  bool get _hasCurrentPartInput {
    final partText = partSearchController.text.trim();
    final priceText = partPriceController.text.trim();
    final countText = partCountController.text.trim();

    return selectedPart.value != null ||
        selectedPartCostCenter.value != null ||
        selectedPartMark.value != null ||
        partText.isNotEmpty ||
        priceText.isNotEmpty ||
        (countText.isNotEmpty && countText != '1');
  }

  bool _appendCurrentPartIfNeeded() {
    if (!_hasCurrentPartInput) {
      return true;
    }

    final selectedPartItem = _buildSelectedPartEntity();

    if (selectedPartItem == null) {
      _emitError('لطفاً قطعه، برند و مرکز هزینه قطعه را انتخاب کنید');
      return false;
    }

    selectedPartsNotifier.value = [
      ...selectedPartsNotifier.value,
      selectedPartItem,
    ];

    _clearCurrentPartInputs();
    return true;
  }

  bool saveLaborAndPartsFromSheet() {
    final partAdded = _appendCurrentPartIfNeeded();

    if (!partAdded) {
      return false;
    }

    final selectedLaborItem = _buildSelectedLaborFromSheet();

    if (selectedLaborItem == null) return false;

    switch (mode) {
      case AddPartAndLaborSheetMode.create:
        selectedLaborsNotifier.value = [
          ...selectedLaborsNotifier.value,
          selectedLaborItem,
        ];
        break;

      case AddPartAndLaborSheetMode.editLabor:
      case AddPartAndLaborSheetMode.addPartToLabor:
        final updated = _replaceEditingLabor(selectedLaborItem);
        if (!updated) return false;
        break;
    }

    _clearSheetInputs();
    mode = AddPartAndLaborSheetMode.create;
    editingOriginalLabor = null;

    return true;
  }

  Future<bool> editSelectedLabor(EvaluationSelectedLaborEntity labor) async {
    mode = AddPartAndLaborSheetMode.editLabor;
    editingOriginalLabor = labor;

    _clearSheetInputs();
    _fillLaborSheetFromSelectedLabor(labor);
    selectedPartsNotifier.value = List<EvaluationSelectedPartEntity>.from(
      labor.evaluationParts,
    );

    return true;
  }

  Future<bool> addPartToSelectedLabor(
    EvaluationSelectedLaborEntity labor,
  ) async {
    mode = AddPartAndLaborSheetMode.addPartToLabor;
    editingOriginalLabor = labor;

    _clearSheetInputs();
    _fillLaborSheetFromSelectedLabor(labor);
    selectedPartsNotifier.value = List<EvaluationSelectedPartEntity>.from(
      labor.evaluationParts,
    );
    _clearCurrentPartInputs();

    return true;
  }

  void removeSelectedLabor(EvaluationSelectedLaborEntity labor) {
    selectedLaborsNotifier.value = selectedLaborsNotifier.value
        .where((item) => !_isSameLaborObject(item, labor))
        .toList();

    final laborId = labor.laborId;
    if (laborId == null) return;

    final expandedIds = {...expandedLaborPartListIdsNotifier.value};
    expandedIds.remove(laborId);
    expandedLaborPartListIdsNotifier.value = expandedIds;
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
    labors[laborIndex] = labor.copyWith(evaluationParts: parts);
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

  bool _isSameLaborObject(
    EvaluationSelectedLaborEntity first,
    EvaluationSelectedLaborEntity second,
  ) {
    return identical(first, second) || first == second;
  }

  EvaluationSelectedLaborEntity? _buildSelectedLaborFromSheet() {
    final labor = selectedLabor.value;
    final costCenter = selectedLaborCostCenter.value;

    if (labor == null || costCenter == null) {
      _emitError('لطفاً نام اجرت و مرکز هزینه اجرت را انتخاب کنید');
      return null;
    }

    return EvaluationSelectedLaborEntity(
      labor: labor,
      costCenter: costCenter,
      price: EvaluationPriceFormatter.parse(laborPriceController.text),
      evaluationParts: List<EvaluationSelectedPartEntity>.from(
        selectedPartsNotifier.value,
      ),
    );
  }

  EvaluationSelectedPartEntity? _buildSelectedPartEntity() {
    final part = selectedPart.value;
    final mark = selectedPartMark.value;
    final costCenter = selectedPartCostCenter.value;

    if (part == null || mark == null || costCenter == null) return null;

    return EvaluationSelectedPartEntity(
      part: part,
      mark: mark,
      costCenter: costCenter,
      count: int.tryParse(partCountController.text.trim()) ?? 1,
      price: EvaluationPriceFormatter.parse(partPriceController.text),
    );
  }

  void _fillLaborSheetFromSelectedLabor(EvaluationSelectedLaborEntity labor) {
    selectedLabor.value = labor.labor;
    laborSearchController.text = labor.labor.label;

    final costCenters = labor.labor.allowableCostCenterList ?? [];
    laborCostCenterListNotifier.value = List<AllowableCostCenterEntity>.from(
      costCenters,
    );
    selectedLaborCostCenter.value = EvaluationCostCenterResolver.findMatching(
      costCenters: costCenters,
      previousCostCenter: labor.costCenter,
    );
    laborPriceController.text = EvaluationPriceFormatter.format(labor.price);
  }

  void _clearSheetInputs() {
    selectedLabor.value = null;
    selectedLaborCostCenter.value = null;
    laborSearchController.clear();
    laborPriceController.clear();
    laborListNotifier.value = [];
    laborCostCenterListNotifier.value = [];

    _clearCurrentPartInputs();
    selectedPartsNotifier.value = [];
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
    partMarkListNotifier.value = [];

    isPartLoading.value = false;
    isPartMarkLoading.value = false;
    isPartPriceLoading.value = false;
  }

  void _emitError([String? message]) {
    _onError(_fallbackError(message));
  }

  String _fallbackError([String? message]) {
    if (message?.trim().isNotEmpty == true) return message!;
    return 'درخواست شما با خطا مواجه شد، لطفا با پشتیبانی تماس بگیرید';
  }

  void dispose() {
    _laborSearchDebounce?.cancel();
    _partSearchDebounce?.cancel();

    expandedLaborPartListIdsNotifier.dispose();

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

    laborListNotifier.dispose();
    laborCostCenterListNotifier.dispose();
    isLaborLoading.dispose();

    partListNotifier.dispose();
    partCostCenterListNotifier.dispose();
    partMarkListNotifier.dispose();
    isPartLoading.dispose();
    isPartMarkLoading.dispose();
    isPartPriceLoading.dispose();

    selectedPartsNotifier.dispose();
    selectedLaborsNotifier.dispose();
  }
}
