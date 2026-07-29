import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_lookup_entity.dart';

const _unset = Object();

enum SpecialPlanViewStatus {
  initial,
  loading,
  loaded,
  empty,
  failure,
  connectionError,
}

class SpecialPlanListState {
  const SpecialPlanListState({
    this.status = SpecialPlanViewStatus.initial,
    this.records = const [],
    this.products = const [],
    this.provinces = const [],
    this.titleFilter,
    this.productIdFilter,
    this.hasHighPriorityFilter,
    this.startDateFilter,
    this.endDateFilter,
    this.orderNoFilter,
    this.provinceTitleFilter,
    this.cityTitleFilter,
    this.isActiveFilter,
    this.onlySaipaCarsFilter,
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
    this.isProductsLoading = false,
    this.isProvincesLoading = false,
  });

  final SpecialPlanViewStatus status;
  final List<SpecialPlanEntity> records;
  final List<SpecialPlanProductEntity> products;
  final List<ProvinceLookupEntity> provinces;
  final String? titleFilter;
  final int? productIdFilter;
  final bool? hasHighPriorityFilter;
  final DateTime? startDateFilter;
  final DateTime? endDateFilter;
  final int? orderNoFilter;
  final String? provinceTitleFilter;
  final String? cityTitleFilter;
  final bool? isActiveFilter;
  final bool? onlySaipaCarsFilter;
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
  final bool isProductsLoading;
  final bool isProvincesLoading;

  bool get isInitialLoading =>
      status == SpecialPlanViewStatus.loading && records.isEmpty;

  bool get canLoadMore =>
      !isLoadingMore &&
      !isRefreshing &&
      records.isNotEmpty &&
      records.length < totalCount;

  List<SpecialPlanEntity> get visibleRecords => records;

  String productTitle(int? productId, {String? fallback}) {
    final fallbackTitle = fallback?.trim();
    if (fallbackTitle?.isNotEmpty == true) return fallbackTitle!;
    if (productId == null) return '---';
    for (final product in products) {
      if (product.id == productId) return product.title;
    }
    return '---';
  }

  SpecialPlanListState copyWith({
    SpecialPlanViewStatus? status,
    List<SpecialPlanEntity>? records,
    List<SpecialPlanProductEntity>? products,
    List<ProvinceLookupEntity>? provinces,
    Object? titleFilter = _unset,
    Object? productIdFilter = _unset,
    Object? hasHighPriorityFilter = _unset,
    Object? startDateFilter = _unset,
    Object? endDateFilter = _unset,
    Object? orderNoFilter = _unset,
    Object? provinceTitleFilter = _unset,
    Object? cityTitleFilter = _unset,
    Object? isActiveFilter = _unset,
    Object? onlySaipaCarsFilter = _unset,
    Object? pageStatusFilter = _unset,
    int? skip,
    int? pageSize,
    int? totalCount,
    Object? errorMessage = _unset,
    Object? successMessage = _unset,
    bool? isLoadingMore,
    bool? isRefreshing,
    bool? isDeleting,
    Object? deletingId = _unset,
    bool? isProductsLoading,
    bool? isProvincesLoading,
  }) {
    return SpecialPlanListState(
      status: status ?? this.status,
      records: records ?? this.records,
      products: products ?? this.products,
      provinces: provinces ?? this.provinces,
      titleFilter: identical(titleFilter, _unset)
          ? this.titleFilter
          : titleFilter as String?,
      productIdFilter: identical(productIdFilter, _unset)
          ? this.productIdFilter
          : productIdFilter as int?,
      hasHighPriorityFilter: identical(hasHighPriorityFilter, _unset)
          ? this.hasHighPriorityFilter
          : hasHighPriorityFilter as bool?,
      startDateFilter: identical(startDateFilter, _unset)
          ? this.startDateFilter
          : startDateFilter as DateTime?,
      endDateFilter: identical(endDateFilter, _unset)
          ? this.endDateFilter
          : endDateFilter as DateTime?,
      orderNoFilter: identical(orderNoFilter, _unset)
          ? this.orderNoFilter
          : orderNoFilter as int?,
      provinceTitleFilter: identical(provinceTitleFilter, _unset)
          ? this.provinceTitleFilter
          : provinceTitleFilter as String?,
      cityTitleFilter: identical(cityTitleFilter, _unset)
          ? this.cityTitleFilter
          : cityTitleFilter as String?,
      isActiveFilter: identical(isActiveFilter, _unset)
          ? this.isActiveFilter
          : isActiveFilter as bool?,
      onlySaipaCarsFilter: identical(onlySaipaCarsFilter, _unset)
          ? this.onlySaipaCarsFilter
          : onlySaipaCarsFilter as bool?,
      pageStatusFilter: identical(pageStatusFilter, _unset)
          ? this.pageStatusFilter
          : pageStatusFilter as bool?,
      skip: skip ?? this.skip,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      successMessage: identical(successMessage, _unset)
          ? this.successMessage
          : successMessage as String?,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isDeleting: isDeleting ?? this.isDeleting,
      deletingId: identical(deletingId, _unset)
          ? this.deletingId
          : deletingId as int?,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      isProvincesLoading: isProvincesLoading ?? this.isProvincesLoading,
    );
  }
}
