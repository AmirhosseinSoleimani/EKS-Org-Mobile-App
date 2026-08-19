import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/cancel_plan_requests_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/change_plan_info_location_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/change_plan_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/create_plan_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/plan_history_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/usecases/plan_info_usecases.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/utils/plan_info_excel_report_factory.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/excel_export/domain/usecase/export_excel_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/request/latest_request_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'plan_info_state.dart';

@injectable
class PlanInfoCubit extends Cubit<PlanInfoState> with LatestRequestGuard {
  PlanInfoCubit(
      this._getPlanListUseCase,
      this._getPlanByIdUseCase,
      this._createPlanUseCase,
      this._editPlanUseCase,
      this._deletePlanUseCase,
      this._getPlanStatusReasonsUseCase,
      this._changePlanStatusUseCase,
      this._getPlanReportUseCase,
      this._cancelPlanRequestsUseCase,
      this._getPlanLookupsUseCase,
      this._currentSessionManager,
      this._changeLocationUseCase,
      this._getPlanHistoriesUseCase,
      this._exportExcelUseCase,
      ) : super(const PlanInfoState());

  final GetPlanListUseCase _getPlanListUseCase;
  final GetPlanByIdUseCase _getPlanByIdUseCase;
  final CreatePlanUseCase _createPlanUseCase;
  final EditPlanUseCase _editPlanUseCase;
  final DeletePlanUseCase _deletePlanUseCase;
  final GetPlanStatusReasonsUseCase _getPlanStatusReasonsUseCase;
  final ChangePlanStatusUseCase _changePlanStatusUseCase;
  final GetPlanReportUseCase _getPlanReportUseCase;
  final CancelPlanRequestsUseCase _cancelPlanRequestsUseCase;
  final GetPlanLookupsUseCase _getPlanLookupsUseCase;
  final CurrentSessionManager _currentSessionManager;
  final ChangeLocationUseCase _changeLocationUseCase;
  final GetPlanHistoriesUseCase _getPlanHistoriesUseCase;
  final ExportExcelUseCase _exportExcelUseCase;

  final titleController = TextEditingController();
  final emdadUnitController = TextEditingController();
  final shiftController = TextEditingController();
  final specialPlanController = TextEditingController();
  final locationController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  int? seatTypeFilter;
  int _skip = 0;
  final int _pageSize = 3;
  bool _isLoadingMore = false;

  Future<void> init() async {
    _loadSeatTypesFromSession();
    await fetchPlans();
  }

  Future<void> initCreatePage({int? planId}) async {
    _loadSeatTypesFromSession();
    emit(state.copyWith(status: PlanInfoStatus.loading, clearMessage: true));
    final loaded = await ensureLookupsLoaded();
    if (loaded && planId != null) {
      await getPlanById(planId);
      return;
    }

    if (loaded) {
      emit(state.copyWith(status: PlanInfoStatus.loaded, clearMessage: true));
    }
  }

  Future<bool> ensureLookupsLoaded() async {
    if (state.emdadUnits.isNotEmpty &&
        state.shifts.isNotEmpty &&
        state.locations.isNotEmpty) {
      return true;
    }

    return loadLookups();
  }

