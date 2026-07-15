part of 'rescuer_detail_cubit.dart';

@freezed
abstract class RescuerDetailStateData with _$RescuerDetailStateData {
  const factory RescuerDetailStateData({
    RescuerEntity? rescuer,
    @Default([])
    List<SkillCertificateEntity> skillCertificates,
    @Default([]) List<SanHistoryEntity> histories,
    @Default(false) bool isDeleting,
  }) = _RescuerDetailStateData;
}

@freezed
abstract class RescuerDetailState with _$RescuerDetailState {
  const factory RescuerDetailState.idle({
    @Default(RescuerDetailStateData()) RescuerDetailStateData data,
  }) = _Idle;

  const factory RescuerDetailState.loading({
    required RescuerDetailStateData data,
  }) = _Loading;

  const factory RescuerDetailState.loaded({
    required RescuerDetailStateData data,
  }) = _Loaded;

  const factory RescuerDetailState.actionLoading({
    required RescuerDetailStateData data,
  }) = _ActionLoading;

  const factory RescuerDetailState.error({
    required RescuerDetailStateData data,
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory RescuerDetailState.actionError({
    required RescuerDetailStateData data,
    required String message,
  }) = _ActionError;

  const factory RescuerDetailState.connectionError({
    required RescuerDetailStateData data,
  }) = _ConnectionError;
}

extension RescuerDetailStateX on RescuerDetailState {
  RescuerDetailStateData get data {
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
