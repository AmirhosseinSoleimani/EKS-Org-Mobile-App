part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.idle() = _Idle;

  const factory DashboardState.loading() = _Loading;

  const factory DashboardState.loaded() = _Loaded;

  const factory DashboardState.error({
    required BottomSheetMessageModel message,
  }) = _Error;


  const factory DashboardState.connectionError() = _ConnectionError;
}
