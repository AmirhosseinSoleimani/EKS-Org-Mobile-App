import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/entities/params/invoice_list_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/common/use_cases/get_emdad_categories_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/bulk_invoice_accept_result_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_invoice_record_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/enums/emdadgar_invoice_stage.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/params/bulk_invoice_accept_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/use_cases/accept_emdadgar_invoices_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/use_cases/accept_initial_emdadgar_invoices_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/use_cases/get_definite_emdadgar_invoices_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/use_cases/get_emdadgar_invoices_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/use_cases/get_final_approval_emdadgar_invoices_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/use_cases/get_final_correction_emdadgar_invoices_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/use_cases/get_initial_emdadgar_invoices_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/emdadgar_invoices/utils/emdadgar_initial_invoice_excel_report_factory.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/usecase/export_excel_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'emdadgar_initial_invoice_cubit.freezed.dart';
part 'emdadgar_initial_invoice_state.dart';

@injectable
class EmdadgarInitialInvoiceCubit extends Cubit<EmdadgarInitialInvoiceState> {
  EmdadgarInitialInvoiceCubit(
    this._getInitialInvoicesUseCase,
    this._getInvoicesUseCase,
    this._getFinalApprovalInvoicesUseCase,
    this._getFinalCorrectionInvoicesUseCase,
    this._getDefiniteInvoicesUseCase,
    this._acceptInitialInvoicesUseCase,
    this._acceptInvoicesUseCase,
    this._getEmdadCategoriesUseCase,
    this._setSelectedRequestItemUseCase,
    this._exportExcelUseCase,
  ) : super(const EmdadgarInitialInvoiceState.idle());

  static const int pageSize = 25;
  static const Object _unset = Object();

  final GetInitialEmdadgarInvoicesUseCase _getInitialInvoicesUseCase;
  final GetEmdadgarInvoicesUseCase _getInvoicesUseCase;
  final GetFinalApprovalEmdadgarInvoicesUseCase _getFinalApprovalInvoicesUseCase;
  final GetFinalCorrectionEmdadgarInvoicesUseCase
      _getFinalCorrectionInvoicesUseCase;
  final GetDefiniteEmdadgarInvoicesUseCase _getDefiniteInvoicesUseCase;
  final AcceptInitialEmdadgarInvoicesUseCase _acceptInitialInvoicesUseCase;
  final AcceptEmdadgarInvoicesUseCase _acceptInvoicesUseCase;
  final GetEmdadCategoriesUseCase _getEmdadCategoriesUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;
  final ExportExcelUseCase _exportExcelUseCase;

  final itemsNotifier = ValueNotifier<List<EmdadgarInvoiceRecordEntity>>(
    const <EmdadgarInvoiceRecordEntity>[],
  );
  final selectedRequestIdsNotifier = ValueNotifier<Set<int>>(<int>{});
  final paginationLoadingNotifier = ValueNotifier<bool>(false);
  final reportLoadingNotifier = ValueNotifier<bool>(false);
  final confirmLoadingNotifier = ValueNotifier<bool>(false);

  final List<EmdadServiceCategoryEntity> categories = [];

  InvoiceListFilterParamEntity filter =
      InvoiceListFilterParamEntity.withDefaultDateRange(
    pageSize: pageSize,
    skip: 0,
  );
  EmdadgarInvoiceStage selectedStage = EmdadgarInvoiceStage.initial;
  int totalCount = 0;
  bool hasMore = false;
  bool hasLoadedOnce = false;

  VoidCallback? _retryAction;
  String? _successMessage;
  int _listRequestVersion = 0;

  List<EmdadgarInvoiceRecordEntity> get items => itemsNotifier.value;
  Set<int> get selectedRequestIds => selectedRequestIdsNotifier.value;
  bool get supportsSelection => selectedStage.supportsBulkAccept;
  bool get isAllSelected =>
      supportsSelection &&
      items.isNotEmpty &&
      items.every((item) {
        final id = item.identity?.serviceRequestId;
        return id != null && selectedRequestIds.contains(id);
      });

