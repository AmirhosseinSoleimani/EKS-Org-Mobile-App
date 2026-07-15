import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/create_or_edit_vehicle_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/params/vehicle_info_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_defect_limitation_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_tool_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/use_cases/vehicle_info_use_cases.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/utils/vehicle_info_excel_exporter.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:open_filex/open_filex.dart';

part 'vehicle_info_cubit.freezed.dart';
part 'vehicle_info_state.dart';

@injectable
class VehicleInfoCubit extends Cubit<VehicleInfoState> {
  VehicleInfoCubit(
    this._getListUseCase,
    this._getByIdUseCase,
    this._saveUseCase,
    this._deleteUseCase,
    this._lookupsUseCase,
    this._toolsUseCase,
    this._categoriesUseCase,
    this._historyUseCase,
  ) : super(const VehicleInfoState.idle());

  final GetVehicleInfoListUseCase _getListUseCase;
  final GetVehicleInfoByIdUseCase _getByIdUseCase;
  final SaveVehicleInfoUseCase _saveUseCase;
  final DeleteVehicleInfoUseCase _deleteUseCase;
  final GetVehicleInfoLookupsUseCase _lookupsUseCase;
  final VehicleInfoToolsUseCase _toolsUseCase;
  final VehicleInfoServiceCategoriesUseCase _categoriesUseCase;
  final VehicleInfoHistoryUseCase _historyUseCase;

  final chassisController = TextEditingController();
  final engineController = TextEditingController();
  final imeiController = TextEditingController();
  final licensePlateController = TextEditingController();
  final toolsSearchController = TextEditingController();

  static const int _pageSize = 10;
  VoidCallback? _retryAction;

  VehicleInfoStateData get _data => state.data;
  bool get hasRetryAction => _retryAction != null;

  void retryLastAction() => _retryAction?.call();

  Future<void> fetchList({bool refresh = false}) async {
    if (_data.isInitialLoading || _data.isPaginationLoading || _data.isRefreshing) {
      return;
    }
    _retryAction = () => fetchList(refresh: refresh);
    final nextSkip = refresh ? 0 : _data.items.length;
    final filter = _data.filter.copyWith(skip: nextSkip, pageSize: _pageSize);

    emit(VehicleInfoState.loading(data: _data.copyWith(
      filter: filter,
      isInitialLoading: _data.items.isEmpty && !refresh,
      isRefreshing: refresh,
      isPaginationLoading: _data.items.isNotEmpty && !refresh,
      errorMessage: null,
    )));

    final result = await _getListUseCase(filter);
    result.when(
      success: (page, failures, resultCode) {
        final records = refresh ? page.records : [..._data.items, ...page.records];
        emit(VehicleInfoState.loaded(data: _data.copyWith(
          items: records,
          totalCount: page.count,
          hasMore: records.length < page.count,
          isInitialLoading: false,
          isRefreshing: false,
          isPaginationLoading: false,
        )));
      },
      failure: (error, failures) => _emitFailure(failures),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.'),
      connectionError: () => emit(VehicleInfoState.connectionError(data: _data.copyWith(
        isInitialLoading: false,
        isRefreshing: false,
        isPaginationLoading: false,
      ))),
    );
  }

  Future<void> applyFilter(VehicleInfoFilterParamEntity filter) async {
    emit(VehicleInfoState.loaded(data: _data.copyWith(filter: filter.copyWith(skip: 0, pageSize: _pageSize))));
    await fetchList(refresh: true);
  }

  Future<void> clearFilter() async {
    chassisController.clear();
    engineController.clear();
    imeiController.clear();
    licensePlateController.clear();
    emit(VehicleInfoState.loaded(data: _data.copyWith(
      filter: const VehicleInfoFilterParamEntity(pageSize: _pageSize),
    )));
    await fetchList(refresh: true);
  }

  Future<void> loadLookups({bool onlyActive = false}) async {
    if (_data.isLookupsLoading) return;
    emit(VehicleInfoState.loading(data: _data.copyWith(isLookupsLoading: true, errorMessage: null)));
    final result = await _lookupsUseCase.getVehicleModels(onlyActive: onlyActive);
    result.when(
      success: (items, failures, resultCode) => emit(VehicleInfoState.loaded(
        data: _data.copyWith(vehicleModels: items, isLookupsLoading: false),
      )),
      failure: (error, failures) => _emitFailure(failures, clearLookupsLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearLookupsLoading: true),
      connectionError: () => emit(VehicleInfoState.connectionError(data: _data.copyWith(isLookupsLoading: false))),
    );
  }

