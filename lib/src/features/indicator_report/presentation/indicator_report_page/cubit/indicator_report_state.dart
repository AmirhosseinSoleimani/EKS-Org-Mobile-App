part of 'indicator_report_cubit.dart';

@freezed
class IndicatorReportState with _$IndicatorReportState {
  const factory IndicatorReportState.idle() = _Idle;

  const factory IndicatorReportState.loading() = _Loading;

  const factory IndicatorReportState.loaded() = _Loaded;

  const factory IndicatorReportState.error({
    required BottomSheetMessageModel message,
  }) = _Error;


  const factory IndicatorReportState.connectionError() = _ConnectionError;
}

