import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/get_rescuer_report_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/params/get_rescuers_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/san_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/skill_certificate_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/delete_rescuer_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/get_rescuer_history_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/get_rescuer_report_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/get_rescuer_skill_certificates_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/use_cases/get_rescuers_use_case.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/enums/rescuer_status_filter.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/utils/rescuer_excel_report_factory.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart'
    show ApiResultPatterns;
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/usecase/export_excel_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/request/latest_request_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'rescuer_list_cubit.freezed.dart';
part 'rescuer_list_state.dart';

@injectable
class RescuerListCubit extends Cubit<RescuerListState> with LatestRequestGuard {
  RescuerListCubit(
    this._getRescuersUseCase,
    this._deleteRescuerUseCase,
    this._getRescuerReportUseCase,
    this._getSkillCertificatesUseCase,
    this._getHistoryUseCase,
    this._exportExcelUseCase,
  ) : super(const RescuerListState.idle());

  final GetRescuersUseCase _getRescuersUseCase;
  final DeleteRescuerUseCase _deleteRescuerUseCase;
  final GetRescuerReportUseCase _getRescuerReportUseCase;
  final GetRescuerSkillCertificatesUseCase _getSkillCertificatesUseCase;
  final GetRescuerHistoryUseCase _getHistoryUseCase;
  final ExportExcelUseCase _exportExcelUseCase;

  static const int pageSize = 10;

  final nameController = TextEditingController();
  final nationalNumberController = TextEditingController();
  final mobileController = TextEditingController();
  final codeController = TextEditingController();

  final selectedStatusNotifier = ValueNotifier<RescuerStatusFilter>(
    RescuerStatusFilter.all,
  );
  final reportLoadingNotifier = ValueNotifier<bool>(false);
  final operationLoadingNotifier = ValueNotifier<RescuerListOperation?>(null);

  VoidCallback? _retryAction;

  bool get hasRetryAction => _retryAction != null;

  List<RescuerEntity> get items => state.data.items;

  List<RescuerEntity> get filteredItems => state.data.filteredItems;

  int? get deletingRescuerId => state.data.deletingRescuerId;

  bool get isReportLoading => reportLoadingNotifier.value;

  RescuerListOperation? get operationLoading => operationLoadingNotifier.value;

  void retryLastAction() => _retryAction?.call();

  Future<void> fetchRescuers() async {
    final requestVersion = beginLatestRequest('list');
    _retryAction = fetchRescuers;
    emit(RescuerListState.loading(data: state.data));

    final result = await _getRescuersUseCase(
      const GetRescuersParamEntity(pageSize: pageSize),
    );
    if (!isLatestRequest(requestVersion, 'list') || isClosed) return;

    result.whenOrNull(
      success: (data, failures, resultCode) {
        final immutableItems = List<RescuerEntity>.unmodifiable(data);
        final updatedData = state.data.copyWith(
          items: immutableItems,
          filteredItems: _filterItems(immutableItems),
          deletingRescuerId: null,
        );
        _safeEmit(RescuerListState.loaded(data: updatedData));
      },
      failure: (error, message) {
        _safeEmit(
          RescuerListState.error(
            data: state.data,
            message: _buildErrorMessage(
              title: 'خطا در دریافت امدادرسان‌ها',
              message:
                  message ??
                  error?.toString() ??
                  'دریافت لیست امدادرسان‌ها با خطا مواجه شد.',
            ),
          ),
        );
      },
      connectionError: () {
        _safeEmit(RescuerListState.connectionError(data: state.data));
      },
    );
  }

  void setSelectedStatus(RescuerStatusFilter status) {
    selectedStatusNotifier.value = status;
    _emitFilteredData(selectedStatus: status);
  }

  void applyFilters() {
    _emitFilteredData();
  }

  void clearFilters() {
    nameController.clear();
    nationalNumberController.clear();
    mobileController.clear();
    codeController.clear();
    selectedStatusNotifier.value = RescuerStatusFilter.all;
    _emitFilteredData(selectedStatus: RescuerStatusFilter.all);
  }