  Future<void> initialize({
    EmdadgarInvoiceStage initialStage = EmdadgarInvoiceStage.initial,
  }) async {
    selectedStage = initialStage;
    _retryAction = () => initialize(initialStage: initialStage);
    _safeEmit(const EmdadgarInitialInvoiceState.loading());

    final categoriesLoaded = await fetchCategories();
    if (!categoriesLoaded) return;

    await fetchList(refresh: true);
  }

  void retryLastAction() => _retryAction?.call();

  String? consumeSuccessMessage() {
    final message = _successMessage;
    _successMessage = null;
    return message;
  }

  Future<bool> fetchCategories() async {
    final result = await _getEmdadCategoriesUseCase();
    var loaded = false;

    result.when(
      success: (data, _, __) {
        categories
          ..clear()
          ..addAll(data);
        loaded = true;
      },
      failure: (error, message) {
        _emitError(message ?? error.toString());
      },
      expireToken: () {
        _emitError('نشست کاربری منقضی شده است.');
      },
      connectionError: () {
        _safeEmit(const EmdadgarInitialInvoiceState.connectionError());
      },
    );

    return loaded;
  }

  Future<void> setStage(EmdadgarInvoiceStage stage) async {
    if (stage == selectedStage) return;

    selectedStage = stage;
    _clearListForRefresh();
    filter = _copyFilter(filter, pageSize: pageSize, skip: 0);

    await fetchList(refresh: true);
  }

  Future<void> fetchList({bool refresh = false}) async {
    if (paginationLoadingNotifier.value) return;

    _retryAction = () => fetchList(refresh: refresh);

    final nextSkip = refresh ? 0 : items.length;
    final requestFilter = _copyFilter(
      filter,
      pageSize: pageSize,
      skip: nextSkip,
    );
    filter = requestFilter;

    final isInitialLoad = refresh || items.isEmpty;
    if (isInitialLoad) {
      _safeEmit(const EmdadgarInitialInvoiceState.loading());
    } else {
      paginationLoadingNotifier.value = true;
    }

    final requestVersion = ++_listRequestVersion;
    final requestedStage = selectedStage;
    final result = await _getStageInvoices(
      requestFilter,
      stage: requestedStage,
    );

    if (requestVersion != _listRequestVersion ||
        requestedStage != selectedStage) {
      return;
    }

    result.when(
      success: (page, _, __) {
        final received = page.records ?? const <EmdadgarInvoiceRecordEntity>[];
        final records = refresh ? received : [...items, ...received];

        itemsNotifier.value = records;
        totalCount = page.count ?? records.length;
        hasMore = records.length < totalCount;
        hasLoadedOnce = true;
        paginationLoadingNotifier.value = false;

        if (refresh) {
          _retainSelections(records);
        }
        _safeEmit(const EmdadgarInitialInvoiceState.loaded());
      },
      failure: (error, message) {
        hasLoadedOnce = true;
        paginationLoadingNotifier.value = false;
        _emitError(message ?? error.toString());
      },
      expireToken: () {
        hasLoadedOnce = true;
        paginationLoadingNotifier.value = false;
        _emitError('نشست کاربری منقضی شده است.');
      },
      connectionError: () {
        hasLoadedOnce = true;
        paginationLoadingNotifier.value = false;
        _safeEmit(const EmdadgarInitialInvoiceState.connectionError());
      },
    );
  }

  Future<void> setSubscriptionFilter(bool? value) async {
    filter = _copyFilter(
      filter,
      showSubscription: value,
      pageSize: pageSize,
      skip: 0,
    );
    _clearListForRefresh();
    await fetchList(refresh: true);
  }

  Future<void> applyFilter(InvoiceListFilterParamEntity value) async {
    filter = _copyFilter(
      value,
      showSubscription: filter.showSubscription,
      pageSize: pageSize,
      skip: 0,
    );
    _clearListForRefresh();
    await fetchList(refresh: true);
  }

  Future<void> clearFilter() async {
    filter = InvoiceListFilterParamEntity.withDefaultDateRange(
      pageSize: pageSize,
      skip: 0,
    );
    _clearListForRefresh();
    await fetchList(refresh: true);
  }

  void _clearListForRefresh() {
    clearSelection();
    itemsNotifier.value = const <EmdadgarInvoiceRecordEntity>[];
    totalCount = 0;
    hasMore = false;
    paginationLoadingNotifier.value = false;
  }

