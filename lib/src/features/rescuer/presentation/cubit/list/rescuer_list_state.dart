part of 'rescuer_list_cubit.dart';

@freezed
abstract class RescuerListStateData with _$RescuerListStateData {
  const factory RescuerListStateData({
    @Default([]) List<RescuerEntity> items,
    @Default([]) List<RescuerEntity> filteredItems,
    @Default(RescuerStatusFilter.all) RescuerStatusFilter selectedStatus,
    int? deletingRescuerId,
  }) = _RescuerListStateData;
}

@freezed
abstract class RescuerListState with _$RescuerListState {
  const factory RescuerListState.idle({
    @Default(RescuerListStateData()) RescuerListStateData data,
  }) = _Idle;

  const factory RescuerListState.loading({required RescuerListStateData data}) =
      _Loading;

  const factory RescuerListState.loaded({required RescuerListStateData data}) =
      _Loaded;

  const factory RescuerListState.actionLoading({
    required RescuerListStateData data,
  }) = _ActionLoading;

  const factory RescuerListState.error({
    required RescuerListStateData data,
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory RescuerListState.actionError({
    required RescuerListStateData data,
    required String message,
  }) = _ActionError;

  const factory RescuerListState.connectionError({
    required RescuerListStateData data,
  }) = _ConnectionError;
}

extension RescuerListStateX on RescuerListState {
  RescuerListStateData get data {
    return when(
      idle: (data) => data,
      loading: (data) => data,
      loaded: (data) => data,
      actionLoading: (data) => data,
      error: (data, message) => data,
      actionError: (data, message) => data,
      connectionError: (data) => data,
    );
  }
}