  Future<void> loadDetail(int id) async {
    if (_data.loadingDetailId == id) return;
    emit(VehicleInfoState.loading(data: _data.copyWith(loadingDetailId: id, errorMessage: null)));
    final result = await _getByIdUseCase(id);
    result.when(
      success: (item, failures, resultCode) => emit(VehicleInfoState.loaded(data: _data.copyWith(
        selectedItem: item,
        loadingDetailId: null,
      ))),
      failure: (error, failures) => _emitFailure(failures, clearDetailLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearDetailLoading: true),
      connectionError: () => emit(VehicleInfoState.connectionError(data: _data.copyWith(loadingDetailId: null))),
    );
  }

  Future<bool> save(CreateOrEditVehicleParamEntity param) async {
    if (_data.isSubmitting) return false;
    emit(VehicleInfoState.loading(data: _data.copyWith(isSubmitting: true, errorMessage: null)));
    final result = param.id == null ? await _saveUseCase.create(param) : await _saveUseCase.edit(param);
    return _handleVoidResult(result, param.id == null ? 'خودرو با موفقیت ثبت شد' : 'خودرو با موفقیت ویرایش شد');
  }

  Future<bool> deleteItem(int id) async {
    if (_data.deletingVehicleId != null) return false;
    emit(VehicleInfoState.loading(data: _data.copyWith(deletingVehicleId: id, errorMessage: null)));
    final result = await _deleteUseCase(id);
    final ok = _handleVoidResult(result, 'خودرو با موفقیت حذف شد', clearDeleting: true);
    if (ok) await fetchList(refresh: true);
    return ok;
  }

  Future<void> loadVehicleReport() async {
    if (_data.isReportLoading) return;

    emit(VehicleInfoState.loading(data: _data.copyWith(
      isReportLoading: true,
      reportFilePath: null,
      errorMessage: null,
    )));

    final result = await _getListUseCase(_data.filter.copyWith(skip: 0, pageSize: 0));
    await result.when<Future<void>>(
      success: (page, failures, resultCode) async {
        final filePath = await VehicleInfoExcelExporter.export(page.records);
        emit(VehicleInfoState.loaded(data: _data.copyWith(
          isReportLoading: false,
          reportFilePath: filePath,
          successMessage: 'فایل اکسل گزارش خودروها آماده شد',
        )));

        final openResult = await OpenFilex.open(
          filePath,
          type: 'application/vnd.ms-excel',
        );

        if (openResult.type != ResultType.done) {
          emit(VehicleInfoState.loaded(data: _data.copyWith(
            isReportLoading: false,
            reportFilePath: filePath,
            successMessage: 'فایل اکسل ذخیره شد اما برنامه ای برای باز کردن آن پیدا نشد',
          )));
        }
      },
      failure: (error, failures) async => _emitFailure(failures, clearReportLoading: true),
      expireToken: () async => _emitFailure('نشست کاربری منقضی شده است.', clearReportLoading: true),
      connectionError: () async => emit(VehicleInfoState.connectionError(
        data: _data.copyWith(isReportLoading: false),
      )),
    );
  }

  Future<void> loadTools(int vehicleId) async {
    if (_data.loadingToolsVehicleId == vehicleId) return;
    emit(VehicleInfoState.loading(data: _data.copyWith(loadingToolsVehicleId: vehicleId, errorMessage: null)));
    final result = await _toolsUseCase.getTools(vehicleId);
    result.when(
      success: (items, failures, resultCode) => emit(VehicleInfoState.loaded(data: _data.copyWith(
        tools: items,
        filteredTools: _filterTools(items, _data.toolsSearchText),
        loadingToolsVehicleId: null,
      ))),
      failure: (error, failures) => _emitFailure(failures, clearToolsLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearToolsLoading: true),
      connectionError: () => emit(VehicleInfoState.connectionError(data: _data.copyWith(loadingToolsVehicleId: null))),
    );
  }

  void onToolsSearchChanged(String value) {
    emit(VehicleInfoState.loaded(data: _data.copyWith(
      toolsSearchText: value,
      filteredTools: _filterTools(_data.tools, value),
    )));
  }

  void toggleTool(int id) {
    final tools = _data.tools.map((item) {
      return item.emdadToolsId == id ? item.copyWith(isSelectable: !item.isSelectable) : item;
    }).toList();
    emit(VehicleInfoState.loaded(data: _data.copyWith(
      tools: tools,
      filteredTools: _filterTools(tools, _data.toolsSearchText),
    )));
  }

