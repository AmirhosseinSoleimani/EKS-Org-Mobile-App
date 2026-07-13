import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/cancel_plan_requests_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/change_plan_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/create_plan_info_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/params/plan_filter_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/entities/plan_lookup_entity.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/domain/usecases/plan_info_usecases.dart';
import 'package:eks_sana_plus_org/src/features/plan_info/presentation/utils/plan_info_excel_exporter.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:open_filex/open_filex.dart';

import 'plan_info_state.dart';

@injectable
class PlanInfoCubit extends Cubit<PlanInfoState> {
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

  Future<void> ensureLookupsLoaded() async {
    if (state.emdadUnits.isNotEmpty &&
        state.shifts.isNotEmpty &&
        state.locations.isNotEmpty) {
      return;
    }

    await loadLookups();
  }

  Future<void> fetchPlans({bool reset = true}) async {
    if (reset) {
      _skip = 0;
      emit(state.copyWith(status: PlanInfoStatus.loading, clearMessage: true));
    }

    final result = await _getPlanListUseCase(_buildFilterParam());

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

  Future<void> loadLookups() async {
    final result = await _getPlanLookupsUseCase();

    result.whenOrNull(
      success: (data, _, __) {
        emit(
          state.copyWith(
            emdadUnits: data.emdadUnits,
            shifts: data.shifts,
            specialPlans: data.specialPlans,
            locations: data.locations,
          ),
        );
      },
      failure: (_, message) {
        emit(state.copyWith(message: message));
      },
    );
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
      emit(state.copyWith(message: validationMessage));
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

    final ApiResult<void> result = isEdit && !isCopy
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

        await fetchPlans();

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

    result.whenOrNull(
      success: (data, _, __) {
        emit(state.copyWith(statusReasons: data));
      },
      failure: (_, message) {
        emit(state.copyWith(message: message));
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
      emit(state.copyWith(message: 'دلیل تغییر وضعیت اجباری می باشد'));
      return false;
    }

    if (description.trim().isEmpty) {
      emit(state.copyWith(message: 'توضیحات اجباری می باشد'));
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
    emit(
      state.copyWith(
        status: PlanInfoStatus.submitting,
        clearReportFilePath: true,
      ),
    );

    final result = await _getPlanReportUseCase(_buildFilterParam(pageSize: 0));

    await result.when<Future<void>>(
      success: (data, _, __) async {
        final filePath = await PlanInfoExcelExporter.export(data);

        emit(
          state.copyWith(
            status: PlanInfoStatus.loaded,
            reportItems: data,
            reportFilePath: filePath,
            message: 'فایل اکسل گزارش برنامه‌ریزی آماده شد',
          ),
        );

        final openResult = await OpenFilex.open(
          filePath,
          type: 'application/vnd.ms-excel',
        );

        if (openResult.type != ResultType.done) {
          emit(
            state.copyWith(
              status: PlanInfoStatus.loaded,
              reportItems: data,
              reportFilePath: filePath,
              message: 'فایل اکسل ذخیره شد اما برنامه‌ای برای باز کردن آن پیدا نشد',
            ),
          );
        }
      },
      failure: (_, message) async {
        emit(
          state.copyWith(
            status: PlanInfoStatus.error,
            message: message ?? 'دریافت گزارش با خطا مواجه شد',
          ),
        );
      },
      expireToken: () async {},
      connectionError: () async {
        emit(state.copyWith(status: PlanInfoStatus.connectionError));
      },
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

    fetchPlans();
  }

  Future<void> changeActiveFilter(bool? value) async {
    emit(
      state.copyWith(
        activeFilter: value,
        clearActiveFilter: value == null,
        clearMessage: true,
      ),
    );

    await fetchPlans();
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
      isActive: state.activeFilter,
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