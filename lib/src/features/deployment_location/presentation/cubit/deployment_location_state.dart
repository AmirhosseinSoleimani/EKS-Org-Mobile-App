import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';

enum DeploymentLocationViewStatus {
  initial,
  loading,
  loaded,
  empty,
  failure,
  connectionError,
}

class DeploymentLocationState {
  const DeploymentLocationState({
    this.status = DeploymentLocationViewStatus.initial,
    this.records = const [],
    this.provinceCities = const [],
    this.formLocation,
    this.titleFilter,
    this.provinceTitleFilter,
    this.cityTitleFilter,
    this.addressFilter,
    this.isActiveFilter,
    this.pageStatusFilter,
    this.skip = 0,
    this.pageSize = 10,
    this.totalCount = 0,
    this.errorMessage,
    this.successMessage,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.isDeleting = false,
    this.deletingId,
    this.isReportLoading = false,
    this.isAreasLoading = false,
    this.isFormLoading = false,
    this.formLoadFailed = false,
    this.isFormSubmitting = false,
  });

  final DeploymentLocationViewStatus status;
  final List<DeploymentLocationEntity> records;
  final List<ProvinceEntity> provinceCities;
  final DeploymentLocationEntity? formLocation;
  final String? titleFilter;
  final String? provinceTitleFilter;
  final String? cityTitleFilter;
  final String? addressFilter;
  final bool? isActiveFilter;
  final bool? pageStatusFilter;
  final int skip;
  final int pageSize;
  final int totalCount;
  final String? errorMessage;
  final String? successMessage;
  final bool isLoadingMore;
  final bool isRefreshing;
  final bool isDeleting;
  final int? deletingId;
  final bool isReportLoading;
  final bool isAreasLoading;
  final bool isFormLoading;
  final bool formLoadFailed;
  final bool isFormSubmitting;

  bool get isInitialLoading =>
      status == DeploymentLocationViewStatus.loading && records.isEmpty;

  bool get canLoadMore =>
      !isLoadingMore &&
      !isRefreshing &&
      records.isNotEmpty &&
      records.length < totalCount;

  List<DeploymentLocationEntity> get visibleRecords {
    final localStatus = pageStatusFilter;
    if (localStatus == null) return records;
    return records
        .where((item) => item.isActive == localStatus)
        .toList(growable: false);
  }

  DeploymentLocationState copyWith({
    DeploymentLocationViewStatus? status,
    List<DeploymentLocationEntity>? records,
    List<ProvinceEntity>? provinceCities,
    DeploymentLocationEntity? formLocation,
    bool clearFormLocation = false,
    String? titleFilter,
    bool clearTitleFilter = false,
    String? provinceTitleFilter,
    bool clearProvinceTitleFilter = false,
    String? cityTitleFilter,
    bool clearCityTitleFilter = false,
    String? addressFilter,
    bool clearAddressFilter = false,
    bool? isActiveFilter,
    bool clearIsActiveFilter = false,
    bool? pageStatusFilter,
    bool clearPageStatusFilter = false,
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
    bool? isReportLoading,
    bool? isAreasLoading,
    bool? isFormLoading,
    bool? formLoadFailed,
    bool? isFormSubmitting,
  }) {
    return DeploymentLocationState(
      status: status ?? this.status,
      records: records ?? this.records,
      provinceCities: provinceCities ?? this.provinceCities,
      formLocation:
          clearFormLocation ? null : formLocation ?? this.formLocation,
      titleFilter:
          clearTitleFilter ? null : titleFilter ?? this.titleFilter,
      provinceTitleFilter: clearProvinceTitleFilter
          ? null
          : provinceTitleFilter ?? this.provinceTitleFilter,
      cityTitleFilter:
          clearCityTitleFilter ? null : cityTitleFilter ?? this.cityTitleFilter,
      addressFilter:
          clearAddressFilter ? null : addressFilter ?? this.addressFilter,
      isActiveFilter:
          clearIsActiveFilter ? null : isActiveFilter ?? this.isActiveFilter,
      pageStatusFilter: clearPageStatusFilter
          ? null
          : pageStatusFilter ?? this.pageStatusFilter,
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
      isReportLoading: isReportLoading ?? this.isReportLoading,
      isAreasLoading: isAreasLoading ?? this.isAreasLoading,
      isFormLoading: isFormLoading ?? this.isFormLoading,
      formLoadFailed: formLoadFailed ?? this.formLoadFailed,
      isFormSubmitting: isFormSubmitting ?? this.isFormSubmitting,
    );
  }
}
