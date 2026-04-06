import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'indicator_report_cubit.freezed.dart';

part 'indicator_report_state.dart';

class IndicatorReportCubit extends Cubit<IndicatorReportState> {
  IndicatorReportCubit() : super(const IndicatorReportState.idle());

  List<dynamic> items = [];

  Future<void> loadReports() async {
    emit(const IndicatorReportState.loading());

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      items = [];

      _safeEmit(const IndicatorReportState.loaded());
    } catch (e) {
      _safeEmit(IndicatorReportState.error(message: e.toString()));
    }
  }

  void _safeEmit(IndicatorReportState state) {
    if (!isClosed) emit(state);
  }
}
