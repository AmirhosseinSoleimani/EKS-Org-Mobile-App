import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/chart_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/use_cases/get_dashboard_data_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'dashboard_cubit.freezed.dart';

part 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._getDashboardDataUseCase)
      : super(const DashboardState.idle());
  final GetDashboardDataUseCase _getDashboardDataUseCase;

  DashboardEntity? dashboardData;

  /// selected filters
  final selectedServiceTypeNotifier =
      ValueNotifier<ServiceType>(ServiceType.reliefService);
  final selectedFromDateNotifier = ValueNotifier<DateTime?>(null);
  final selectedToDateNotifier = ValueNotifier<DateTime?>(null);

  ServiceType get selectedServiceType => selectedServiceTypeNotifier.value;

  DateTime? get selectedFromDate => selectedFromDateNotifier.value;

  DateTime? get selectedToDate => selectedToDateNotifier.value;

  void loadDashboardData() async {
    _safeEmit(const DashboardState.loading());

    final param = DashboardParamEntity(
      serviceType: selectedServiceType,
      fromDateTime: DateTime(2026,04,22),
      toDateTime: DateTime(2026,04,22),
    );

    final result = await _getDashboardDataUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) async {
        dashboardData = data;
        _safeEmit(const DashboardState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          DashboardState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () => _safeEmit(const DashboardState.connectionError()),
    );
  }

  void setServiceType(ServiceType type) {
    selectedServiceTypeNotifier.value = type;
  }

  void setFromDate(DateTime date) {
    selectedFromDateNotifier.value = date;
  }

  void setToDate(DateTime date) {
    selectedToDateNotifier.value = date;
  }

  void clearFilters() {
    selectedServiceTypeNotifier.value = ServiceType.reliefService;
    selectedFromDateNotifier.value = null;
    selectedToDateNotifier.value = null;
  }

  @override
  Future<void> close() {
    selectedServiceTypeNotifier.dispose();
    selectedFromDateNotifier.dispose();
    selectedToDateNotifier.dispose();
    return super.close();
  }

  void _safeEmit(DashboardState state) {
    if (!isClosed) emit(state);
  }

  DashboardEntity _buildFakeDashboardEntity() {
    return const DashboardEntity(
      totalCallLogCount: 38,
      totalServiceRequests: 75,
      totalUrgentRequests: 12,
      followUpTabletCount: 8,
      followUpTabletPercent: 10.6,
      generalStatus: [
        ChartDataEntity(
          title: "باز",
          code: "Open",
          count: 42,
          percent: 56.0,
          color: "#3478F6",
        ),
        ChartDataEntity(
          title: "بسته",
          code: "Closed",
          count: 22,
          percent: 29.3,
          color: "#34C759",
        ),
        ChartDataEntity(
          title: "لغو شده",
          code: "Canceled",
          count: 11,
          percent: 14.6,
          color: "#FF3B30",
        ),
      ],
      openRequestsStatus: [
        ChartDataEntity(
          title: "در حال بررسی",
          code: "Pending",
          count: 18,
          percent: 42.8,
          color: "#FF9500",
        ),
        ChartDataEntity(
          title: "در حال انجام",
          code: "Processing",
          count: 24,
          percent: 57.1,
          color: "#3478F6",
        ),
      ],
      closedOrCanceledByCategory: [
        ChartDataEntity(
          title: "برق",
          code: "ELEC",
          count: 8,
          percent: 36.3,
          color: "#AF52DE",
        ),
        ChartDataEntity(
          title: "تعمیر موتور",
          code: "ENGINE",
          count: 14,
          percent: 63.6,
          color: "#30B0C7",
        ),
      ],
      closedOrCanceledByStatus: [
        ChartDataEntity(
          title: "بسته عادی",
          code: "NormalClosed",
          count: 16,
          percent: 72.7,
          color: "#34C759",
        ),
        ChartDataEntity(
          title: "بسته اضطراری",
          code: "UrgentClosed",
          count: 6,
          percent: 27.2,
          color: "#FF3B30",
        ),
      ],
      canceledByAssignStatus: [
        ChartDataEntity(
          title: "لغو قبل از اعزام",
          code: "BeforeAssign",
          count: 7,
          percent: 63.6,
          color: "#FF2D55",
        ),
        ChartDataEntity(
          title: "لغو بعد از اعزام",
          code: "AfterAssign",
          count: 4,
          percent: 36.3,
          color: "#5AC8FA",
        ),
      ],
    );
  }
}
