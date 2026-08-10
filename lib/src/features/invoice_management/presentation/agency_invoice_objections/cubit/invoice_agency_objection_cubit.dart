import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/invoice_agency_objection_page_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/entities/params/invoice_agency_objection_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/domain/agency_invoice_objections/use_cases/get_invoice_agency_objections_use_case.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/models/invoice_agency_objection_filter_value.dart';
import 'package:eks_sana_plus_org/src/features/invoice_management/presentation/agency_invoice_objections/utils/invoice_agency_objection_excel_report_factory.dart';
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

part 'invoice_agency_objection_cubit.freezed.dart';
part 'invoice_agency_objection_state.dart';

class InvoiceAgencyObjectionCubit extends Cubit<InvoiceAgencyObjectionState> {
  InvoiceAgencyObjectionCubit(
    this._getObjectionsUseCase,
    this._exportExcelUseCase,
    this._setSelectedRequestItemUseCase,
  ) : super(const InvoiceAgencyObjectionState.idle());

  static const int pageSize = 25;

  final GetInvoiceAgencyObjectionsUseCase _getObjectionsUseCase;
  final ExportExcelUseCase _exportExcelUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;

  final ValueNotifier<List<InvoiceAgencyObjectionEntity>> itemsNotifier =
      ValueNotifier<List<InvoiceAgencyObjectionEntity>>(
    const <InvoiceAgencyObjectionEntity>[],
  );
  final ValueNotifier<bool> paginationLoadingNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> reportLoadingNotifier = ValueNotifier<bool>(false);

  final Map<int, String> _knownStatuses = <int, String>{};

  InvoiceAgencyObjectionFilterValue filter =
      InvoiceAgencyObjectionFilterValue.withDefaultDateRange();
  int? selectedStatus;
  int totalCount = 0;
  bool hasMore = false;
  bool hasLoadedOnce = false;

  VoidCallback? _retryAction;
  String? _successMessage;
  int _requestVersion = 0;

  List<InvoiceAgencyObjectionEntity> get items => itemsNotifier.value;
  Map<int, String> get knownStatuses => Map.unmodifiable(_knownStatuses);

  Future<void> initialize() async {
    _retryAction = initialize;
    await fetchList(refresh: true);
  }

  void retryLastAction() => _retryAction?.call();

  String? consumeSuccessMessage() {
    final message = _successMessage;
    _successMessage = null;
    return message;
  }

  Future<void> fetchList({bool refresh = false}) async {
    if (paginationLoadingNotifier.value) return;

    _retryAction = () => fetchList(refresh: refresh);

    final nextSkip = refresh ? 0 : items.length;
    final request = _buildRequest(
      pageSize: pageSize,
      skip: nextSkip,
    );

    if (refresh || items.isEmpty) {
      _safeEmit(const InvoiceAgencyObjectionState.loading());
    } else {
      paginationLoadingNotifier.value = true;
    }

    final requestVersion = ++_requestVersion;
    final result = await _getObjectionsUseCase(request);
    if (requestVersion != _requestVersion) return;

    result.when(
      success: (page, _, __) {
        _handleListSuccess(page, refresh: refresh);
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
        _safeEmit(const InvoiceAgencyObjectionState.connectionError());
      },
    );
  }

  Future<void> setStatusFilter(int? value) async {
    selectedStatus = value;
    _clearList();
    await fetchList(refresh: true);
  }

  Future<void> applyFilter(InvoiceAgencyObjectionFilterValue value) async {
    filter = value;
    _clearList();
    await fetchList(refresh: true);
  }

  Future<void> clearFilter() async {
    selectedStatus = null;
    filter = InvoiceAgencyObjectionFilterValue.withDefaultDateRange();
    _clearList();
    await fetchList(refresh: true);
  }