  Future<bool> deleteRescuer(int id) async {
    if (state.data.deletingRescuerId != null) return false;

    _retryAction = () {
      deleteRescuer(id);
    };

    operationLoadingNotifier.value = RescuerListOperation.delete;
    emit(RescuerListState.loaded(data: state.data));

    var isSuccessful = false;

    try {
      final result = await _deleteRescuerUseCase(id);

      result.whenOrNull(
        success: (data, failures, resultCode) {
          isSuccessful = true;
          _safeEmit(
            RescuerListState.loaded(
              data: state.data.copyWith(deletingRescuerId: null),
            ),
          );
        },
        failure: (error, message) {
          _safeEmit(
            RescuerListState.actionError(
              data: state.data.copyWith(deletingRescuerId: null),
              message:
                  message ??
                  error?.toString() ??
                  'حذف امدادرسان با خطا مواجه شد.',
            ),
          );
        },
        connectionError: () {
          _safeEmit(
            RescuerListState.actionError(
              data: state.data.copyWith(deletingRescuerId: null),
              message: 'اتصال اینترنت خود را بررسی کنید.',
            ),
          );
        },
      );

      if (isSuccessful) {
        await fetchRescuers();
      }
    } catch (_) {
      _safeEmit(
        RescuerListState.actionError(
          data: state.data.copyWith(deletingRescuerId: null),
          message: 'حذف امدادرسان با خطا مواجه شد.',
        ),
      );
    } finally {
      operationLoadingNotifier.value = null;
    }

    return isSuccessful;
  }

  Future<String?> loadReport() async {
    if (reportLoadingNotifier.value) return null;

    _retryAction = () => loadReport();
    reportLoadingNotifier.value = true;
    emit(RescuerListState.loaded(data: state.data));

    String? savedPath;
    try {
      final result = await _getRescuerReportUseCase(
        const GetRescuerReportParamEntity(pageSize: 0),
      );

      await result.when<Future<void>>(
        success: (items, failures, resultCode) async {
          if (items.isEmpty) {
            _safeEmit(RescuerListState.actionError(
              data: state.data,
              message: 'داده‌ای برای تهیه گزارش وجود ندارد.',
            ));
            return;
          }

          final exportResult = await _exportExcelUseCase(
            RescuerExcelReportFactory.create(items),
          );
          exportResult.when(
            success: (data, failures, resultCode) {
              savedPath = data.displayPath;
              _safeEmit(RescuerListState.loaded(data: state.data));
            },
            failure: (error, failures) => _safeEmit(
              RescuerListState.actionError(
                data: state.data,
                message: failures ?? 'ذخیره فایل گزارش با خطا مواجه شد.',
              ),
            ),
            expireToken: () => _safeEmit(
              RescuerListState.actionError(
                data: state.data,
                message: 'نشست کاربری منقضی شده است.',
              ),
            ),
            connectionError: () => _safeEmit(
              RescuerListState.actionError(
                data: state.data,
                message: 'ذخیره فایل گزارش با خطا مواجه شد.',
              ),
            ),
          );
        },
        failure: (error, failures) async => _safeEmit(
          RescuerListState.actionError(
            data: state.data,
            message: failures ?? error?.toString() ??
                'دریافت گزارش با خطا مواجه شد.',
          ),
        ),
        expireToken: () async => _safeEmit(
          RescuerListState.actionError(
            data: state.data,
            message: 'نشست کاربری منقضی شده است.',
          ),
        ),
        connectionError: () async => _safeEmit(
          RescuerListState.actionError(
            data: state.data,
            message: 'اتصال اینترنت خود را بررسی کنید.',
          ),
        ),
      );
    } catch (_) {
      _safeEmit(RescuerListState.actionError(
        data: state.data,
        message: 'دریافت گزارش با خطا مواجه شد.',
      ));
    } finally {
      reportLoadingNotifier.value = false;
    }

    return savedPath;
  }

