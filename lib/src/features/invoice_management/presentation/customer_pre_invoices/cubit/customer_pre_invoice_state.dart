part of 'customer_pre_invoice_cubit.dart';

enum CustomerPreInvoiceViewStatus {
  initial,
  initialLoading,
  loaded,
  loadingMore,
  reportLoading,
  reportSuccess,
  error,
  connectionError,
}

class CustomerPreInvoiceState {
  const CustomerPreInvoiceState({
    this.status = CustomerPreInvoiceViewStatus.initial,
    this.items = const [],
    this.totalCount = 0,
    this.hasMore = false,
    this.isInitialLoading = false,
    this.isPaginationLoading = false,
    this.isReportLoading = false,
    this.categories = const [],
    this.filter = const InvoiceListFilterParamEntity(
      serviceType: ServiceType.reliefService,
      pageSize: CustomerPreInvoiceCubit.pageSize,
      skip: 0,
    ),
    this.errorMessage,
    this.successMessage,
  });

  final CustomerPreInvoiceViewStatus status;
  final List<InvoiceRecordEntity> items;
  final int totalCount;
  final bool hasMore;
  final bool isInitialLoading;
  final bool isPaginationLoading;
  final bool isReportLoading;
  final List<EmdadServiceCategoryEntity> categories;
  final InvoiceListFilterParamEntity filter;
  final String? errorMessage;
  final String? successMessage;

  int? get selectedStatus => filter.invoiceStatus;

  CustomerPreInvoiceState copyWith({
    CustomerPreInvoiceViewStatus? status,
    List<InvoiceRecordEntity>? items,
    int? totalCount,
    bool? hasMore,
    bool? isInitialLoading,
    bool? isPaginationLoading,
    bool? isReportLoading,
    List<EmdadServiceCategoryEntity>? categories,
    InvoiceListFilterParamEntity? filter,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
  }) {
    return CustomerPreInvoiceState(
      status: status ?? this.status,
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isPaginationLoading:
          isPaginationLoading ?? this.isPaginationLoading,
      isReportLoading: isReportLoading ?? this.isReportLoading,
      categories: categories ?? this.categories,
      filter: filter ?? this.filter,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
    );
  }
}
