part of 'customer_pre_invoice_cubit.dart';

enum CustomerPreInvoiceViewStatus {
  initial,
  initialLoading,
  loaded,
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
    this.isInitialLoading = false,
    this.isReportLoading = false,
    this.previewLoadingEvaluationId,
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
  final bool isInitialLoading;
  final bool isReportLoading;
  final int? previewLoadingEvaluationId;
  final List<EmdadServiceCategoryEntity> categories;
  final InvoiceListFilterParamEntity filter;
  final String? errorMessage;
  final String? successMessage;

  bool? get selectedSubscription => filter.showSubscription;

  CustomerPreInvoiceState copyWith({
    CustomerPreInvoiceViewStatus? status,
    List<InvoiceRecordEntity>? items,
    int? totalCount,
    bool? isInitialLoading,
    bool? isReportLoading,
    int? previewLoadingEvaluationId,
    bool clearPreviewLoading = false,
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
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isReportLoading: isReportLoading ?? this.isReportLoading,
      previewLoadingEvaluationId: clearPreviewLoading
          ? null
          : previewLoadingEvaluationId ?? this.previewLoadingEvaluationId,
      categories: categories ?? this.categories,
      filter: filter ?? this.filter,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccessMessage ? null : successMessage ?? this.successMessage,
    );
  }
}
