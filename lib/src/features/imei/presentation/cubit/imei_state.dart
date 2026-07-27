import 'package:eks_sana_plus_org/src/features/imei/domain/entities/device_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/imei_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/imei/domain/entities/params/imei_info_filter_param_entity.dart';

enum ImeiViewStatus {
  initial,
  loading,
  loaded,
  empty,
  loadingMore,
  failure,
  connectionError,
}

class ImeiState {
  const ImeiState({
    this.status = ImeiViewStatus.initial,
    this.records = const [],
    this.totalCount = 0,
    this.filter = const ImeiInfoFilterParamEntity(),
    this.pageStatusFilter,
    this.deviceTypes = const [],
    this.selectedItem,
    this.selectedFormDevice,
    this.selectedFormStatus = true,
    this.errorMessage,
    this.successMessage,
    this.reportPath,
    this.isDeviceTypesLoading = false,
    this.isGettingDetail = false,
    this.isSubmitting = false,
    this.isDeleting = false,
    this.isReporting = false,
  });

  final ImeiViewStatus status;
  final List<ImeiInfoEntity> records;
  final int totalCount;
  final ImeiInfoFilterParamEntity filter;
  final bool? pageStatusFilter;
  final List<DeviceInfoEntity> deviceTypes;
  final ImeiInfoEntity? selectedItem;
  final DeviceInfoEntity? selectedFormDevice;
  final bool selectedFormStatus;
  final String? errorMessage;
  final String? successMessage;
  final String? reportPath;
  final bool isDeviceTypesLoading;
  final bool isGettingDetail;
  final bool isSubmitting;
  final bool isDeleting;
  final bool isReporting;

  bool get isInitialLoading => status == ImeiViewStatus.loading && records.isEmpty;
  bool get isLoadingMore => status == ImeiViewStatus.loadingMore;
  bool get hasMore => records.length < totalCount;

  List<ImeiInfoEntity> get visibleRecords {
    final localFilter = pageStatusFilter;
    if (localFilter == null) return records;
    return records.where((item) => item.isActive == localFilter).toList();
  }

  ImeiState copyWith({
    ImeiViewStatus? status,
    List<ImeiInfoEntity>? records,
    int? totalCount,
    ImeiInfoFilterParamEntity? filter,
    bool? pageStatusFilter,
    bool clearPageStatusFilter = false,
    List<DeviceInfoEntity>? deviceTypes,
    ImeiInfoEntity? selectedItem,
    bool clearSelectedItem = false,
    DeviceInfoEntity? selectedFormDevice,
    bool clearSelectedFormDevice = false,
    bool? selectedFormStatus,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    String? reportPath,
    bool clearReportPath = false,
    bool? isDeviceTypesLoading,
    bool? isGettingDetail,
    bool? isSubmitting,
    bool? isDeleting,
    bool? isReporting,
  }) {
    return ImeiState(
      status: status ?? this.status,
      records: records ?? this.records,
      totalCount: totalCount ?? this.totalCount,
      filter: filter ?? this.filter,
      pageStatusFilter:
          clearPageStatusFilter ? null : pageStatusFilter ?? this.pageStatusFilter,
      deviceTypes: deviceTypes ?? this.deviceTypes,
      selectedItem: clearSelectedItem ? null : selectedItem ?? this.selectedItem,
      selectedFormDevice: clearSelectedFormDevice
          ? null
          : selectedFormDevice ?? this.selectedFormDevice,
      selectedFormStatus: selectedFormStatus ?? this.selectedFormStatus,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
      reportPath: clearReportPath ? null : reportPath ?? this.reportPath,
      isDeviceTypesLoading: isDeviceTypesLoading ?? this.isDeviceTypesLoading,
      isGettingDetail: isGettingDetail ?? this.isGettingDetail,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isDeleting: isDeleting ?? this.isDeleting,
      isReporting: isReporting ?? this.isReporting,
    );
  }
}
