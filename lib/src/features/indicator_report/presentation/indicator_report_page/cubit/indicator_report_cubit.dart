import 'package:bloc/bloc.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/indicatior_report_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/entity/report_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/domain/use_cases/fetch_indicator_report_use_case.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'indicator_report_cubit.freezed.dart';
part 'indicator_report_state.dart';

@injectable
@injectable
class IndicatorReportCubit extends Cubit<IndicatorReportState> {
  IndicatorReportCubit(this._fetchReportListUseCase)
      : super(const IndicatorReportState.idle());

  final FetchIndicatorReportUseCase _fetchReportListUseCase;

  IndicatorReportEntity? indicatorReport;

  /// selected filters
  final selectedServiceTypeNotifier = ValueNotifier<ServiceType?>(null);
  final selectedFromDateNotifier = ValueNotifier<DateTime?>(null);
  final selectedToDateNotifier = ValueNotifier<DateTime?>(null);

  ServiceType? get selectedServiceType => selectedServiceTypeNotifier.value;
  DateTime? get selectedFromDate => selectedFromDateNotifier.value;
  DateTime? get selectedToDate => selectedToDateNotifier.value;

  Future<void> loadReports() async {
    _safeEmit(const IndicatorReportState.loading());

    final param = ReportParamEntity(
      serviceType: selectedServiceType,
      fromDateTime: selectedFromDate,
      toDateTime: selectedToDate,
    );

    final result = await _fetchReportListUseCase(param);

    result.whenOrNull(
      success: (data, failures, resultCode) async {
        indicatorReport = data;
        _safeEmit(const IndicatorReportState.loaded());
      },
      failure: (error, msg) {
        _safeEmit(
          IndicatorReportState.error(
            message: BottomSheetMessageModel(
              message: msg ?? 'خطای غیر منتظره',
              title: '',
            ),
          ),
        );
      },
      connectionError: () =>
          _safeEmit(const IndicatorReportState.connectionError()),
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
    selectedServiceTypeNotifier.value = null;
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
  void _safeEmit(IndicatorReportState state) {
    if (!isClosed) emit(state);
  }
}

