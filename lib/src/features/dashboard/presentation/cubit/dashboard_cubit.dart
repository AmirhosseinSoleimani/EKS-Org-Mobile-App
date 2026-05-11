import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/chart_data_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/entities/dashboard_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/use_cases/get_dashboard_data_use_case.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/domain/use_cases/get_server_date_time_use_case.dart';
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
  DashboardCubit(this._getDashboardDataUseCase, this._getServerDateTimeUseCase)
      : super(const DashboardState.idle());
  final GetDashboardDataUseCase _getDashboardDataUseCase;
  final GetServerDateTimeUseCase _getServerDateTimeUseCase;

  DashboardEntity? dashboardData;

  /// selected filters
  final selectedServiceTypeNotifier =
      ValueNotifier<ServiceType>(ServiceType.reliefService);
  final selectedFromDateNotifier = ValueNotifier<DateTime?>(null);
  final selectedToDateNotifier = ValueNotifier<DateTime?>(null);

  ServiceType get selectedServiceType => selectedServiceTypeNotifier.value;

  DateTime? get selectedFromDate => selectedFromDateNotifier.value;

  DateTime? get selectedToDate => selectedToDateNotifier.value;

  Future<void> loadDashboardData() async {
    _safeEmit(const DashboardState.loading());

    await _loadDashboard();
  }

  void init() async{
    _safeEmit(const DashboardState.loading());
    await _loadServerDateOrFallback();
    await _loadDashboard();
  }

  Future<void> _loadServerDateOrFallback() async {
    final now = DateTime.now();
    DateTime dateValue = now;

    final result = await _getServerDateTimeUseCase();

    result.when(
      success: (data, failures, code) {
        dateValue = _safeParseDate(data?.date) ?? now;
      },
      failure: (_, _) => dateValue = now,
      connectionError: () => dateValue = now,
      expireToken: () => dateValue = now,
    );

    selectedFromDateNotifier.value = dateValue;
    selectedToDateNotifier.value = dateValue;
  }

  DateTime? _safeParseDate(String? value) {
    try {
      if (value == null) return null;
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  Future<void> _loadDashboard() async {
    final param = DashboardParamEntity(
      serviceType: selectedServiceType,
      fromDateTime: selectedFromDate,
      toDateTime: selectedToDate,
    );

    final result = await _getDashboardDataUseCase(param);

    result.whenOrNull(
      success: (data, failures, code) {
        dashboardData = data;
        _safeEmit(const DashboardState.loaded());
      },
      failure: (_, msg) {
        _safeEmit(
          DashboardState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () {
        _safeEmit(const DashboardState.connectionError());
      },
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
