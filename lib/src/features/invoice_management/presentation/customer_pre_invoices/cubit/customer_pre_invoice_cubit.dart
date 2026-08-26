import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_document_urls_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/use_cases/get_customer_invoice_document_urls_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/use_cases/get_emdad_categories_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/customer_invoices/use_cases/finalize_customer_invoice_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/customer_invoices/use_cases/get_customer_invoice_details_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/customer_invoices/use_cases/get_customer_pre_invoices_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/customer_pre_invoices/utils/customer_pre_invoice_excel_report_factory.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/usecase/export_excel_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:eks_sana_plus_org/src/shared/request/latest_request_guard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'customer_pre_invoice_state.dart';

@injectable
class CustomerPreInvoiceCubit extends Cubit<CustomerPreInvoiceState>
    with LatestRequestGuard {
  CustomerPreInvoiceCubit(
    this._getCustomerPreInvoicesUseCase,
    this._getCustomerInvoiceDetailsUseCase,
    this._finalizeCustomerInvoiceUseCase,
    this._getCustomerInvoiceDocumentUrlsUseCase,
    this._getEmdadCategoriesUseCase,
    this._exportExcelUseCase,
    this._setSelectedRequestItemUseCase,
  ) : super(
          CustomerPreInvoiceState(
            filter: InvoiceListFilterParamEntity.withDefaultDateRange(
              pageSize: pageSize,
              skip: 0,
            ),
          ),
        );

  // Web sends PageSize=0 and Skip=0 for this report and receives the full list.
  static const int pageSize = 0;
  static const Object _unset = Object();

  final GetCustomerPreInvoicesUseCase _getCustomerPreInvoicesUseCase;
  final GetCustomerInvoiceDetailsUseCase _getCustomerInvoiceDetailsUseCase;
  final FinalizeCustomerInvoiceUseCase _finalizeCustomerInvoiceUseCase;
  final GetCustomerInvoiceDocumentUrlsUseCase
      _getCustomerInvoiceDocumentUrlsUseCase;
  final GetEmdadCategoriesUseCase _getEmdadCategoriesUseCase;
  final ExportExcelUseCase _exportExcelUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;

  void Function()? _retryAction;

  Future<void> initialize() async {
    _retryAction = initialize;
    final categoriesLoaded = await fetchCategories();
    if (!categoriesLoaded || isClosed) return;
    await fetchList(refresh: true);
  }

  void retryLastAction() => _retryAction?.call();

  Future<bool> fetchCategories() async {
    final result = await _getEmdadCategoriesUseCase();

    return result.when<bool>(
      success: (items, failures, resultCode) {
        emit(
          state.copyWith(
            categories: items,
            clearErrorMessage: true,
          ),
        );
        return true;
      },
      failure: (error, failures) {
        _emitError(failures ?? error.toString());
        return false;
      },
      expireToken: () => false,
      connectionError: () {
        emit(
          state.copyWith(
            status: CustomerPreInvoiceViewStatus.connectionError,
          ),
        );
        return false;
      },
    );
  }

  Future<void> fetchList({bool refresh = false}) async {
    if (state.isInitialLoading) return;
    final requestVersion = beginLatestRequest('list');

    _retryAction = () => fetchList(refresh: true);

    final requestFilter = _copyFilter(
      state.filter,
      pageSize: pageSize,
      skip: 0,
    );

    emit(
      state.copyWith(
        status: CustomerPreInvoiceViewStatus.initialLoading,
        filter: requestFilter,
        isInitialLoading: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result = await _getCustomerPreInvoicesUseCase(requestFilter);
    if (!isLatestRequest(requestVersion, 'list') || isClosed) return;

    result.when(
      success: (page, failures, resultCode) {
        final records = page.records ?? const <InvoiceRecordEntity>[];

        emit(
          state.copyWith(
            status: CustomerPreInvoiceViewStatus.loaded,
            items: records,
            totalCount: page.count ?? records.length,
            isInitialLoading: false,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => _emitError(failures),
      expireToken: () {
        emit(
          state.copyWith(
            isInitialLoading: false,
          ),
        );
      },
      connectionError: () {
        emit(
          state.copyWith(
            status: CustomerPreInvoiceViewStatus.connectionError,
            isInitialLoading: false,
          ),
        );
      },
    );
  }

  Future<void> applyFilter(InvoiceListFilterParamEntity filter) async {
    if (filter.fromDate == null || filter.toDate == null) {
      _emitError('وارد کردن تاریخ الزامیست.');
      return;
    }

    emit(
      state.copyWith(
        filter: _copyFilter(
          filter,
          pageSize: pageSize,
          skip: 0,
        ),
        clearErrorMessage: true,
      ),
    );

    await fetchList(refresh: true);
  }

  Future<void> clearFilter() async {
    emit(
      state.copyWith(
        filter: InvoiceListFilterParamEntity.withDefaultDateRange(
          serviceType: null,
          pageSize: pageSize,
          skip: 0,
        ),
        clearErrorMessage: true,
      ),
    );

    await fetchList(refresh: true);
  }

  Future<void> setSubscriptionFilter(bool? value) async {
    emit(
      state.copyWith(
        filter: _copyFilter(
          state.filter,
          showSubscription: value,
          pageSize: pageSize,
          skip: 0,
        ),
      ),
    );

    await fetchList(refresh: true);
  }

  Future<ApiResult<InvoiceEntity?>> fetchPreInvoiceDetails(
    InvoiceRecordEntity item,
  ) async {
    if (state.previewLoadingEvaluationId != null) {
      return const ApiResult.failure(
        failures: 'در حال دریافت پیش فاکتور هستیم. لطفاً کمی صبر کنید.',
      );
    }

    final evaluationId = item.identity?.evaluationId;
    final serviceType = _serviceTypeFromValue(item.state?.serviceType);

    if (evaluationId == null || serviceType == null) {
      return const ApiResult.failure(
        failures: 'اطلاعات لازم برای نمایش پیش فاکتور کامل نیست.',
      );
    }

    emit(
      state.copyWith(
        previewLoadingEvaluationId: evaluationId,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result = await _getCustomerInvoiceDetailsUseCase(
      InvoiceDetailsParamEntity(
        emdadgarEvaluationId: evaluationId,
        serviceType: serviceType,
      ),
    );

    if (!isClosed) {
      emit(state.copyWith(clearPreviewLoading: true));
    }

    return result;
  }

  Future<ApiResult<String>> finalizePreInvoice(
    InvoiceRecordEntity item,
  ) async {
    final evaluationId = item.identity?.evaluationId;

    if (evaluationId == null || evaluationId <= 0) {
      return const ApiResult.failure(
        failures: 'اطلاعات لازم برای نهایی سازی فاکتور کامل نیست.',
      );
    }

    // Web finalizes customer pre-invoices through AidServiceEvaluation and
    // explicitly sends ServiceType.EmdadService (1). Keep the same contract.
    return _finalizeCustomerInvoiceUseCase(
      InvoiceDetailsParamEntity(
        emdadgarEvaluationId: evaluationId,
        serviceType: ServiceType.reliefService,
      ),
    );
  }

  Future<ApiResult<InvoiceDocumentUrlsEntity>> getCustomerInvoiceDocumentUrls(
    String invoiceGuid,
  ) {
    return _getCustomerInvoiceDocumentUrlsUseCase(invoiceGuid);
  }

  Future<int?> cacheSelectedRequest(InvoiceRecordEntity item) async {
    final request = _mapToServiceRequest(item);

    if (request == null) {
      _emitError('اطلاعات درخواست برای نمایش جزئیات کامل نیست.');
      return null;
    }

    try {
      await _setSelectedRequestItemUseCase(request);
      return request.id;
    } catch (_) {
      _emitError('ذخیره درخواست انتخاب‌شده با خطا مواجه شد.');
      return null;
    }
  }

  BaseRequestEntity? _mapToServiceRequest(InvoiceRecordEntity item) {
    final requestId = item.identity?.serviceRequestId;
    final serviceType = ServiceType.fromValue(item.state?.serviceType);

    if (requestId == null) return null;

    if (serviceType == ServiceType.homeService) {
      return HomeServiceRequestEntity(
        id: requestId,
        serviceType: serviceType,
      );
    }

    return ReliefRequestEntity(
      id: requestId,
      serviceType: serviceType,
    );
  }

  Future<void> exportReport() async {
    if (state.isReportLoading) return;

    _retryAction = exportReport;

    final items = state.items;
    if (items.isEmpty) {
      _emitError('داده‌ای برای تهیه گزارش وجود ندارد.');
      return;
    }

    emit(
      state.copyWith(
        status: CustomerPreInvoiceViewStatus.reportLoading,
        isReportLoading: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final exportResult = await _exportExcelUseCase(
      CustomerPreInvoiceExcelReportFactory.create(items),
    );

    exportResult.when(
      success: (data, failures, resultCode) {
        emit(
          state.copyWith(
            status: CustomerPreInvoiceViewStatus.reportSuccess,
            isReportLoading: false,
            successMessage: data.isBrowserDownload
                ? 'دانلود گزارش پیش فاکتورهای مشتری آغاز شد.'
                : 'گزارش پیش فاکتورهای مشتری ذخیره شد.',
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => _emitError(
        failures ?? 'ذخیره گزارش با خطا مواجه شد.',
        clearReportLoading: true,
      ),
      expireToken: () => _emitError(
        'نشست کاربری منقضی شده است.',
        clearReportLoading: true,
      ),
      connectionError: () => _emitError(
        'ذخیره گزارش با خطا مواجه شد.',
        clearReportLoading: true,
      ),
    );
  }

  void _emitError(
    String? message, {
    bool clearReportLoading = false,
  }) {
    emit(
      state.copyWith(
        status: CustomerPreInvoiceViewStatus.error,
        isInitialLoading: false,
        isReportLoading: clearReportLoading ? false : state.isReportLoading,
        errorMessage: message?.trim().isNotEmpty == true
            ? message
            : 'عملیات با خطا مواجه شد.',
      ),
    );
  }

  ServiceType? _serviceTypeFromValue(int? value) {
    for (final serviceType in ServiceType.values) {
      if (serviceType.value == value) return serviceType;
    }
    return null;
  }

  InvoiceListFilterParamEntity _copyFilter(
    InvoiceListFilterParamEntity source, {
    Object? serviceType = _unset,
    Object? givenCode = _unset,
    Object? requestTrackCode = _unset,
    Object? fromDate = _unset,
    Object? toDate = _unset,
    Object? invoiceStatus = _unset,
    Object? showSubscription = _unset,
    Object? hasObjection = _unset,
    Object? categoryGivenCode = _unset,
    Object? agencyCode = _unset,
    Object? emdadgarName = _unset,
    Object? pageSize = _unset,
    Object? skip = _unset,
  }) {
    return InvoiceListFilterParamEntity(
      serviceType: identical(serviceType, _unset)
          ? source.serviceType
          : serviceType as ServiceType?,
      givenCode: identical(givenCode, _unset)
          ? source.givenCode
          : givenCode as int?,
      requestTrackCode: identical(requestTrackCode, _unset)
          ? source.requestTrackCode
          : requestTrackCode as String?,
      fromDate:
          identical(fromDate, _unset) ? source.fromDate : fromDate as String?,
      toDate: identical(toDate, _unset) ? source.toDate : toDate as String?,
      invoiceStatus: identical(invoiceStatus, _unset)
          ? source.invoiceStatus
          : invoiceStatus as int?,
      showSubscription: identical(showSubscription, _unset)
          ? source.showSubscription
          : showSubscription as bool?,
      hasObjection: identical(hasObjection, _unset)
          ? source.hasObjection
          : hasObjection as bool?,
      categoryGivenCode: identical(categoryGivenCode, _unset)
          ? source.categoryGivenCode
          : categoryGivenCode as String?,
      agencyCode: identical(agencyCode, _unset)
          ? source.agencyCode
          : agencyCode as String?,
      emdadgarName: identical(emdadgarName, _unset)
          ? source.emdadgarName
          : emdadgarName as String?,
      pageSize:
          identical(pageSize, _unset) ? source.pageSize : pageSize as int?,
      skip: identical(skip, _unset) ? source.skip : skip as int?,
    );
  }
}
