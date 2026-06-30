part of 'online_map_cubit.dart';

@freezed
class OnlineMapState with _$OnlineMapState {
  const factory OnlineMapState.idle() = _Idle;

  const factory OnlineMapState.loading() = _Loading;

  const factory OnlineMapState.loaded() = _Loaded;

  const factory OnlineMapState.loadedWithoutMap() = _LoadedWithoutMap;

  const factory OnlineMapState.mapLoading() = _MapLoading;

  const factory OnlineMapState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory OnlineMapState.refresh() = _Refresh;

  const factory OnlineMapState.connectionError() = _ConnectionError;

  const factory OnlineMapState.detailsToggled({required bool isExpanded}) = _DetailsToggled;
}
