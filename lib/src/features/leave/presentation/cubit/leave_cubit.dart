import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_list_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_reason_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_status.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/leave_type.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/change_leave_status_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/get_leave_reports_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/entities/param/rollback_leave_request_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/use_cases/change_leave_status_use_case.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/use_cases/get_leave_details_use_case.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/use_cases/get_leave_reasons_use_case.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/use_cases/get_leave_reports_use_case.dart';
import 'package:eks_sana_plus_org/src/features/leave/domain/use_cases/rollback_leave_request_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'leave_state.dart';

@injectable
class LeaveCubit extends Cubit<LeaveState> {
  LeaveCubit(
    this._getLeaveReportsUseCase,
    this._getLeaveDetailsUseCase,
    this._getLeaveReasonsUseCase,
    this._changeLeaveStatusUseCase,
    this._rollbackLeaveRequestUseCase,
  ) : super(const LeaveState());

  final GetLeaveReportsUseCase _getLeaveReportsUseCase;
  final GetLeaveDetailsUseCase _getLeaveDetailsUseCase;
  final GetLeaveReasonsUseCase _getLeaveReasonsUseCase;
  final ChangeLeaveStatusUseCase _changeLeaveStatusUseCase;
  final RollbackLeaveRequestUseCase _rollbackLeaveRequestUseCase;

  final TextEditingController agencyCodeController = TextEditingController();
  final TextEditingController emdadgarNameController = TextEditingController();

  static const statusOptions = <LeaveStatusOption>[
    LeaveStatusOption(title: 'همه', status: LeaveStatus.all),
    LeaveStatusOption(title: 'تایید شده', status: LeaveStatus.accepted),
    LeaveStatusOption(title: 'رد شده', status: LeaveStatus.rejected),
    LeaveStatusOption(title: 'ثبت شده', status: LeaveStatus.registered),
  ];

  static const typeOptions = <LeaveTypeOption>[
    LeaveTypeOption(title: 'همه', type: LeaveType.all),
    LeaveTypeOption(title: 'روزانه', type: LeaveType.daily),
    LeaveTypeOption(title: 'ساعتی', type: LeaveType.hourly),
  ];

  Future<void> init() async {
    await Future.wait([
      getReasons(),
      getLeaveReports(),
    ]);
  }

  Future<void> getReasons() async {
    emit(state.copyWith(isReasonsLoading: true, clearLastMessage: true));

    final result = await _getLeaveReasonsUseCase();

    result.when(
      success: (items, failures, resultCode) {
        emit(
          state.copyWith(
            reasons: items,
            isReasonsLoading: false,
          ),
        );
      },
      failure: (error, failures) {
        emit(
          state.copyWith(
            isReasonsLoading: false,
            lastMessage: _message(
              'خطا در دریافت دلایل',
              failures ?? 'دریافت دلایل مرخصی با خطا مواجه شد.',
            ),
          ),
        );
      },
      expireToken: () => emit(state.copyWith(isReasonsLoading: false)),
      connectionError: () {
        emit(state.copyWith(
          isReasonsLoading: false,
          hasConnectionError: true,
        ));
      },
    );
  }

