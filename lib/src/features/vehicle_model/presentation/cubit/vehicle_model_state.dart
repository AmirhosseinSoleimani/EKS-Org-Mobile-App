import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_defect_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_navgan_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_service_group_entity.dart';

enum VehicleModelViewStatus {
  initial,
  loading,
  loaded,
  empty,
  failure,
  connectionError,
}

class VehicleModelState {
  const VehicleModelState({
    this.status = VehicleModelViewStatus.initial,
    this.records = const [],
    this.navgans = const [],
    this.serviceGroups = const [],
    this.defects = const [],
    this.selectedVehicleModel,
    this.selectedServiceCategory,
    this.codeFilter,
    this.nameFilter,
    this.isActiveFilter,
    this.pageStatusFilter,
    this.navganTypeTitleFilter,
    this.hasDepotFilter,
    this.skip = 0,
    this.pageSize = 10,
    this.totalCount = 0,
    this.errorMessage,
    this.successMessage,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.isDeleting = false,
    this.deletingId,
    this.loadingServicesVehicleModelId,
    this.isNavgansLoading = false,
    this.isFormSubmitting = false,
    this.isServiceGroupsLoading = false,
    this.isServicesSubmitting = false,
    this.isDefectsLoading = false,
    this.isDefectsSubmitting = false,
    this.loadingDefectServiceCategoryId,
  });

  final VehicleModelViewStatus status;
  final List<VehicleModelEntity> records;
  final List<VehicleNavganEntity> navgans;
  final List<VehicleServiceGroupEntity> serviceGroups;
  final List<VehicleDefectEntity> defects;
  final VehicleModelEntity? selectedVehicleModel;
  final EmdadServiceCategoryEntity? selectedServiceCategory;
  final String? codeFilter;
  final String? nameFilter;
  final bool? isActiveFilter;
  final bool? pageStatusFilter;
  final String? navganTypeTitleFilter;
  final bool? hasDepotFilter;
  final int skip;
  final int pageSize;
  final int totalCount;
  final String? errorMessage;
  final String? successMessage;
  final bool isLoadingMore;
  final bool isRefreshing;
  final bool isDeleting;
  final int? deletingId;
  final int? loadingServicesVehicleModelId;
  final bool isNavgansLoading;
  final bool isFormSubmitting;
  final bool isServiceGroupsLoading;
  final bool isServicesSubmitting;
  final bool isDefectsLoading;
  final bool isDefectsSubmitting;
  final int? loadingDefectServiceCategoryId;

  bool get isInitialLoading =>
      status == VehicleModelViewStatus.loading && records.isEmpty;

  bool get canLoadMore =>
      !isLoadingMore &&
      !isRefreshing &&
      records.isNotEmpty &&
      records.length < totalCount;

  bool isServicesActionLoading(int? vehicleModelId) =>
      vehicleModelId != null && loadingServicesVehicleModelId == vehicleModelId;

  List<VehicleModelEntity> get visibleRecords {
    final localFilter = pageStatusFilter;
    if (localFilter == null) return records;
    return records.where((item) => item.isActive == localFilter).toList();
  }

  VehicleModelState copyWith({
    VehicleModelViewStatus? status,
    List<VehicleModelEntity>? records,
    List<VehicleNavganEntity>? navgans,
    List<VehicleServiceGroupEntity>? serviceGroups,
    List<VehicleDefectEntity>? defects,
    VehicleModelEntity? selectedVehicleModel,
    bool clearSelectedVehicleModel = false,
    EmdadServiceCategoryEntity? selectedServiceCategory,
    bool clearSelectedServiceCategory = false,
    String? codeFilter,
    bool clearCodeFilter = false,
    String? nameFilter,
    bool clearNameFilter = false,
    bool? isActiveFilter,
    bool clearIsActiveFilter = false,
    bool? pageStatusFilter,
    bool clearPageStatusFilter = false,
    String? navganTypeTitleFilter,
    bool clearNavganTypeTitleFilter = false,
    bool? hasDepotFilter,
    bool clearHasDepotFilter = false,
    int? skip,
    int? pageSize,
    int? totalCount,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    bool? isLoadingMore,
    bool? isRefreshing,
    bool? isDeleting,
    int? deletingId,
    bool clearDeletingId = false,
    int? loadingServicesVehicleModelId,
    bool clearLoadingServicesVehicleModelId = false,
    bool? isNavgansLoading,
    bool? isFormSubmitting,
    bool? isServiceGroupsLoading,
    bool? isServicesSubmitting,
    bool? isDefectsLoading,
    bool? isDefectsSubmitting,
    int? loadingDefectServiceCategoryId,
    bool clearLoadingDefectServiceCategoryId = false,
  }) {
    return VehicleModelState(
      status: status ?? this.status,
      records: records ?? this.records,
      navgans: navgans ?? this.navgans,
      serviceGroups: serviceGroups ?? this.serviceGroups,
      defects: defects ?? this.defects,
      selectedVehicleModel: clearSelectedVehicleModel
          ? null
          : selectedVehicleModel ?? this.selectedVehicleModel,
      selectedServiceCategory: clearSelectedServiceCategory
          ? null
          : selectedServiceCategory ?? this.selectedServiceCategory,
      codeFilter: clearCodeFilter ? null : codeFilter ?? this.codeFilter,
      nameFilter: clearNameFilter ? null : nameFilter ?? this.nameFilter,
      isActiveFilter:
          clearIsActiveFilter ? null : isActiveFilter ?? this.isActiveFilter,
      pageStatusFilter: clearPageStatusFilter
          ? null
          : pageStatusFilter ?? this.pageStatusFilter,
      navganTypeTitleFilter: clearNavganTypeTitleFilter
          ? null
          : navganTypeTitleFilter ?? this.navganTypeTitleFilter,
      hasDepotFilter:
          clearHasDepotFilter ? null : hasDepotFilter ?? this.hasDepotFilter,
      skip: skip ?? this.skip,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isDeleting: isDeleting ?? this.isDeleting,
      deletingId: clearDeletingId ? null : deletingId ?? this.deletingId,
      loadingServicesVehicleModelId: clearLoadingServicesVehicleModelId
          ? null
          : loadingServicesVehicleModelId ??
              this.loadingServicesVehicleModelId,
      isNavgansLoading: isNavgansLoading ?? this.isNavgansLoading,
      isFormSubmitting: isFormSubmitting ?? this.isFormSubmitting,
      isServiceGroupsLoading:
          isServiceGroupsLoading ?? this.isServiceGroupsLoading,
      isServicesSubmitting: isServicesSubmitting ?? this.isServicesSubmitting,
      isDefectsLoading: isDefectsLoading ?? this.isDefectsLoading,
      isDefectsSubmitting: isDefectsSubmitting ?? this.isDefectsSubmitting,
      loadingDefectServiceCategoryId: clearLoadingDefectServiceCategoryId
          ? null
          : loadingDefectServiceCategoryId ??
              this.loadingDefectServiceCategoryId,
    );
  }
}
