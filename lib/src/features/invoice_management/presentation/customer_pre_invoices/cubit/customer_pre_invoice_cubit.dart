import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_details_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/use_cases/get_emdad_categories_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/customer_invoices/use_cases/get_customer_invoice_details_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/customer_invoices/use_cases/get_customer_pre_invoices_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/customer_pre_invoices/utils/customer_pre_invoice_excel_report_factory.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/usecase/export_excel_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/invoice/domain/entities/invoice_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'customer_pre_invoice_state.dart';

@injectable
class CustomerPreInvoiceCubit extends Cubit<CustomerPreInvoiceState> {
  CustomerPreInvoiceCubit(
    this._getCustomerPreInvoicesUseCase,
    this._getCustomerInvoiceDetailsUseCase,
    this._getEmdadCategoriesUseCase,
    this._exportExcelUseCase,
  ) : super(const CustomerPreInvoiceState());

  static const int pageSize = 25;
  static const Object _unset = Object();

  final GetCustomerPreInvoicesUseCase _getCustomerPreInvoicesUseCase;
  final GetCustomerInvoiceDetailsUseCase _getCustomerInvoiceDetailsUseCase;
  final GetEmdadCategoriesUseCase _getEmdadCategoriesUseCase;
  final ExportExcelUseCase _exportExcelUseCase;

  void Function()? _retryAction;

  Future<void> initialize() async {
    await Future.wait<void>([
      fetchCategories(),
      fetchList(refresh: true),
    ]);
  }

  void retryLastAction() => _retryAction?.call();

  Future<void> fetchCategories() async {
    final result = await _getEmdadCategoriesUseCase();

    result.whenOrNull(
      success: (items, failures, resultCode) {
        emit(
          state.copyWith(
            categories: items,
            clearErrorMessage: true,
          ),
        );
      },
    );
  }

  Future<void> fetchList({bool refresh = false}) async {
    if (state.isInitialLoading || state.isPaginationLoading) return;

    _retryAction = () => fetchList(refresh: refresh);

    final nextSkip = refresh ? 0 : state.items.length;
    final requestFilter = _copyFilter(
      state.filter,
      pageSize: pageSize,
      skip: nextSkip,
    );

    final initialLoad = refresh || state.items.isEmpty;

    emit(
      state.copyWith(
        status: initialLoad
            ? CustomerPreInvoiceViewStatus.initialLoading
            : CustomerPreInvoiceViewStatus.loadingMore,
        filter: requestFilter,
        isInitialLoading: initialLoad,
        isPaginationLoading: !initialLoad,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result = await _getCustomerPreInvoicesUseCase(requestFilter);

    result.when(
      success: (page, failures, resultCode) {
        final received = page.records ?? const <InvoiceRecordEntity>[];
        final records = refresh ? received : [...state.items, ...received];
        final count = page.count ?? records.length;

        emit(
          state.copyWith(
            status: CustomerPreInvoiceViewStatus.loaded,
            items: records,
            totalCount: count,
            hasMore: records.length < count,
            isInitialLoading: false,
            isPaginationLoading: false,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => _emitError(failures),
      expireToken: () => _emitError('نشست کاربری منقضی شده است.'),
      connectionError: () {
        emit(
          state.copyWith(
            status: CustomerPreInvoiceViewStatus.connectionError,
            isInitialLoading: false,
            isPaginationLoading: false,
          ),
        );
      },
    );
  }

  Future<void> applyFilter(InvoiceListFilterParamEntity filter) async {
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
        filter: const InvoiceListFilterParamEntity(
          serviceType: ServiceType.reliefService,
          pageSize: pageSize,
          skip: 0,
        ),
        clearErrorMessage: true,
      ),
    );

    await fetchList(refresh: true);
  }

  Future<void> setStatusFilter(int? status) async {
    emit(
      state.copyWith(
        filter: _copyFilter(
          state.filter,
          invoiceStatus: status,
          pageSize: pageSize,
          skip: 0,
        ),
      ),
    );

    await fetchList(refresh: true);
  }

  Future<void> loadPreview(InvoiceRecordEntity item) async {
    final evaluationId = item.identity?.evaluationId ?? item.identity?.id;
    if (evaluationId == null ||
        state.loadingPreviewEvaluationId == evaluationId) {
      return;
    }

    _retryAction = () => loadPreview(item);

    emit(
      state.copyWith(
        status: CustomerPreInvoiceViewStatus.previewLoading,
        loadingPreviewEvaluationId: evaluationId,
        clearPreviewInvoice: true,
        clearErrorMessage: true,
      ),
    );

    final serviceTypeValue = item.state?.serviceType;
    final serviceType = serviceTypeValue == null
        ? state.filter.serviceType
        : ServiceType.fromValue(serviceTypeValue);

    final result = await _getCustomerInvoiceDetailsUseCase(
      InvoiceDetailsParamEntity(
        emdadgarEvaluationId: evaluationId,
        serviceType: serviceType,
      ),
    );

    result.when(
      success: (invoice, failures, resultCode) {
        emit(
          state.copyWith(
            status: CustomerPreInvoiceViewStatus.previewLoaded,
            previewInvoice: invoice,
            clearLoadingPreviewEvaluationId: true,
            clearErrorMessage: true,
          ),
        );
      },
      failure: (error, failures) => _emitError(
        failures,
        clearPreviewLoading: true,
      ),
      expireToken: () => _emitError(
        'نشست کاربری منقضی شده است.',
        clearPreviewLoading: true,
      ),
      connectionError: () {
        emit(
          state.copyWith(
            status: CustomerPreInvoiceViewStatus.connectionError,
            clearLoadingPreviewEvaluationId: true,
          ),
        );
      },
    );
  }

  void clearPreview() {
    emit(
      state.copyWith(
        status: CustomerPreInvoiceViewStatus.loaded,
        clearPreviewInvoice: true,
        clearLoadingPreviewEvaluationId: true,
      ),
    );
  }

  Future<void> exportReport() async {
    if (state.isReportLoading) return;

    emit(
      state.copyWith(
        status: CustomerPreInvoiceViewStatus.reportLoading,
        isReportLoading: true,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final result = await _getCustomerPreInvoicesUseCase(
      _copyFilter(
        state.filter,
        pageSize: 0,
        skip: 0,
      ),
    );

    await result.when<Future<void>>(
      success: (page, failures, resultCode) async {
        final items = page.records ?? const <InvoiceRecordEntity>[];

        if (items.isEmpty) {
          _emitError(
            'داده‌ای برای تهیه گزارش وجود ندارد.',
            clearReportLoading: true,
          );
          return;
        }

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
      },
      failure: (error, failures) async => _emitError(
        failures,
        clearReportLoading: true,
      ),
      expireToken: () async => _emitError(
        'نشست کاربری منقضی شده است.',
        clearReportLoading: true,
      ),
      connectionError: () async {
        emit(
          state.copyWith(
            status: CustomerPreInvoiceViewStatus.connectionError,
            isReportLoading: false,
          ),
        );
      },
    );
  }

  void _emitError(
    String? message, {
    bool clearPreviewLoading = false,
    bool clearReportLoading = false,
  }) {
    emit(
      state.copyWith(
        status: CustomerPreInvoiceViewStatus.error,
        isInitialLoading: false,
        isPaginationLoading: false,
        isReportLoading:
            clearReportLoading ? false : state.isReportLoading,
        clearLoadingPreviewEvaluationId: clearPreviewLoading,
        errorMessage: message?.trim().isNotEmpty == true
            ? message
            : 'عملیات با خطا مواجه شد.',
      ),
    );
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