  void setAllTools(bool selected) {
    final tools = _data.tools.map((item) => item.copyWith(isSelectable: selected)).toList();
    emit(VehicleInfoState.loaded(data: _data.copyWith(
      tools: tools,
      filteredTools: _filterTools(tools, _data.toolsSearchText),
    )));
  }

  Future<bool> submitTools(int vehicleId) async {
    if (_data.isSubmitting) return false;
    emit(VehicleInfoState.loading(data: _data.copyWith(isSubmitting: true, errorMessage: null)));
    final ids = _data.tools.where((item) => item.isSelectable).map((item) => item.emdadToolsId).toList();
    final result = await _toolsUseCase.submit(vehicleId: vehicleId, emdadToolsIds: ids);
    return _handleVoidResult(result, 'ابزارهای خودرو با موفقیت ثبت شد');
  }

  Future<void> loadServiceCategories(int vehicleId, {bool grouped = false}) async {
    if (_data.loadingServicesVehicleId == vehicleId) return;
    emit(VehicleInfoState.loading(data: _data.copyWith(loadingServicesVehicleId: vehicleId, errorMessage: null)));
    final result = grouped
        ? await _categoriesUseCase.getGroupedServiceCategories(vehicleId)
        : await _categoriesUseCase.getServiceCategories(vehicleId);
    result.when(
      success: (items, failures, resultCode) => emit(VehicleInfoState.loaded(data: _data.copyWith(
        serviceCategoryGroups: items,
        loadingServicesVehicleId: null,
      ))),
      failure: (error, failures) => _emitFailure(failures, clearServicesLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearServicesLoading: true),
      connectionError: () => emit(VehicleInfoState.connectionError(data: _data.copyWith(loadingServicesVehicleId: null))),
    );
  }

  void toggleServiceCategory(int categoryId) {
    final groups = _data.serviceCategoryGroups.map((group) {
      final categories = group.categories.map((category) {
        return category.id == categoryId ? category.copyWith(selectable: !category.selectable, selected: !(category.selected ?? category.selectable)) : category;
      }).toList();
      return EmdadServiceCategoryGroupEntity(
        id: group.id,
        code: group.code,
        name: group.name,
        indeterminate: group.indeterminate,
        selectable: group.selectable,
        categories: categories,
      );
    }).toList();
    emit(VehicleInfoState.loaded(data: _data.copyWith(serviceCategoryGroups: groups)));
  }

  Future<bool> submitServiceCategories(int vehicleId, {bool useBatchEndpoint = false}) async {
    if (_data.isSubmitting) return false;
    emit(VehicleInfoState.loading(data: _data.copyWith(isSubmitting: true, errorMessage: null)));
    final ids = _data.serviceCategoryGroups
        .expand((group) => group.categories)
        .where((item) => item.selected == true || item.selectable)
        .map((item) => item.id)
        .toList();
    final result = useBatchEndpoint
        ? await _categoriesUseCase.insertBatch(vehicleId: vehicleId, emdadServiceCategoryIds: ids)
        : await _categoriesUseCase.submitServiceCategories(vehicleInfoId: vehicleId, emdadServiceCategoryIds: ids);
    return _handleVoidResult(result, 'سرویس های خودرو با موفقیت ثبت شد');
  }

  Future<void> loadDefects({
    required int vehicleId,
    required int serviceCategoryId,
  }) async {
    emit(VehicleInfoState.loading(data: _data.copyWith(
      loadingDefectsServiceCategoryId: serviceCategoryId,
      selectedServiceCategoryId: serviceCategoryId,
      errorMessage: null,
    )));
    final result = await _categoriesUseCase.getDefects(
      vehicleInfoId: vehicleId,
      emdadServiceCategoryId: serviceCategoryId,
    );
    result.when(
      success: (items, failures, resultCode) => emit(VehicleInfoState.loaded(data: _data.copyWith(
        defects: items,
        loadingDefectsServiceCategoryId: null,
      ))),
      failure: (error, failures) => _emitFailure(failures, clearDefectsLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearDefectsLoading: true),
      connectionError: () => emit(VehicleInfoState.connectionError(data: _data.copyWith(loadingDefectsServiceCategoryId: null))),
    );
  }

  void toggleDefect(int id) {
    final defects = _data.defects.map((item) {
      return item.id == id ? item.copyWith(selected: !item.selected) : item;
    }).toList();
    emit(VehicleInfoState.loaded(data: _data.copyWith(defects: defects)));
  }