  Future<void> getLeaveReports() async {
    emit(
      state.copyWith(
        isListLoading: true,
        hasConnectionError: false,
        clearLastMessage: true,
      ),
    );

    final result = await _getLeaveReportsUseCase(_buildFilterParam());

    result.when(
      success: (items, failures, resultCode) {
        emit(
          state.copyWith(
            items: items,
            filteredItems: _filterItems(items, state.searchText),
            isListLoading: false,
          ),
        );
      },
      failure: (error, failures) {
        emit(
          state.copyWith(
            isListLoading: false,
            lastMessage: _message(
              'خطا در دریافت مرخصی‌ها',
              failures ?? 'دریافت لیست مرخصی‌ها با خطا مواجه شد.',
            ),
          ),
        );
      },
      expireToken: () => emit(state.copyWith(isListLoading: false)),
      connectionError: () {
        emit(
          state.copyWith(
            isListLoading: false,
            hasConnectionError: true,
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    await getLeaveReports();
  }

  Future<void> getDetails(int id) async {
    emit(
      state.copyWith(
        isDetailsLoading: true,
        clearDetails: true,
        clearLastMessage: true,
        actionCompleted: false,
      ),
    );

    final result = await _getLeaveDetailsUseCase(id);

    result.when(
      success: (details, failures, resultCode) {
        emit(state.copyWith(details: details, isDetailsLoading: false));
      },
      failure: (error, failures) {
        emit(
          state.copyWith(
            isDetailsLoading: false,
            lastMessage: _message(
              'خطا در دریافت جزئیات',
              failures ?? 'دریافت جزئیات مرخصی با خطا مواجه شد.',
            ),
          ),
        );
      },
      expireToken: () => emit(state.copyWith(isDetailsLoading: false)),
      connectionError: () {
        emit(
          state.copyWith(
            isDetailsLoading: false,
            hasConnectionError: true,
          ),
        );
      },
    );
  }

  Future<void> approveRequest(int id) async {
    await _changeStatus(
      id: id,
      status: LeaveStatus.accepted,
      successMessage: 'مرخصی با موفقیت تایید شد',
    );
  }

  Future<void> rejectRequest({
    required int id,
    required String reason,
  }) async {
    await _changeStatus(
      id: id,
      status: LeaveStatus.rejected,
      description: reason,
      successMessage: 'مرخصی با موفقیت رد شد',
    );
  }

  Future<void> rollbackRequest(int id) async {
    emit(state.copyWith(isActionLoading: true, clearLastMessage: true));

    final result = await _rollbackLeaveRequestUseCase(
      RollbackLeaveRequestParamEntity(leaveRequestId: id),
    );

    result.when(
      success: (data, failures, resultCode) {
        emit(
          state.copyWith(
            isActionLoading: false,
            actionCompleted: true,
            lastMessage: _message(
              'عملیات موفق',
              'وضعیت مرخصی با موفقیت به ثبت شده تغییر یافت',
            ),
          ),
        );
      },
      failure: (error, failures) {
        emit(
          state.copyWith(
            isActionLoading: false,
            lastMessage: _message(
              'خطا در تغییر وضعیت',
              failures ?? 'بازگشت وضعیت مرخصی با خطا مواجه شد.',
            ),
          ),
        );
      },
      expireToken: () => emit(state.copyWith(isActionLoading: false)),
      connectionError: () {
        emit(
          state.copyWith(
            isActionLoading: false,
            hasConnectionError: true,
          ),
        );
      },
    );
  }

  void onStatusChanged(LeaveStatus status) {
    emit(state.copyWith(selectedStatus: status));
    getLeaveReports();
  }

  void onTypeChanged(LeaveType type) {
    emit(state.copyWith(selectedType: type));
  }

  void onMainReasonChanged(LeaveReasonEntity? reason) {
    emit(
      state.copyWith(
        selectedMainReason: reason,
        clearSelectedMainReason: reason == null,
        selectedSecondaryReason: null,
        clearSelectedSecondaryReason: true,
        secondaryReasons: reason?.secondaryReasons ?? const [],
      ),
    );
  }

  void onSecondaryReasonChanged(LeaveReasonEntity? reason) {
    emit(
      state.copyWith(
        selectedSecondaryReason: reason,
        clearSelectedSecondaryReason: reason == null,
      ),
    );
  }

  void onSearchTextChanged(String text) {
    emit(
      state.copyWith(
        searchText: text,
        filteredItems: _filterItems(state.items, text),
      ),
    );
  }

  Future<void> applyFilters() async {
    emit(
      state.copyWith(
        agencyCode: agencyCodeController.text.trim(),
        emdadgarFullName: emdadgarNameController.text.trim(),
      ),
    );
    await getLeaveReports();
  }

  Future<void> clearFilters() async {
    agencyCodeController.clear();
    emdadgarNameController.clear();
    emit(
      state.copyWith(
        selectedStatus: LeaveStatus.all,
        selectedType: LeaveType.all,
        agencyCode: '',
        emdadgarFullName: '',
        secondaryReasons: const [],
        clearSelectedMainReason: true,
        clearSelectedSecondaryReason: true,
      ),
    );
    await getLeaveReports();
  }

  Future<void> _changeStatus({
    required int id,
    required LeaveStatus status,
    required String successMessage,
    String description = '',
  }) async {
    emit(state.copyWith(isActionLoading: true, clearLastMessage: true));

    final result = await _changeLeaveStatusUseCase(
      ChangeLeaveStatusParamEntity(
        leaveRequestId: id,
        status: status.code,
        description: description,
      ),
    );

    result.when(
      success: (data, failures, resultCode) {
        emit(
          state.copyWith(
            isActionLoading: false,
            actionCompleted: true,
            lastMessage: _message('عملیات موفق', successMessage),
          ),
        );
      },
      failure: (error, failures) {
        emit(
          state.copyWith(
            isActionLoading: false,
            lastMessage: _message(
              'خطا در تغییر وضعیت',
              failures ?? 'تغییر وضعیت مرخصی با خطا مواجه شد.',
            ),
          ),
        );
      },
      expireToken: () => emit(state.copyWith(isActionLoading: false)),
      connectionError: () {
        emit(
          state.copyWith(
            isActionLoading: false,
            hasConnectionError: true,
          ),
        );
      },
    );
  }

  GetLeaveReportsParamEntity _buildFilterParam() {
    return GetLeaveReportsParamEntity(
      agencyCode: int.tryParse(state.agencyCode),
      emdadgarFullName: state.emdadgarFullName,
      type: state.selectedType == LeaveType.all ? null : state.selectedType.code,
      status:
          state.selectedStatus == LeaveStatus.all ? null : state.selectedStatus.code,
      mainReason: state.selectedMainReason?.id == 0
          ? null
          : state.selectedMainReason?.id,
      secondaryReason: state.selectedSecondaryReason?.id,
    );
  }

  List<LeaveListItemEntity> _filterItems(
    List<LeaveListItemEntity> items,
    String query,
  ) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return items;

    return items.where((item) {
      return [
        item.agencyName,
        item.agencyCode?.toString(),
        item.emdadgarFullName,
        item.personInfoMobile,
        item.leaveTypeText,
        item.statusText,
        item.mainReasonText,
        item.secondReasonText,
      ].whereType<String>().join(' ').toLowerCase().contains(normalized);
    }).toList();
  }

  BottomSheetMessageModel _message(String title, String message) {
    return BottomSheetMessageModel(title: title, message: message);
  }

  @override
  Future<void> close() {
    agencyCodeController.dispose();
    emdadgarNameController.dispose();
    return super.close();
  }
}