  Future<void> fetchPlans({bool reset = true}) async {
    final requestVersion = beginLatestRequest('list');
    if (reset) {
      _skip = 0;
      emit(state.copyWith(status: PlanInfoStatus.loading, clearMessage: true));
    }

    final result = await _getPlanListUseCase(_buildFilterParam());
    if (!isLatestRequest(requestVersion, 'list') || isClosed) return;

    result.when(
      success: (data, _, __) {
        final nextItems = reset
            ? data.items
            : <PlanInfoEntity>[...state.items, ...data.items];

        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            items: nextItems,
            totalCount: data.totalCount,
            hasMore: nextItems.length < data.totalCount,
            clearMessage: true,
          ),
        );
      },
      failure: (_, message) {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'دریافت لیست برنامه‌ریزی با خطا مواجه شد',
          ),
        );
      },
      expireToken: () {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: 'نشست کاربری منقضی شده است',
          ),
        );
      },
      connectionError: () {
        emit(state.copyWith(status: PlanInfoStatus.connectionError));
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || _isLoadingMore) return;

    _isLoadingMore = true;
    _skip += _pageSize;

    emit(state.copyWith(status: PlanInfoStatus.loadingMore));

    await fetchPlans(reset: false);

    _isLoadingMore = false;
  }

  Future<void> loadHistory({required int refId}) async {
    if (state.loadingHistoryRefId == refId) return;

    emit(
      state.copyWith(
        status: PlanInfoStatus.loading,
        loadingHistoryRefId: refId,
        histories: const [],
        clearMessage: true,
      ),
    );

    final result = await _getPlanHistoriesUseCase(
      PlanHistoryParamEntity(refId: refId),
    );

    result.when(
      success: (items, _, __) {
        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            histories: items,
            clearLoadingHistoryRefId: true,
            clearMessage: true,
          ),
        );
      },
      failure: (_, message) {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'دریافت تاریخچه برنامه‌ریزی با خطا مواجه شد',
            clearLoadingHistoryRefId: true,
          ),
        );
      },
      expireToken: () {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: 'نشست کاربری منقضی شده است',
            clearLoadingHistoryRefId: true,
          ),
        );
      },
      connectionError: () {
        emit(
          state.copyWith(
            status: PlanInfoStatus.connectionError,
            message: 'خطا در برقراری ارتباط با سرور',
            clearLoadingHistoryRefId: true,
          ),
        );
      },
    );
  }

  Future<bool> loadLookups() async {
    final result = await _getPlanLookupsUseCase();
    var loaded = false;

    result.when(
      success: (data, _, __) {
        loaded = true;
        final warningMessage = data.warningMessage?.trim();
        emit(
          state.copyWith(
            status: warningMessage?.isNotEmpty == true
                ? PlanInfoStatus.error
                : PlanInfoStatus.loaded,
            emdadUnits: data.emdadUnits,
            shifts: data.shifts,
            specialPlans: data.specialPlans,
            locations: data.locations,
            message: warningMessage,
            clearMessage: warningMessage?.isNotEmpty != true,
          ),
        );
      },
      failure: (_, message) {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'دریافت اطلاعات اولیه فرم با خطا مواجه شد',
          ),
        );
      },
      expireToken: () {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: 'نشست کاربری منقضی شده است',
          ),
        );
      },
      connectionError: () {
        emit(
          state.copyWith(
            status: PlanInfoStatus.connectionError,
            message: 'خطا در دریافت اطلاعات اولیه فرم برنامه‌ریزی',
          ),
        );
      },
    );

    return loaded;
  }

  Future<PlanInfoEntity?> getPlanById(int id) async {
    emit(state.copyWith(status: PlanInfoStatus.submitting));

    final result = await _getPlanByIdUseCase(id);

    return result.when<Future<PlanInfoEntity?>>(
      success: (data, _, __) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            selectedPlan: data,
            clearMessage: true,
          ),
        );

        return data;
      },
      failure: (_, message) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'دریافت اطلاعات برنامه‌ریزی با خطا مواجه شد',
          ),
        );

        return null;
      },
      expireToken: () async => null,
      connectionError: () async {
        emit(state.copyWith(status: PlanInfoStatus.connectionError));
        return null;
      },
    );
  }

  Future<bool> savePlan({
    int? id,
    required bool isEdit,
    required bool isCopy,
    required int? emdadUnitId,
    required int? shiftId,
    required String fromDate,
    required String toDate,
    required bool hasSpecialPlan,
    required int? specialPlanId,
    required int? seatType,
    required int? locationId,
    bool refreshAfterSuccess = true,
  }) async {
    final validationMessage = _validatePlanForm(
      emdadUnitId: emdadUnitId,
      shiftId: shiftId,
      fromDate: fromDate,
      toDate: toDate,
      hasSpecialPlan: hasSpecialPlan,
      specialPlanId: specialPlanId,
      seatType: seatType,
      locationId: locationId,
    );

    if (validationMessage != null) {
      emit(
        state.copyWith(
          status: PlanInfoStatus.error,
          message: validationMessage,
        ),
      );
      return false;
    }

    final location = _findById(state.locations, locationId);

    final param = CreatePlanInfoParamEntity(
      id: isEdit && !isCopy ? id : null,
      title: _buildPlanTitle(emdadUnitId, shiftId),
      emdadUnitId: emdadUnitId!,
      shiftId: shiftId!,
      latitude: location?.latitude,
      longitude: location?.longitude,
      fromDate: fromDate,
      toDate: toDate,
      address: location?.address,
      specialPlanId: hasSpecialPlan ? specialPlanId : null,
      seatType: seatType!,
      locationId: locationId!,
    );

    emit(state.copyWith(status: PlanInfoStatus.submitting, clearMessage: true));

    final ApiResult<String> result = isEdit && !isCopy
        ? await _editPlanUseCase(param)
        : await _createPlanUseCase(param);

    return result.when<Future<bool>>(
      success: (_, __, ___) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            message: isEdit && !isCopy
                ? 'برنامه‌ریزی با موفقیت ویرایش شد'
                : 'برنامه‌ریزی با موفقیت ثبت شد',
          ),
        );

        if (refreshAfterSuccess) {
          await fetchPlans();
        }

        return true;
      },
      failure: (_, message) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'ثبت برنامه‌ریزی با خطا مواجه شد',
          ),
        );

        return false;
      },
      expireToken: () async => false,
      connectionError: () async {
        emit(state.copyWith(status: PlanInfoStatus.connectionError));
        return false;
      },
    );
  }

  Future<void> deletePlan(int id) async {
    emit(state.copyWith(status: PlanInfoStatus.submitting));

    final result = await _deletePlanUseCase(id);

    await result.when<Future<void>>(
      success: (_, __, ___) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            message: 'برنامه‌ریزی با موفقیت حذف شد',
          ),
        );

        await fetchPlans();
      },
      failure: (_, message) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'حذف برنامه‌ریزی با خطا مواجه شد',
          ),
        );
      },
      expireToken: () async {},
      connectionError: () async {
        emit(state.copyWith(status: PlanInfoStatus.connectionError));
      },
    );
  }

  Future<void> loadStatusReasons() async {
    final result = await _getPlanStatusReasonsUseCase();

    result.when(
      success: (data, _, __) {
        emit(state.copyWith(
          statusReasons: data,
          clearMessage: true,
        ));
      },
      failure: (_, __) {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: 'سرویس دلایل تغییر وضعیت در دسترس نیست',
          ),
        );
      },
      expireToken: () {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: 'نشست کاربری منقضی شده است',
          ),
        );
      },
      connectionError: () {
        emit(
          state.copyWith(
            status: PlanInfoStatus.connectionError,
            message: 'سرویس دلایل تغییر وضعیت در دسترس نیست',
          ),
        );
      },
    );
  }

  Future<bool> changeStatus({
    required int planId,
    required int? reasonId,
    required String description,
    required bool isActive,
  }) async {
    if (reasonId == null) {
      emit(
        state.copyWith(
          status: PlanInfoStatus.error,
          message: 'دلیل تغییر وضعیت اجباری می باشد',
        ),
      );
      return false;
    }

    if (description.trim().isEmpty) {
      emit(
        state.copyWith(
          status: PlanInfoStatus.error,
          message: 'توضیحات اجباری می باشد',
        ),
      );
      return false;
    }

    emit(state.copyWith(status: PlanInfoStatus.submitting));

    final result = await _changePlanStatusUseCase(
      ChangePlanStatusParamEntity(
        planId: planId,
        isActive: isActive,
        reasonId: reasonId,
        description: description.trim(),
      ),
    );

    return result.when<Future<bool>>(
      success: (_, __, ___) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            message: 'عملیات با موفقیت انجام شد',
          ),
        );

        await fetchPlans();

        return true;
      },
      failure: (_, message) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'تغییر وضعیت با خطا مواجه شد',
          ),
        );

        return false;
      },
      expireToken: () async => false,
      connectionError: () async {
        emit(state.copyWith(status: PlanInfoStatus.connectionError));
        return false;
      },
    );
  }

  Future<void> loadPlanReport() async {
    if (state.isReportLoading) return;

    emit(
      state.copyWith(
        isReportLoading: true,
        clearReportFilePath: true,
        clearMessage: true,
      ),
    );

    final result = await _getPlanReportUseCase(
      _buildFilterParam(pageSize: 0),
    );

    await result.when<Future<void>>(
      success: (items, _, __) async {
        if (items.isEmpty) {
          emit(
            state.copyWith(
              status: PlanInfoStatus.error,
              isReportLoading: false,
              message: 'داده‌ای برای تهیه گزارش وجود ندارد.',
            ),
          );
          return;
        }

        final exportResult = await _exportExcelUseCase(
          PlanInfoExcelReportFactory.create(items),
        );

        exportResult.when(
          success: (data, failures, resultCode) => emit(
            state.copyWith(
              status: PlanInfoStatus.loaded,
              isReportLoading: false,
              reportItems: items,
              reportFilePath: data.displayPath,
              message: data.isBrowserDownload
                  ? 'دانلود فایل گزارش آغاز شد.'
                  : 'فایل اکسل گزارش برنامه‌ریزی ذخیره شد.',
            ),
          ),
          failure: (error, failures) => emit(
            state.copyWith(
              status: PlanInfoStatus.error,
              isReportLoading: false,
              message: failures ?? 'ذخیره فایل گزارش با خطا مواجه شد.',
            ),
          ),
          expireToken: () => emit(
            state.copyWith(
              status: PlanInfoStatus.error,
              isReportLoading: false,
              message: 'نشست کاربری منقضی شده است.',
            ),
          ),
          connectionError: () => emit(
            state.copyWith(
              status: PlanInfoStatus.error,
              isReportLoading: false,
              message: 'ذخیره فایل گزارش با خطا مواجه شد.',
            ),
          ),
        );
      },
      failure: (_, message) async => emit(
        state.copyWith(
          status: PlanInfoStatus.error,
          isReportLoading: false,
          message: message ?? 'دریافت گزارش با خطا مواجه شد.',
        ),
      ),
      expireToken: () async => emit(
        state.copyWith(
          status: PlanInfoStatus.error,
          isReportLoading: false,
          message: 'نشست کاربری منقضی شده است.',
        ),
      ),
      connectionError: () async => emit(
        state.copyWith(
          status: PlanInfoStatus.connectionError,
          isReportLoading: false,
          message: 'اتصال به اینترنت برقرار نیست.',
        ),
      ),
    );
  }

  Future<void> previewCancelation(int planId) async {
    emit(
      state.copyWith(
        status: PlanInfoStatus.submitting,
        clearCancelation: true,
      ),
    );

    final result = await _cancelPlanRequestsUseCase(
      CancelPlanRequestsParamEntity(planId: planId, shouldCancel: false),
    );

    await result.when<Future<void>>(
      success: (data, _, __) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            cancelation: data,
          ),
        );
      },
      failure: (_, message) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'دریافت ماموریت‌های برنامه با خطا مواجه شد',
          ),
        );
      },
      expireToken: () async {},
      connectionError: () async {
        emit(state.copyWith(status: PlanInfoStatus.connectionError));
      },
    );
  }

  Future<bool> confirmCancelation(int planId) async {
    emit(state.copyWith(status: PlanInfoStatus.submitting));

    final result = await _cancelPlanRequestsUseCase(
      CancelPlanRequestsParamEntity(planId: planId, shouldCancel: true),
    );

    return result.when<Future<bool>>(
      success: (_, __, ___) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            message: 'عملیات با موفقیت انجام شد',
            clearCancelation: true,
          ),
        );

        await fetchPlans();

        return true;
      },
      failure: (_, message) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'لغو ماموریت���ها با خطا مواجه شد',
          ),
        );

        return false;
      },
      expireToken: () async => false,
      connectionError: () async {
        emit(state.copyWith(status: PlanInfoStatus.connectionError));
        return false;
      },
    );
  }

  void clearFilters() {
    titleController.clear();
    emdadUnitController.clear();
    shiftController.clear();
    specialPlanController.clear();
    locationController.clear();
    fromDateController.clear();
    toDateController.clear();
    seatTypeFilter = null;
    emit(state.copyWith(clearActiveFilter: true));

    fetchPlans();
  }

  void changeActiveFilter(bool? value) {
    emit(
      state.copyWith(
        activeFilter: value,
        clearActiveFilter: value == null,
        clearMessage: true,
      ),
    );
  }

  void setSeatTypeFilter(int? value) {
    seatTypeFilter = value;
  }

  String _buildPlanTitle(int? emdadUnitId, int? shiftId) {
    final unitTitle = _findById(state.emdadUnits, emdadUnitId)?.displayTitle;
    final shiftTitle = _findById(state.shifts, shiftId)?.displayTitle;

    return [unitTitle, shiftTitle]
        .whereType<String>()
        .where((item) => item.trim().isNotEmpty && item != '---')
        .join('، ');
  }

  String? _validatePlanForm({
    required int? emdadUnitId,
    required int? shiftId,
    required String fromDate,
    required String toDate,
    required bool hasSpecialPlan,
    required int? specialPlanId,
    required int? seatType,
    required int? locationId,
  }) {
    if (emdadUnitId == null) return 'واحد امدادی اجباری می باشد';
    if (shiftId == null) return 'انتخاب شیفت اجباری می باشد';
    if (fromDate.trim().isEmpty) return 'تاریخ شروع اجباری می باشد';
    if (toDate.trim().isEmpty) return 'تاریخ پایان اجباری می باشد';
    if (hasSpecialPlan && specialPlanId == null) return 'انتخاب طرح اجباری می باشد';
    if (seatType == null || seatType == -1) return 'نوع مقر اجباری می باشد';
    if (locationId == null) return 'محل استقرار اجباری می باشد';
    return null;
  }

  PlanLookupEntity? _findById(List<PlanLookupEntity> items, int? id) {
    if (id == null) return null;

    for (final item in items) {
      if (item.resolvedId == id) return item;
    }

    return null;
  }

  PlanFilterParamEntity _buildFilterParam({int? pageSize}) {
    return PlanFilterParamEntity(
      skip: _skip,
      pageSize: pageSize ?? _pageSize,
      title: titleController.text,
      emdadUnitName: emdadUnitController.text,
      shiftTitle: shiftController.text,
      specialPlanTitle: specialPlanController.text,
      seatType: seatTypeFilter,
      locationTitle: locationController.text,
      fromDate: fromDateController.text,
      toDate: toDateController.text,
    );
  }

  void _loadSeatTypesFromSession() {
    final seatTypes = _currentSessionManager.currentSession?.enums?.seatType
        ?.map(
          (item) => PlanLookupEntity(
        id: item.value,
        value: item.value,
        title: item.title ?? item.name,
      ),
    )
        .toList() ??
        const <PlanLookupEntity>[];

    emit(state.copyWith(seatTypes: seatTypes));
  }


  Future<void> initLocationPage() async {
    if (state.locations.isNotEmpty) {
      return;
    }

    emit(
      state.copyWith(
        status: PlanInfoStatus.loading,
        clearMessage: true,
      ),
    );

    final result = await _getPlanLookupsUseCase();

    result.when(
      success: (data, _, __) {
        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            locations: data.locations,
            clearMessage: true,
          ),
        );
      },
      failure: (_, message) {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message:
            message ??
                'دریافت محل‌های استقرار با خطا مواجه شد',
          ),
        );
      },
      expireToken: () {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: 'نشست کاربری منقضی شده است',
          ),
        );
      },
      connectionError: () {
        emit(
          state.copyWith(
            status: PlanInfoStatus.connectionError,
          ),
        );
      },
    );
  }


    Future<bool> changeLocation({
      required int planId,
      required int emdadUnitId,
      required int locationId,
      required double latitude,
      required double longitude,
      required String address,
    }) async {
      if (state.status == PlanInfoStatus.submitting) {
        return false;
      }

      emit(
        state.copyWith(
          status: PlanInfoStatus.submitting,
          clearMessage: true,
        ),
      );

      final result = await _changeLocationUseCase(
        ChangePlanInfoLocationParamEntity(
          planId: planId,
          emdadUnitId: emdadUnitId,
          locationId: locationId,
          latitude: latitude,
          longitude: longitude,
          address: address.trim(),
        ),
      );

      return result.when<Future<bool>>(
        success: (_, __, ___) async {
          emit(
            state.copyWith(
              status: PlanInfoStatus.loaded,
              message:
              'محل استقرار با موفقیت تغییر کرد',
            ),
          );

          return true;
        },
        failure: (_, message) async {
          emit(
            state.copyWith(
              status: PlanInfoStatus.error,
              message:
              message ??
                  'تغییر محل استقرار با خطا مواجه شد',
            ),
          );

          return false;
        },
        expireToken: () async {
          emit(
            state.copyWith(
              status: PlanInfoStatus.error,
              message: 'نشست کاربری منقضی شده است',
            ),
          );

          return false;
        },
        connectionError: () async {
          emit(
            state.copyWith(
              status: PlanInfoStatus.connectionError,
            ),
          );

          return false;
        },
      );
    }


  @override
  Future<void> close() {
    titleController.dispose();
    emdadUnitController.dispose();
    shiftController.dispose();
    specialPlanController.dispose();
    locationController.dispose();
    fromDateController.dispose();
    toDateController.dispose();

    return super.close();
  }
}
