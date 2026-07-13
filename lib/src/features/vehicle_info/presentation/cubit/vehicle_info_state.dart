part of 'vehicle_info_cubit.dart';

@freezed
abstract class VehicleInfoStateData with _$VehicleInfoStateData {
  const factory VehicleInfoStateData({
    @Default([]) List<VehicleInfoEntity> items,
    @Default([]) List<VehicleModelEntity> vehicleModels,
    @Default([]) List<VehicleToolEntity> tools,
    @Default([]) List<VehicleToolEntity> filteredTools,
    @Default([]) List<EmdadServiceCategoryGroupEntity> serviceCategoryGroups,
    @Default([]) List<VehicleDefectLimitationEntity> defects,
    VehicleInfoEntity? selectedItem,
    @Default(VehicleInfoFilterParamEntity()) VehicleInfoFilterParamEntity filter,
    @Default(0) int totalCount,
    @Default(true) bool hasMore,
    @Default(false) bool isInitialLoading,
    @Default(false) bool isRefreshing,
    @Default(false) bool isPaginationLoading,
    @Default(false) bool isLookupsLoading,
    @Default(false) bool isSubmitting,
    @Default(false) bool isReportLoading,
    int? loadingDetailId,
    int? deletingVehicleId,
    int? loadingToolsVehicleId,
    int? loadingServicesVehicleId,
    int? loadingDefectsServiceCategoryId,
    int? selectedServiceCategoryId,
    @Default('') String toolsSearchText,
    String? reportFilePath,
    String? successMessage,
    String? errorMessage,
  }) = _VehicleInfoStateData;
}

@freezed
abstract class VehicleInfoState with _$VehicleInfoState {
  const factory VehicleInfoState.idle({
    @Default(VehicleInfoStateData()) VehicleInfoStateData data,
  }) = _Idle;

  const factory VehicleInfoState.loading({required VehicleInfoStateData data}) = _Loading;
  const factory VehicleInfoState.loaded({required VehicleInfoStateData data}) = _Loaded;
  const factory VehicleInfoState.success({required VehicleInfoStateData data}) = _Success;
  const factory VehicleInfoState.failure({required VehicleInfoStateData data}) = _Failure;
  const factory VehicleInfoState.connectionError({required VehicleInfoStateData data}) = _ConnectionError;
}

extension VehicleInfoStateX on VehicleInfoState {
  VehicleInfoStateData get data {
    return when(
      idle: (data) => data,
      loading: (data) => data,
      loaded: (data) => data,
      success: (data) => data,
      failure: (data) => data,
      connectionError: (data) => data,
    );
  }
}