  Future<bool> submitDefects(int vehicleId) async {
    final serviceCategoryId = _data.selectedServiceCategoryId;
    if (_data.isSubmitting || serviceCategoryId == null) return false;
    emit(VehicleInfoState.loading(data: _data.copyWith(isSubmitting: true, errorMessage: null)));
    final ids = _data.defects.where((item) => item.selected).map((item) => item.id).toList();
    final result = await _categoriesUseCase.submitDefectLimitation(
      vehicleId: vehicleId,
      serviceCategoryId: serviceCategoryId,
      defectInfoIds: ids,
    );
    return _handleVoidResult(result, 'محدودیت عیوب خودرو با موفقیت ثبت شد');
  }

  Future<void> loadHistory({
    required int refId,
    int type = 2,
  }) async {
    if (_data.loadingHistoryRefId == refId) return;
    emit(VehicleInfoState.loading(data: _data.copyWith(
      loadingHistoryRefId: refId,
      errorMessage: null,
    )));
    final result = await _historyUseCase.getHistories(refId: refId, type: type);
    result.when(
      success: (items, failures, resultCode) => emit(VehicleInfoState.loaded(data: _data.copyWith(
        histories: items,
        loadingHistoryRefId: null,
      ))),
      failure: (error, failures) => _emitFailure(failures, clearHistoryLoading: true),
      expireToken: () => _emitFailure('نشست کاربری منقضی شده است.', clearHistoryLoading: true),
      connectionError: () => emit(VehicleInfoState.connectionError(data: _data.copyWith(loadingHistoryRefId: null))),
    );
  }

  List<VehicleToolEntity> _filterTools(List<VehicleToolEntity> tools, String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return tools;
    return tools.where((item) => item.emdadToolsTitle.toLowerCase().contains(normalized)).toList();
  }

  bool _handleVoidResult(
    dynamic result,
    String successMessage, {
    bool clearDeleting = false,
  }) {
    return result.when(
      success: (data, failures, resultCode) {
        emit(VehicleInfoState.success(data: _data.copyWith(
          isSubmitting: false,
          deletingVehicleId: clearDeleting ? null : _data.deletingVehicleId,
          successMessage: successMessage,
        )));
        return true;
      },
      failure: (error, failures) {
        _emitFailure(failures, clearSubmitting: true, clearDeleting: clearDeleting);
        return false;
      },
      expireToken: () {
        _emitFailure('نشست کاربری منقضی شده است.', clearSubmitting: true, clearDeleting: clearDeleting);
        return false;
      },
      connectionError: () {
        emit(VehicleInfoState.connectionError(data: _data.copyWith(
          isSubmitting: false,
          deletingVehicleId: clearDeleting ? null : _data.deletingVehicleId,
        )));
        return false;
      },
    );
  }

  void _emitFailure(
    String? message, {
    bool clearSubmitting = false,
    bool clearDeleting = false,
    bool clearLookupsLoading = false,
    bool clearDetailLoading = false,
    bool clearToolsLoading = false,
    bool clearServicesLoading = false,
    bool clearDefectsLoading = false,
    bool clearHistoryLoading = false,
    bool clearReportLoading = false,
  }) {
    emit(VehicleInfoState.failure(data: _data.copyWith(
      isInitialLoading: false,
      isRefreshing: false,
      isPaginationLoading: false,
      isSubmitting: clearSubmitting ? false : _data.isSubmitting,
      deletingVehicleId: clearDeleting ? null : _data.deletingVehicleId,
      isLookupsLoading: clearLookupsLoading ? false : _data.isLookupsLoading,
      loadingDetailId: clearDetailLoading ? null : _data.loadingDetailId,
      loadingToolsVehicleId: clearToolsLoading ? null : _data.loadingToolsVehicleId,
      loadingServicesVehicleId: clearServicesLoading ? null : _data.loadingServicesVehicleId,
      loadingDefectsServiceCategoryId: clearDefectsLoading ? null : _data.loadingDefectsServiceCategoryId,
      loadingHistoryRefId: clearHistoryLoading ? null : _data.loadingHistoryRefId,
      isReportLoading: clearReportLoading ? false : _data.isReportLoading,
      errorMessage: message?.trim().isNotEmpty == true ? message : 'عملیات با خطا مواجه شد.',
    )));
  }

  @override
  Future<void> close() {
    chassisController.dispose();
    engineController.dispose();
    imeiController.dispose();
    licensePlateController.dispose();
    toolsSearchController.dispose();
    return super.close();
  }
}