  void setItemSelected(EmdadgarInvoiceRecordEntity item, bool selected) {
    if (!supportsSelection) return;

    final requestId = item.identity?.serviceRequestId;
    if (requestId == null) return;

    final values = Set<int>.from(selectedRequestIds);
    selected ? values.add(requestId) : values.remove(requestId);
    selectedRequestIdsNotifier.value = values;
  }

  void setAllSelected(bool selected) {
    if (!supportsSelection || !selected) {
      clearSelection();
      return;
    }

    selectedRequestIdsNotifier.value = items
        .map((item) => item.identity?.serviceRequestId)
        .whereType<int>()
        .toSet();
  }

  void clearSelection() {
    selectedRequestIdsNotifier.value = <int>{};
  }

  Future<int?> cacheSelectedRequest(EmdadgarInvoiceRecordEntity item) async {
    final request = _mapToServiceRequest(item);
    if (request == null) {
      _emitError('اطلاعات درخواست برای ادامه عملیات کامل نیست.');
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

  Future<void> confirmSelected() async {
    if (!supportsSelection) return;

    final selectedItems = items
        .where((item) {
          final id = item.identity?.serviceRequestId;
          return id != null && selectedRequestIds.contains(id);
        })
        .toList(growable: false);

    if (selectedItems.isEmpty || confirmLoadingNotifier.value) return;

    final hasIncompleteItem = selectedItems.any((item) {
      final identity = item.identity;
      return identity?.serviceRequestId == null ||
          identity?.evaluationId == null ||
          identity?.invoiceId == null;
    });
    if (hasIncompleteItem) {
      _emitError('اطلاعات یکی از صورت وضعیت‌های انتخاب‌شده کامل نیست.');
      return;
    }

    _retryAction = confirmSelected;
    confirmLoadingNotifier.value = true;

    final param = BulkInvoiceAcceptParamEntity(
      bulkAcceptItems: selectedItems
          .map(
            (item) => BulkInvoiceAcceptItemParamEntity(
              serviceRequestId: item.identity?.serviceRequestId,
              emdadgarEvaluationId: item.identity?.evaluationId,
              invoiceId: item.identity?.invoiceId,
            ),
          )
          .toList(growable: false),
    );

    final result = await _acceptSelectedInvoices(param);
    result.when(
      success: (_, __, ___) async {
        confirmLoadingNotifier.value = false;
        clearSelection();
        _successMessage = 'صورت وضعیت‌های انتخاب‌شده با موفقیت تایید شدند.';
        await fetchList(refresh: true);
      },
      failure: (error, message) {
        confirmLoadingNotifier.value = false;
        _emitError(message ?? error.toString());
      },
      expireToken: () {
        confirmLoadingNotifier.value = false;
        _emitError('نشست کاربری منقضی شده است.');
      },
      connectionError: () {
        confirmLoadingNotifier.value = false;
        _safeEmit(const EmdadgarInitialInvoiceState.connectionError());
      },
    );
  }

  Future<void> exportReport() async {
    if (reportLoadingNotifier.value) return;

    _retryAction = exportReport;
    reportLoadingNotifier.value = true;

    final reportStage = selectedStage;
    final listResult = await _getStageInvoices(
      _copyFilter(filter, pageSize: 0, skip: 0),
      stage: reportStage,
    );

    await listResult.when<Future<void>>(
      success: (page, _, __) async {
        final reportItems = page.records ?? const <EmdadgarInvoiceRecordEntity>[];
        if (reportItems.isEmpty) {
          reportLoadingNotifier.value = false;
          _emitError('داده‌ای برای تهیه گزارش وجود ندارد.');
          return;
        }

        final exportResult = await _exportExcelUseCase(
          EmdadgarInitialInvoiceExcelReportFactory.create(reportItems),
        );

        exportResult.when(
          success: (data, _, __) {
            reportLoadingNotifier.value = false;
            _successMessage = data.isBrowserDownload
                ? 'دانلود گزارش صورت وضعیت‌ها آغاز شد.'
                : 'گزارش صورت وضعیت‌ها ذخیره شد.';
            _safeEmit(const EmdadgarInitialInvoiceState.loaded());
          },
          failure: (error, message) {
            reportLoadingNotifier.value = false;
            _emitError(message ?? error.toString());
          },
          expireToken: () {
            reportLoadingNotifier.value = false;
            _emitError('نشست کاربری منقضی شده است.');
          },
          connectionError: () {
            reportLoadingNotifier.value = false;
            _safeEmit(const EmdadgarInitialInvoiceState.connectionError());
          },
        );
      },
      failure: (error, message) async {
        reportLoadingNotifier.value = false;
        _emitError(message ?? error.toString());
      },
      expireToken: () async {
        reportLoadingNotifier.value = false;
        _emitError('نشست کاربری منقضی شده است.');
      },
      connectionError: () async {
        reportLoadingNotifier.value = false;
        _safeEmit(const EmdadgarInitialInvoiceState.connectionError());
      },
    );
  }

  Future<ApiResult<EmdadgarInvoicePageEntity>> _getStageInvoices(
    InvoiceListFilterParamEntity requestFilter, {
    required EmdadgarInvoiceStage stage,
  }) {
    return switch (stage) {
      EmdadgarInvoiceStage.initial => _getInitialInvoicesUseCase(requestFilter),
      EmdadgarInvoiceStage.current => _getInvoicesUseCase(requestFilter),
      EmdadgarInvoiceStage.finalApproval =>
        _getFinalApprovalInvoicesUseCase(requestFilter),
      EmdadgarInvoiceStage.finalCorrection =>
        _getFinalCorrectionInvoicesUseCase(requestFilter),
      EmdadgarInvoiceStage.taxpayerFinal =>
        _getDefiniteInvoicesUseCase(requestFilter),
    };
  }

  Future<ApiResult<BulkInvoiceAcceptResultEntity>> _acceptSelectedInvoices(
    BulkInvoiceAcceptParamEntity param,
  ) {
    return switch (selectedStage) {
      EmdadgarInvoiceStage.initial => _acceptInitialInvoicesUseCase(param),
      EmdadgarInvoiceStage.current => _acceptInvoicesUseCase(param),
      _ => throw StateError(
          'Bulk accept is not supported for ${selectedStage.name}.',
        ),
    };
  }

  BaseRequestEntity? _mapToServiceRequest(EmdadgarInvoiceRecordEntity item) {
    final requestId = item.identity?.serviceRequestId;
    final serviceTypeValue = item.state?.serviceType;
    if (requestId == null || serviceTypeValue == null) return null;

    if (serviceTypeValue == ServiceType.homeService.value) {
      return HomeServiceRequestEntity(
        id: requestId,
        serviceType: ServiceType.homeService,
      );
    }

    if (serviceTypeValue == ServiceType.reliefService.value) {
      return ReliefRequestEntity(
        id: requestId,
        serviceType: ServiceType.reliefService,
      );
    }

    return null;
  }

  void _retainSelections(List<EmdadgarInvoiceRecordEntity> records) {
    if (!supportsSelection) {
      clearSelection();
      return;
    }

    final availableIds = records
        .map((item) => item.identity?.serviceRequestId)
        .whereType<int>()
        .toSet();
    selectedRequestIdsNotifier.value = selectedRequestIds
        .where(availableIds.contains)
        .toSet();
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
      fromDate: identical(fromDate, _unset) ? source.fromDate : fromDate as String?,
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
      pageSize: identical(pageSize, _unset) ? source.pageSize : pageSize as int?,
      skip: identical(skip, _unset) ? source.skip : skip as int?,
    );
  }

  void _emitError(String? message) {
    _safeEmit(
      EmdadgarInitialInvoiceState.error(
        message: BottomSheetMessageModel(
          title: 'خطا',
          message: _normalizeError(message),
        ),
      ),
    );
  }

  String _normalizeError(String? message) {
    final value = message?.trim();
    return value == null || value.isEmpty
        ? 'در انجام عملیات مشکلی رخ داد.'
        : value;
  }

  void _safeEmit(EmdadgarInitialInvoiceState value) {
    if (!isClosed) emit(value);
  }

  @override
  Future<void> close() {
    itemsNotifier.dispose();
    selectedRequestIdsNotifier.dispose();
    paginationLoadingNotifier.dispose();
    reportLoadingNotifier.dispose();
    confirmLoadingNotifier.dispose();
    return super.close();
  }
}
