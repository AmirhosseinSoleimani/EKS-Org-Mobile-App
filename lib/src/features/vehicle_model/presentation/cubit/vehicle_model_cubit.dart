import 'dart:math' as math;

import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_ids_payload_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_service_category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/usecases/add_vehicle_model_use_case.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/usecases/delete_vehicle_model_use_case.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/usecases/get_vehicle_defects_use_case.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/usecases/get_vehicle_model_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/usecases/get_vehicle_navgan_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/usecases/get_vehicle_service_groups_use_case.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/usecases/submit_vehicle_defects_use_case.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/usecases/submit_vehicle_service_categories_use_case.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/usecases/update_vehicle_model_use_case.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_state.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class VehicleModelCubit extends Cubit<VehicleModelState> {
  VehicleModelCubit(
    this._getListUseCase,
    this._getNavgansUseCase,
    this._getServiceGroupsUseCase,
    this._getDefectsUseCase,
    this._submitDefectsUseCase,
    this._submitServiceCategoriesUseCase,
    this._deleteUseCase,
    this._addUseCase,
    this._updateUseCase,
  ) : super(const VehicleModelState());

  final GetVehicleModelListUseCase _getListUseCase;
  final GetVehicleNavganListUseCase _getNavgansUseCase;
  final GetVehicleServiceGroupsUseCase _getServiceGroupsUseCase;
  final GetVehicleDefectsUseCase _getDefectsUseCase;
  final SubmitVehicleDefectsUseCase _submitDefectsUseCase;
  final SubmitVehicleServiceCategoriesUseCase
      _submitServiceCategoriesUseCase;
  final DeleteVehicleModelUseCase _deleteUseCase;
  final AddVehicleModelUseCase _addUseCase;
  final UpdateVehicleModelUseCase _updateUseCase;

  Future<void> init() async {
    await Future.wait([
      fetchNavgans(),
      fetchList(reset: true),
    ]);
  }

  Future<void> fetchList({bool reset = false}) async {
    if (state.isInitialLoading || state.isLoadingMore || state.isRefreshing) {
      return;
    }

    final nextSkip = reset ? 0 : state.records.length;
    emit(
      state.copyWith(
        status: reset ? VehicleModelViewStatus.loading : state.status,
        isLoadingMore: !reset,
        skip: nextSkip,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result = await _getListUseCase(
      _buildFilterParam(skip: nextSkip, pageSize: state.pageSize),
    );

    result.when(
      success: (page, failures, resultCode) {
        final records = reset
            ? page.records
            : <VehicleModelEntity>[...state.records, ...page.records];
        emit(
          state.copyWith(
            status: records.isEmpty
                ? VehicleModelViewStatus.empty
                : VehicleModelViewStatus.loaded,
            records: records,
            totalCount: page.count,
            isLoadingMore: false,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          status: reset ? VehicleModelViewStatus.failure : state.status,
          isLoadingMore: false,
          errorMessage:
              failures ?? 'دریافت لیست نوع خودرو با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          status: reset ? VehicleModelViewStatus.failure : state.status,
          isLoadingMore: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          status:
              reset ? VehicleModelViewStatus.connectionError : state.status,
          isLoadingMore: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
  }

  /// رکوردهای بارگذاری‌شده را بدون خالی کردن لیست و بدون تغییر موقعیت
  /// ScrollController دوباره دریافت می‌کند.
  Future<void> refreshCurrentList() async {
    if (state.isInitialLoading || state.isLoadingMore || state.isRefreshing) {
      return;
    }

    final requestedPageSize = math.max(
      state.pageSize,
      state.records.isEmpty ? state.pageSize : state.records.length + 1,
    );

    emit(
      state.copyWith(
        isRefreshing: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result = await _getListUseCase(
      _buildFilterParam(skip: 0, pageSize: requestedPageSize),
    );

    result.when(
      success: (page, failures, resultCode) => emit(
        state.copyWith(
          status: page.records.isEmpty
              ? VehicleModelViewStatus.empty
              : VehicleModelViewStatus.loaded,
          records: page.records,
          totalCount: page.count,
          skip: 0,
          isRefreshing: false,
          clearErrorMessage: true,
        ),
      ),
      failure: (error, failures) => emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage:
              failures ?? 'به‌روزرسانی لیست نوع خودرو با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isRefreshing: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
  }

  VehicleModelFilterParamEntity _buildFilterParam({
    required int skip,
    required int pageSize,
  }) {
    return VehicleModelFilterParamEntity(
      skip: skip,
      pageSize: pageSize,
      code: state.codeFilter,
      name: state.nameFilter,
      isActive: state.isActiveFilter,
      navganTypeTitle: state.navganTypeTitleFilter,
      hasDepot: state.hasDepotFilter,
    );
  }

  Future<void> applyFilter({
    String? code,
    String? name,
    bool? isActive,
    String? navganTypeTitle,
    bool? hasDepot,
  }) async {
    emit(
      state.copyWith(
        codeFilter: code?.trim(),
        clearCodeFilter: code?.trim().isEmpty ?? true,
        nameFilter: name?.trim(),
        clearNameFilter: name?.trim().isEmpty ?? true,
        isActiveFilter: isActive,
        clearIsActiveFilter: isActive == null,
        navganTypeTitleFilter: navganTypeTitle?.trim(),
        clearNavganTypeTitleFilter:
            navganTypeTitle?.trim().isEmpty ?? true,
        hasDepotFilter: hasDepot,
        clearHasDepotFilter: hasDepot == null,
        records: const [],
        totalCount: 0,
      ),
    );
    await fetchList(reset: true);
  }

  void setPageStatusFilter(bool? value) {
    emit(
      state.copyWith(
        pageStatusFilter: value,
        clearPageStatusFilter: value == null,
      ),
    );
  }

  Future<void> fetchNavgans() async {
    if (state.isNavgansLoading) return;
    emit(state.copyWith(isNavgansLoading: true, clearErrorMessage: true));
    final result = await _getNavgansUseCase();
    result.when(
      success: (items, failures, resultCode) => emit(
        state.copyWith(
          navgans: items,
          isNavgansLoading: false,
          clearErrorMessage: true,
        ),
      ),
      failure: (error, failures) => emit(
        state.copyWith(
          isNavgansLoading: false,
          errorMessage: failures ?? 'دریافت لیست ناوگان با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isNavgansLoading: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isNavgansLoading: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
  }

  Future<bool> submitForm(VehicleModelFormParamEntity param) async {
    if (state.isFormSubmitting) return false;
    emit(
      state.copyWith(
        isFormSubmitting: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result =
        param.id == null ? await _addUseCase(param) : await _updateUseCase(param);
    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            isFormSubmitting: false,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isFormSubmitting: false,
          errorMessage: failures ?? 'ثبت اطلاعات نوع خودرو با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isFormSubmitting: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isFormSubmitting: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
    return success;
  }

  Future<bool> deleteVehicleModel(VehicleModelEntity item) async {
    final id = item.id;
    if (id == null || state.isDeleting) return false;
    emit(
      state.copyWith(
        isDeleting: true,
        deletingId: id,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    var success = false;
    final result = await _deleteUseCase(VehicleModelIdParamEntity(id: id));
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        final records = state.records
            .where((record) => record.id != id)
            .toList(growable: false);
        emit(
          state.copyWith(
            status: records.isEmpty
                ? VehicleModelViewStatus.empty
                : VehicleModelViewStatus.loaded,
            records: records,
            totalCount: math.max(0, state.totalCount - 1),
            isDeleting: false,
            clearDeletingId: true,
            successMessage: 'نوع خودرو حذف شد.',
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isDeleting: false,
          clearDeletingId: true,
          errorMessage: failures ?? 'حذف نوع خودرو با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isDeleting: false,
          clearDeletingId: true,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isDeleting: false,
          clearDeletingId: true,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
    return success;
  }

  Future<List<VehicleServiceGroupEntity>?>
      loadServiceGroupsForNavigation(VehicleModelEntity item) async {
    final id = item.id;
    if (id == null || state.loadingServicesVehicleModelId != null) return null;

    emit(
      state.copyWith(
        loadingServicesVehicleModelId: id,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    List<VehicleServiceGroupEntity>? loadedGroups;
    final result =
        await _getServiceGroupsUseCase(VehicleModelIdParamEntity(id: id));
    result.when(
      success: (items, failures, resultCode) {
        if (items.isEmpty) {
          emit(
            state.copyWith(
              clearLoadingServicesVehicleModelId: true,
              errorMessage: 'سرویسی برای این نوع خودرو یافت نشد.',
            ),
          );
          return;
        }
        loadedGroups = items;
        emit(
          state.copyWith(
            clearLoadingServicesVehicleModelId: true,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          clearLoadingServicesVehicleModelId: true,
          errorMessage: failures ?? 'دریافت سرویس‌ها با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          clearLoadingServicesVehicleModelId: true,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          clearLoadingServicesVehicleModelId: true,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
    return loadedGroups;
  }

  void initializeServices(
    VehicleModelEntity item,
    List<VehicleServiceGroupEntity> groups,
  ) {
    emit(
      state.copyWith(
        selectedVehicleModel: item,
        serviceGroups: groups,
        defects: const [],
        isServiceGroupsLoading: false,
        clearSelectedServiceCategory: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
  }

  Future<bool> fetchServiceGroups(VehicleModelEntity item) async {
    final id = item.id;
    if (id == null || state.isServiceGroupsLoading) return false;
    emit(
      state.copyWith(
        selectedVehicleModel: item,
        isServiceGroupsLoading: true,
        clearErrorMessage: true,
      ),
    );

    var success = false;
    final result =
        await _getServiceGroupsUseCase(VehicleModelIdParamEntity(id: id));
    result.when(
      success: (items, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            serviceGroups: items,
            isServiceGroupsLoading: false,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isServiceGroupsLoading: false,
          errorMessage: failures ?? 'دریافت سرویس‌ها با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isServiceGroupsLoading: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isServiceGroupsLoading: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
    return success;
  }

  void toggleServiceCategory(EmdadServiceCategoryEntity category) {
    if (state.isServicesSubmitting) return;
    final groups = state.serviceGroups.map((group) {
      final categories = group.emdadCategories.map((item) {
        if (item.id != category.id) return item;
        return item.copyWith(selected: !item.selected);
      }).toList(growable: false);
      return group.copyWith(emdadCategories: categories);
    }).toList(growable: false);
    emit(state.copyWith(serviceGroups: groups));
  }

  Future<bool> submitServiceCategories() async {
    final vehicleModelId = state.selectedVehicleModel?.id;
    if (vehicleModelId == null || state.isServicesSubmitting) return false;

    final ids = state.serviceGroups
        .expand((group) => group.emdadCategories)
        .where((item) => item.selected && item.id != null)
        .map((item) => item.id!)
        .toList(growable: false);

    emit(
      state.copyWith(
        isServicesSubmitting: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result = await _submitServiceCategoriesUseCase(
      VehicleModelIdsPayloadParamEntity(
        vehicleModelId: vehicleModelId,
        ids: ids,
      ),
    );
    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            isServicesSubmitting: false,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isServicesSubmitting: false,
          errorMessage: failures ?? 'ثبت سرویس‌ها با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isServicesSubmitting: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isServicesSubmitting: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
    return success;
  }

  Future<bool> loadDefects(EmdadServiceCategoryEntity category) async {
    final vehicleModelId = state.selectedVehicleModel?.id;
    final serviceCategoryId = category.id;
    if (vehicleModelId == null ||
        serviceCategoryId == null ||
        !category.selected ||
        state.isDefectsLoading ||
        state.isDefectsSubmitting) {
      return false;
    }

    emit(
      state.copyWith(
        selectedServiceCategory: category,
        defects: const [],
        isDefectsLoading: true,
        loadingDefectServiceCategoryId: serviceCategoryId,
        clearErrorMessage: true,
      ),
    );

    final result = await _getDefectsUseCase(
      VehicleModelServiceCategoryParamEntity(
        vehicleModelId: vehicleModelId,
        serviceCategoryId: serviceCategoryId,
      ),
    );
    var success = false;
    result.when(
      success: (items, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            defects: items,
            isDefectsLoading: false,
            clearLoadingDefectServiceCategoryId: true,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isDefectsLoading: false,
          clearLoadingDefectServiceCategoryId: true,
          errorMessage: failures ?? 'دریافت ایرادات با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isDefectsLoading: false,
          clearLoadingDefectServiceCategoryId: true,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isDefectsLoading: false,
          clearLoadingDefectServiceCategoryId: true,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
    return success;
  }

  void toggleDefect(int? id) {
    if (state.isDefectsSubmitting) return;
    final defects = state.defects.map((item) {
      if (item.id != id) return item;
      return item.copyWith(selected: !item.selected);
    }).toList(growable: false);
    emit(state.copyWith(defects: defects));
  }

  Future<bool> submitDefects() async {
    final vehicleModelId = state.selectedVehicleModel?.id;
    final serviceCategoryId = state.selectedServiceCategory?.id;
    if (vehicleModelId == null ||
        serviceCategoryId == null ||
        state.isDefectsSubmitting) {
      return false;
    }

    final ids = state.defects
        .where((item) => item.selected && item.id != null)
        .map((item) => item.id!)
        .toList(growable: false);

    emit(
      state.copyWith(
        isDefectsSubmitting: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result = await _submitDefectsUseCase(
      VehicleModelIdsPayloadParamEntity(
        vehicleModelId: vehicleModelId,
        serviceCategoryId: serviceCategoryId,
        ids: ids,
      ),
    );
    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(
          state.copyWith(
            isDefectsSubmitting: false,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => emit(
        state.copyWith(
          isDefectsSubmitting: false,
          errorMessage: failures ?? 'ثبت ایرادات با خطا مواجه شد.',
        ),
      ),
      expireToken: () => emit(
        state.copyWith(
          isDefectsSubmitting: false,
          errorMessage: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () => emit(
        state.copyWith(
          isDefectsSubmitting: false,
          errorMessage: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
    return success;
  }

  void clearErrorMessage() {
    if (state.errorMessage == null) return;
    emit(state.copyWith(clearErrorMessage: true));
  }

  void clearSuccessMessage() {
    if (state.successMessage == null) return;
    emit(state.copyWith(clearSuccessMessage: true));
  }
}
