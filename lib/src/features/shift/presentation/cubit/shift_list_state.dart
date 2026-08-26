part of 'shift_list_cubit.dart';

@freezed
sealed class ShiftListState with _$ShiftListState {
  const factory ShiftListState.initial() = _Initial;

  const factory ShiftListState.loading({
    required ShiftFilterParamEntity filter,
  }) = _Loading;

  const factory ShiftListState.loaded({
    required List<ShiftEntity> items,
    required int totalCount,
    required bool hasMore,
    required ShiftFilterParamEntity filter,
  }) = _Loaded;

  const factory ShiftListState.empty({
    required ShiftFilterParamEntity filter,
  }) = _Empty;

  const factory ShiftListState.loadingMore({
    required List<ShiftEntity> items,
    required int totalCount,
    required ShiftFilterParamEntity filter,
  }) = _LoadingMore;

  const factory ShiftListState.deleting({
    required List<ShiftEntity> items,
    required int deletingItemId,
  }) = _Deleting;

  const factory ShiftListState.success({
    required ShiftListAction action,
    required String message,
  }) = _Success;

  const factory ShiftListState.failure({
    required String message,
    @Default([]) List<ShiftEntity> items,
  }) = _Failure;

  const factory ShiftListState.connectionError({
    required ShiftFilterParamEntity filter,
    @Default([]) List<ShiftEntity> items,
  }) = _ConnectionError;

  const factory ShiftListState.exporting({
    required List<ShiftEntity> items,
    required ShiftFilterParamEntity filter,
  }) = _Exporting;
}
