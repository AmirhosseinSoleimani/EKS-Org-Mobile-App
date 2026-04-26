import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/chart_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/use_cases/get_dashboard_data_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
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

  int calculateTotalCount(List<ChartDataEntity>? items) {
    if (items == null || items.isEmpty) return 0;

    return items.fold<int>(
      0,
          (sum, item) => sum + (item.count),
    );
  }
}
