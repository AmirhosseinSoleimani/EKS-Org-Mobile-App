import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_target_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';

enum GeneralContentViewStatus {
  initial,
  loading,
  loaded,
  empty,
  failure,
  connectionError,
}

enum GeneralContentStatusFilter {
  all,
  active,
  inactive,
}

class GeneralContentState {
  const GeneralContentState({
    this.status = GeneralContentViewStatus.initial,
    this.targetStatus = GeneralContentViewStatus.initial,
    this.records = const [],
    this.targets = const [],
    this.contentTypeOptions = const [],
    this.receiverTypeOptions = const [],
    this.targetTypeOptions = const [],
    this.targetBoundaryTypeOptions = const [],
    this.logicalOperatorTypeOptions = const [],
    this.targetCategoryOptions = const [],
    this.titleFilter,
    this.contentTypeFilter,
    this.statusFilter = GeneralContentStatusFilter.all,
    this.skip = 0,
    this.pageSize = 10,
    this.totalCount = 0,
    this.selectedContent,
    this.errorMessage,
    this.successMessage,
    this.isLoadingMore = false,
    this.isDeleting = false,
    this.isSubmitting = false,
    this.deletingId,
  });

  final GeneralContentViewStatus status;
  final GeneralContentViewStatus targetStatus;
  final List<GeneralContentEntity> records;
  final List<GeneralContentTargetEntity> targets;
  final List<CurrentSessionEnumItemEntity> contentTypeOptions;
  final List<CurrentSessionEnumItemEntity> receiverTypeOptions;
  final List<CurrentSessionEnumItemEntity> targetTypeOptions;
  final List<CurrentSessionEnumItemEntity> targetBoundaryTypeOptions;
  final List<CurrentSessionEnumItemEntity> logicalOperatorTypeOptions;
  final List<CurrentSessionEnumItemEntity> targetCategoryOptions;
  final String? titleFilter;
  final CurrentSessionEnumItemEntity? contentTypeFilter;
  final GeneralContentStatusFilter statusFilter;
  final int skip;
  final int pageSize;
  final int totalCount;
  final GeneralContentEntity? selectedContent;
  final String? errorMessage;
  final String? successMessage;
  final bool isLoadingMore;
  final bool isDeleting;
  final bool isSubmitting;
  final int? deletingId;

  bool get isInitialLoading =>
      status == GeneralContentViewStatus.loading && records.isEmpty;

  bool get canLoadMore =>
      !isLoadingMore && records.length < totalCount && records.isNotEmpty;

  List<GeneralContentEntity> get visibleRecords {
    switch (statusFilter) {
      case GeneralContentStatusFilter.active:
        return records.where((item) => item.isActive == true).toList();
      case GeneralContentStatusFilter.inactive:
        return records.where((item) => item.isActive == false).toList();
      case GeneralContentStatusFilter.all:
        return records;
    }
  }

  String get statusFilterTitle {
    switch (statusFilter) {
      case GeneralContentStatusFilter.active:
        return 'فعال';
      case GeneralContentStatusFilter.inactive:
        return 'غیرفعال';
      case GeneralContentStatusFilter.all:
        return 'وضعیت';
    }
  }

  GeneralContentState copyWith({
    GeneralContentViewStatus? status,
    GeneralContentViewStatus? targetStatus,
    List<GeneralContentEntity>? records,
    List<GeneralContentTargetEntity>? targets,
    List<CurrentSessionEnumItemEntity>? contentTypeOptions,
    List<CurrentSessionEnumItemEntity>? receiverTypeOptions,
    List<CurrentSessionEnumItemEntity>? targetTypeOptions,
    List<CurrentSessionEnumItemEntity>? targetBoundaryTypeOptions,
    List<CurrentSessionEnumItemEntity>? logicalOperatorTypeOptions,
    List<CurrentSessionEnumItemEntity>? targetCategoryOptions,
    String? titleFilter,
    bool clearTitleFilter = false,
    CurrentSessionEnumItemEntity? contentTypeFilter,
    bool clearContentTypeFilter = false,
    GeneralContentStatusFilter? statusFilter,
    int? skip,
    int? pageSize,
    int? totalCount,
    GeneralContentEntity? selectedContent,
    bool clearSelectedContent = false,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    bool? isLoadingMore,
    bool? isDeleting,
    bool? isSubmitting,
    int? deletingId,
    bool clearDeletingId = false,
  }) {
    return GeneralContentState(
      status: status ?? this.status,
      targetStatus: targetStatus ?? this.targetStatus,
      records: records ?? this.records,
      targets: targets ?? this.targets,
      contentTypeOptions: contentTypeOptions ?? this.contentTypeOptions,
      receiverTypeOptions: receiverTypeOptions ?? this.receiverTypeOptions,
      targetTypeOptions: targetTypeOptions ?? this.targetTypeOptions,
      targetBoundaryTypeOptions:
          targetBoundaryTypeOptions ?? this.targetBoundaryTypeOptions,
      logicalOperatorTypeOptions:
          logicalOperatorTypeOptions ?? this.logicalOperatorTypeOptions,
      targetCategoryOptions:
          targetCategoryOptions ?? this.targetCategoryOptions,
      titleFilter: clearTitleFilter ? null : titleFilter ?? this.titleFilter,
      contentTypeFilter: clearContentTypeFilter
          ? null
          : contentTypeFilter ?? this.contentTypeFilter,
      statusFilter: statusFilter ?? this.statusFilter,
      skip: skip ?? this.skip,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      selectedContent: clearSelectedContent
          ? null
          : selectedContent ?? this.selectedContent,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isDeleting: isDeleting ?? this.isDeleting,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      deletingId: clearDeletingId ? null : deletingId ?? this.deletingId,
    );
  }
}