  Future<List<SkillCertificateEntity>?> loadSkillCertificates(int id) async {
    if (operationLoadingNotifier.value != null) return null;

    _retryAction = () {
      loadSkillCertificates(id);
    };
    operationLoadingNotifier.value = RescuerListOperation.skillCertificates;
    emit(RescuerListState.loaded(data: state.data));

    List<SkillCertificateEntity>? certificates;

    try {
      final result = await _getSkillCertificatesUseCase(id);

      result.whenOrNull(
        success: (data, failures, resultCode) {
          certificates = data;
          _safeEmit(RescuerListState.loaded(data: state.data));
        },
        failure: (error, message) {
          _safeEmit(
            RescuerListState.actionError(
              data: state.data,
              message:
                  message ??
                  error?.toString() ??
                  'دریافت گواهینامه‌های مهارت با خطا مواجه شد.',
            ),
          );
        },
        connectionError: () {
          _safeEmit(
            RescuerListState.actionError(
              data: state.data,
              message: 'اتصال اینترنت خود را بررسی کنید.',
            ),
          );
        },
      );
    } finally {
      operationLoadingNotifier.value = null;
    }

    return certificates;
  }

  Future<List<SanHistoryEntity>?> loadHistory(int id) async {
    if (operationLoadingNotifier.value != null) return null;

    _retryAction = () {
      loadHistory(id);
    };
    operationLoadingNotifier.value = RescuerListOperation.history;
    emit(RescuerListState.loaded(data: state.data));

    List<SanHistoryEntity>? histories;

    try {
      final result = await _getHistoryUseCase(id);

      result.whenOrNull(
        success: (data, failures, resultCode) {
          histories = data;
          _safeEmit(RescuerListState.loaded(data: state.data));
        },
        failure: (error, message) {
          _safeEmit(
            RescuerListState.actionError(
              data: state.data,
              message:
                  message ??
                  error?.toString() ??
                  'دریافت تاریخچه امدادرسان با خطا مواجه شد.',
            ),
          );
        },
        connectionError: () {
          _safeEmit(
            RescuerListState.actionError(
              data: state.data,
              message: 'اتصال اینترنت خود را بررسی کنید.',
            ),
          );
        },
      );
    } finally {
      operationLoadingNotifier.value = null;
    }

    return histories;
  }

  void _emitFilteredData({RescuerStatusFilter? selectedStatus}) {
    final status = selectedStatus ?? selectedStatusNotifier.value;
    final updatedData = state.data.copyWith(
      selectedStatus: status,
      filteredItems: _filterItems(state.data.items, selectedStatus: status),
    );
    _safeEmit(RescuerListState.loaded(data: updatedData));
  }

  List<RescuerEntity> _filterItems(
    List<RescuerEntity> source, {
    RescuerStatusFilter? selectedStatus,
  }) {
    final name = nameController.text.trim().toLowerCase();
    final nationalNumber = nationalNumberController.text.trim();
    final mobile = mobileController.text.trim();
    final code = codeController.text.trim();
    final status = selectedStatus ?? selectedStatusNotifier.value;

    return List<RescuerEntity>.unmodifiable(
      source.where((item) {
        final matchesName =
            name.isEmpty || item.fullName.toLowerCase().contains(name);
        final matchesNationalNumber =
            nationalNumber.isEmpty ||
            (item.nationalNumber ?? '').contains(nationalNumber);
        final normalizedMobile = (item.mobile ?? '').replaceFirst('+98', '0');
        final matchesMobile =
            mobile.isEmpty || normalizedMobile.contains(mobile);
        final matchesCode = code.isEmpty || (item.code ?? '').contains(code);

        return matchesName &&
            matchesNationalNumber &&
            matchesMobile &&
            matchesCode &&
            status.matches(item);
      }),
    );
  }

  BottomSheetMessageModel _buildErrorMessage({
    required String title,
    required String message,
  }) {
    return BottomSheetMessageModel(title: title, message: message);
  }

  void _safeEmit(RescuerListState nextState) {
    if (!isClosed) emit(nextState);
  }

  @override
  Future<void> close() {
    nameController.dispose();
    nationalNumberController.dispose();
    mobileController.dispose();
    codeController.dispose();
    selectedStatusNotifier.dispose();
    reportLoadingNotifier.dispose();
    operationLoadingNotifier.dispose();
    return super.close();
  }
}

enum RescuerListOperation { skillCertificates, history, delete }
