import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_form_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_id_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_ids_payload_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/params/vehicle_model_service_category_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
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
  final SubmitVehicleServiceCategoriesUseCase _submitServiceCategoriesUseCase;
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
    if (state.isInitialLoading || state.isLoadingMore) return;
    final nextSkip = reset ? 0 : state.records.length;
    emit(state.copyWith(
      status: reset ? VehicleModelViewStatus.loading : state.status,
      isLoadingMore: !reset,
      skip: nextSkip,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));

    final result = await _getListUseCase(
      VehicleModelFilterParamEntity(
        skip: nextSkip,
        pageSize: state.pageSize,
        code: state.codeFilter,
        name: state.nameFilter,
        isActive: state.isActiveFilter,
        navganTypeTitle: state.navganTypeTitleFilter,
        hasDepot: state.hasDepotFilter,
      ),
    );

    result.when(
      success: (page, failures, resultCode) {
        final records = reset
            ? page.records
            : <VehicleModelEntity>[...state.records, ...page.records];
        emit(state.copyWith(
          status: records.isEmpty
              ? VehicleModelViewStatus.empty
              : VehicleModelViewStatus.loaded,
          records: records,
          totalCount: page.count,
          isLoadingMore: false,
          clearErrorMessage: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        status: reset ? VehicleModelViewStatus.failure : state.status,
        isLoadingMore: false,
        errorMessage: failures ?? 'دریافت لیست نوع خودرو با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        status: reset ? VehicleModelViewStatus.failure : state.status,
        isLoadingMore: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        status: reset ? VehicleModelViewStatus.connectionError : state.status,
        isLoadingMore: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  Future<void> applyFilter({
    String? code,
    String? name,
    bool? isActive,
    String? navganTypeTitle,
    bool? hasDepot,
  }) async {
    emit(state.copyWith(
      codeFilter: code?.trim(),
      clearCodeFilter: code?.trim().isEmpty ?? true,
      nameFilter: name?.trim(),
      clearNameFilter: name?.trim().isEmpty ?? true,
      isActiveFilter: isActive,
      clearIsActiveFilter: isActive == null,
      navganTypeTitleFilter: navganTypeTitle?.trim(),
      clearNavganTypeTitleFilter: navganTypeTitle?.trim().isEmpty ?? true,
      hasDepotFilter: hasDepot,
      clearHasDepotFilter: hasDepot == null,
      records: const [],
      totalCount: 0,
    ));
    await fetchList(reset: true);
  }

  void setPageStatusFilter(bool? value) {
    emit(state.copyWith(
      pageStatusFilter: value,
      clearPageStatusFilter: value == null,
    ));
  }

  Future<void> fetchNavgans() async {
    if (state.isNavgansLoading) return;
    emit(state.copyWith(isNavgansLoading: true, clearErrorMessage: true));
    final result = await _getNavgansUseCase();
    result.when(
      success: (items, failures, resultCode) => emit(state.copyWith(
        navgans: items,
        isNavgansLoading: false,
        clearErrorMessage: true,
      )),
      failure: (error, failures) => emit(state.copyWith(
        isNavgansLoading: false,
        errorMessage: failures ?? 'دریافت لیست ناوگان با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isNavgansLoading: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isNavgansLoading: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  Future<bool> submitForm(VehicleModelFormParamEntity param) async {
    if (state.isFormSubmitting) return false;
    emit(state.copyWith(isFormSubmitting: true, clearErrorMessage: true));
    final result =
        param.id == null ? await _addUseCase(param) : await _updateUseCase(param);
    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(
          isFormSubmitting: false,
          successMessage:
              param.id == null ? 'نوع خودرو ثبت شد.' : 'نوع خودرو ویرایش شد.',
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isFormSubmitting: false,
        errorMessage: failures ?? 'ثبت اطلاعات نوع خودرو با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isFormSubmitting: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isFormSubmitting: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
    if (success) await fetchList(reset: true);
    return success;
  }

  Future<bool> deleteVehicleModel(VehicleModelEntity item) async {
    final id = item.id;
    if (id == null || state.isDeleting) return false;
    emit(state.copyWith(
      isDeleting: true,
      deletingId: id,
      clearErrorMessage: true,
      clearSuccessMessage: true,
    ));
    var success = false;
    final result = await _deleteUseCase(VehicleModelIdParamEntity(id: id));
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(
          isDeleting: false,
          clearDeletingId: true,
          successMessage: 'نوع خودرو حذف شد.',
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isDeleting: false,
        clearDeletingId: true,
        errorMessage: failures ?? 'حذف نوع خودرو با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isDeleting: false,
        clearDeletingId: true,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isDeleting: false,
        clearDeletingId: true,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
    if (success) await fetchList(reset: true);
    return success;
  }

  Future<void> prepareServices(VehicleModelEntity item) async {
    emit(state.copyWith(
      selectedVehicleModel: item,
      serviceGroups: const [],
      defects: const [],
      clearSelectedServiceCategory: true,
    ));
    await fetchServiceGroups(item);
  }

  Future<void> fetchServiceGroups(VehicleModelEntity item) async {
    final id = item.id;
    if (id == null || state.isServiceGroupsLoading) return;
    emit(state.copyWith(isServiceGroupsLoading: true, clearErrorMessage: true));
    final result = await _getServiceGroupsUseCase(VehicleModelIdParamEntity(id: id));
    result.when(
      success: (items, failures, resultCode) => emit(state.copyWith(
        serviceGroups: items,
        isServiceGroupsLoading: false,
        clearErrorMessage: true,
      )),
      failure: (error, failures) => emit(state.copyWith(
        isServiceGroupsLoading: false,
        errorMessage: failures ?? 'دریافت سرویس‌ها با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isServiceGroupsLoading: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isServiceGroupsLoading: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
  }

  void toggleServiceCategory(EmdadServiceCategoryEntity category) {
    final groups = state.serviceGroups.map((group) {
      final categories = group.emdadCategories.map((item) {
        if (item.id != category.id) return item;
        return item.copyWith(selected: !item.selected);
      }).toList();
      return group.copyWith(emdadCategories: categories);
    }).toList();
    emit(state.copyWith(serviceGroups: groups));
  }

  Future<bool> submitServiceCategories() async {
    final vehicleModelId = state.selectedVehicleModel?.id;
    if (vehicleModelId == null || state.isServicesSubmitting) return false;
    final ids = state.serviceGroups
        .expand((group) => group.emdadCategories)
        .where((item) => item.selected && item.id != null)
        .map((item) => item.id!)
        .toList();
    emit(state.copyWith(isServicesSubmitting: true, clearErrorMessage: true));
    final result = await _submitServiceCategoriesUseCase(
      VehicleModelIdsPayloadParamEntity(vehicleModelId: vehicleModelId, ids: ids),
    );
    var success = false;
    result.when(
      success: (data, failures, resultCode) {
        success = true;
        emit(state.copyWith(
          isServicesSubmitting: false,
          successMessage: 'سرویس‌های نوع خودرو ثبت شد.',
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isServicesSubmitting: false,
        errorMessage: failures ?? 'ثبت سرویس‌ها با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isServicesSubmitting: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isServicesSubmitting: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
    return success;
  }

  Future<bool> loadDefects(EmdadServiceCategoryEntity category) async {
    final vehicleModelId = state.selectedVehicleModel?.id;
    final serviceCategoryId = category.id;
    if (vehicleModelId == null || serviceCategoryId == null) return false;
    emit(state.copyWith(
      selectedServiceCategory: category,
      defects: const [],
      isDefectsLoading: true,
      loadingDefectServiceCategoryId: serviceCategoryId,
    ));
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
        emit(state.copyWith(
          defects: items,
          isDefectsLoading: false,
          clearLoadingDefectServiceCategoryId: true,
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isDefectsLoading: false,
        clearLoadingDefectServiceCategoryId: true,
        errorMessage: failures ?? 'دریافت ایرادات با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isDefectsLoading: false,
        clearLoadingDefectServiceCategoryId: true,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isDefectsLoading: false,
        clearLoadingDefectServiceCategoryId: true,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
    return success;
  }

  void toggleDefect(int? id) {
    final defects = state.defects.map((item) {
      if (item.id != id) return item;
      return item.copyWith(selected: !item.selected);
    }).toList();
    emit(state.copyWith(defects: defects));
  }

  Future<bool> submitDefects() async {
    final vehicleModelId = state.selectedVehicleModel?.id;
    final serviceCategoryId = state.selectedServiceCategory?.id;
    if (vehicleModelId == null || serviceCategoryId == null) return false;
    final ids = state.defects
        .where((item) => item.selected && item.id != null)
        .map((item) => item.id!)
        .toList();
    emit(state.copyWith(isDefectsSubmitting: true, clearErrorMessage: true));
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
        emit(state.copyWith(
          isDefectsSubmitting: false,
          successMessage: 'ایرادات سرویس ثبت شد.',
        ));
      },
      failure: (error, failures) => emit(state.copyWith(
        isDefectsSubmitting: false,
        errorMessage: failures ?? 'ثبت ایرادات با خطا مواجه شد.',
      )),
      expireToken: () => emit(state.copyWith(
        isDefectsSubmitting: false,
        errorMessage: 'نشست کاربری منقضی شده است.',
      )),
      connectionError: () => emit(state.copyWith(
        isDefectsSubmitting: false,
        errorMessage: 'اتصال به اینترنت برقرار نیست.',
      )),
    );
    return success;
  }
}
