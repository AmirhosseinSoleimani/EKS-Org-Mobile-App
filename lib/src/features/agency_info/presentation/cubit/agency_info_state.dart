part of 'agency_info_cubit.dart';

enum AgencyInfoViewStatus {
  initial,
  initialLoading,
  loaded,
  empty,
  pageError,
  connectionError,
  filterLoading,
  loadingMore,
  reportLoading,
  reportSuccess,
  actionLoading,
  actionDataLoaded,
  actionError,
  selectorLoading,
}

enum AgencyInfoActionType {
  contracts,
  activeReliefWorkers,
  activeVehicles,
  changeStatus,
  serviceType,
  complementaryInfo,
  history,
  delete,
}

class AgencyInfoStateData {
  const AgencyInfoStateData({
    this.items = const [],
    this.selectorItems = const [],
    this.selectedAgency,
    this.actionAgency,
    this.actionType,
    this.actionData,
    this.filter = const AgencyInfoFilterParamEntity(),
    this.totalCount = 0,
    this.hasMore = true,
    this.isInitialLoading = false,
    this.isRefreshing = false,
    this.isPaginationLoading = false,
    this.isSelectorLoading = false,
    this.isReportLoading = false,
    this.loadingDetailId,
    this.reportFilePath,
    this.selectorSearchText = '',
    this.errorMessage,
    this.successMessage,
  });

  final List<AgencyInfoEntity> items;
  final List<AgencyInfoEntity> selectorItems;
  final AgencyInfoEntity? selectedAgency;
  final AgencyInfoEntity? actionAgency;
  final AgencyInfoActionType? actionType;
  final Object? actionData;
  final AgencyInfoFilterParamEntity filter;
  final int totalCount;
  final bool hasMore;
  final bool isInitialLoading;
  final bool isRefreshing;
  final bool isPaginationLoading;
  final bool isSelectorLoading;
  final bool isReportLoading;
  final int? loadingDetailId;
  final String? reportFilePath;
  final String selectorSearchText;
  final String? errorMessage;
  final String? successMessage;

  bool get hasActiveFilter {
    return [
      filter.name,
      filter.code,
      filter.managerFullName,
      filter.provinceTitle,
      filter.cityTitle,
      filter.mobileNumber,
    ].any((item) => item?.trim().isNotEmpty == true) ||
        filter.isActive != null;
  }

  AgencyInfoStateData copyWith({
    List<AgencyInfoEntity>? items,
    List<AgencyInfoEntity>? selectorItems,
    AgencyInfoEntity? selectedAgency,
    bool clearSelectedAgency = false,
    AgencyInfoEntity? actionAgency,
    bool clearActionAgency = false,
    AgencyInfoActionType? actionType,
    bool clearActionType = false,
    Object? actionData,
    bool clearActionData = false,
    AgencyInfoFilterParamEntity? filter,
    int? totalCount,
    bool? hasMore,
    bool? isInitialLoading,
    bool? isRefreshing,
    bool? isPaginationLoading,
    bool? isSelectorLoading,
    bool? isReportLoading,
    int? loadingDetailId,
    bool clearLoadingDetailId = false,
    String? reportFilePath,
    bool clearReportFilePath = false,
    String? selectorSearchText,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
  }) {
    return AgencyInfoStateData(
      items: items ?? this.items,
      selectorItems: selectorItems ?? this.selectorItems,
      selectedAgency:
          clearSelectedAgency ? null : selectedAgency ?? this.selectedAgency,
      actionAgency: clearActionAgency ? null : actionAgency ?? this.actionAgency,
      actionType: clearActionType ? null : actionType ?? this.actionType,
      actionData: clearActionData ? null : actionData ?? this.actionData,
      filter: filter ?? this.filter,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      isSelectorLoading: isSelectorLoading ?? this.isSelectorLoading,
      isReportLoading: isReportLoading ?? this.isReportLoading,
      loadingDetailId:
          clearLoadingDetailId ? null : loadingDetailId ?? this.loadingDetailId,
      reportFilePath:
          clearReportFilePath ? null : reportFilePath ?? this.reportFilePath,
      selectorSearchText: selectorSearchText ?? this.selectorSearchText,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
    );
  }
}

class AgencyInfoState {
  const AgencyInfoState({
    this.status = AgencyInfoViewStatus.initial,
    this.data = const AgencyInfoStateData(),
  });

  final AgencyInfoViewStatus status;
  final AgencyInfoStateData data;

  AgencyInfoState copyWith({
    AgencyInfoViewStatus? status,
    AgencyInfoStateData? data,
  }) {
    return AgencyInfoState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