  Future<int?> cacheSelectedRequest(InvoiceAgencyObjectionEntity item) async {
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

  BaseRequestEntity? _mapToServiceRequest(InvoiceAgencyObjectionEntity item) {
    final requestId = item.identity?.serviceRequestId;
    final serviceTypeValue = item.identity?.serviceType;
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

  Future<void> exportReport() async {
    if (reportLoadingNotifier.value) return;

    _retryAction = exportReport;
    reportLoadingNotifier.value = true;

    final result = await _getObjectionsUseCase(
      _buildRequest(pageSize: 0, skip: 0),
    );

    await result.when<Future<void>>(
      success: (page, _, __) async {
        final reportItems =
            page.records ?? const <InvoiceAgencyObjectionEntity>[];
        if (reportItems.isEmpty) {
          reportLoadingNotifier.value = false;
          _emitError('داده‌ای برای تهیه گزارش وجود ندارد.');
          return;
        }

        final exportResult = await _exportExcelUseCase(
          InvoiceAgencyObjectionExcelReportFactory.create(reportItems),
        );

        exportResult.when(
          success: (data, _, __) {
            reportLoadingNotifier.value = false;
            _successMessage = data.isBrowserDownload
                ? 'دانلود گزارش درخواست‌های اصلاحی آغاز شد.'
                : 'گزارش درخواست‌های اصلاحی ذخیره شد.';
            _safeEmit(const InvoiceAgencyObjectionState.loaded());
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
            _safeEmit(const InvoiceAgencyObjectionState.connectionError());
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
        _safeEmit(const InvoiceAgencyObjectionState.connectionError());
      },
    );
  }

  InvoiceAgencyObjectionFilterParamEntity _buildRequest({
    required int pageSize,
    required int skip,
  }) {
    final filters = <InvoiceAgencyObjectionFilterItemParamEntity>[];

    final fromDate = _normalized(filter.fromDate);
    if (fromDate != null) {
      filters.add(
        InvoiceAgencyObjectionFilterItemParamEntity(
          field: 'insertDateTime',
          operatorValue: 'gte',
          value: '${fromDate}T00:00:00',
        ),
      );
    }

    final toDate = _normalized(filter.toDate);
    if (toDate != null) {
      filters.add(
        InvoiceAgencyObjectionFilterItemParamEntity(
          field: 'insertDateTime',
          operatorValue: 'lte',
          value: '${toDate}T23:59:59',
        ),
      );
    }

    final trackCode = _normalized(filter.requestTrackCode);
    if (trackCode != null) {
      filters.add(
        InvoiceAgencyObjectionFilterItemParamEntity(
          field: 'serviceRequestTrackCode',
          operatorValue: 'eq',
          value: int.tryParse(trackCode) ?? trackCode,
        ),
      );
    }

    final agencyCode = _normalized(filter.agencyCode);
    if (agencyCode != null) {
      filters.add(
        InvoiceAgencyObjectionFilterItemParamEntity(
          field: 'agencyCode',
          operatorValue: 'contains',
          value: agencyCode,
        ),
      );
    }

    final aidPerName = _normalized(filter.aidPerName);
    if (aidPerName != null) {
      filters.add(
        InvoiceAgencyObjectionFilterItemParamEntity(
          field: 'aidPerName',
          operatorValue: 'contains',
          value: aidPerName,
        ),
      );
    }

    final status = selectedStatus;
    if (status != null) {
      filters.add(
        InvoiceAgencyObjectionFilterItemParamEntity(
          field: 'status',
          operatorValue: 'eq',
          value: status,
        ),
      );
    }

    return InvoiceAgencyObjectionFilterParamEntity(
      filters: filters,
      pageSize: pageSize,
      skip: skip,
    );
  }

  void _handleListSuccess(
    InvoiceAgencyObjectionPageEntity page, {
    required bool refresh,
  }) {
    final received = page.records ?? const <InvoiceAgencyObjectionEntity>[];
    _collectStatuses(received);

    final records = refresh ? received : <InvoiceAgencyObjectionEntity>[
      ...items,
      ...received,
    ];

    itemsNotifier.value = records;
    totalCount = page.count ?? records.length;
    hasMore = records.length < totalCount;
    hasLoadedOnce = true;
    paginationLoadingNotifier.value = false;
    _safeEmit(const InvoiceAgencyObjectionState.loaded());
  }

  void _collectStatuses(List<InvoiceAgencyObjectionEntity> records) {
    for (final item in records) {
      final status = item.identity?.status;
      final title = item.identity?.statusTitle?.trim();
      if (status != null && title != null && title.isNotEmpty) {
        _knownStatuses[status] = title;
      }
    }
  }

  void _clearList() {
    _requestVersion++;
    itemsNotifier.value = const <InvoiceAgencyObjectionEntity>[];
    totalCount = 0;
    hasMore = false;
    paginationLoadingNotifier.value = false;
  }

  String? _normalized(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  void _emitError(String? message) {
    _safeEmit(
      InvoiceAgencyObjectionState.error(
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

  void _safeEmit(InvoiceAgencyObjectionState value) {
    if (!isClosed) emit(value);
  }

  @override
  Future<void> close() {
    itemsNotifier.dispose();
    paginationLoadingNotifier.dispose();
    reportLoadingNotifier.dispose();
    return super.close();
  }
}
