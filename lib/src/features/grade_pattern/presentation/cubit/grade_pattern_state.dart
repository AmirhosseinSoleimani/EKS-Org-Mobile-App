part of 'grade_pattern_cubit.dart';

@freezed
sealed class GradePatternState with _$GradePatternState {
  const factory GradePatternState.initial() = _Initial;

  const factory GradePatternState.loading({
    required GradePatternFilterParamEntity filter,
  }) = _Loading;

  const factory GradePatternState.loaded({
    required List<GradePatternEntity> items,
    required int totalCount,
    required bool hasMore,
    required GradePatternFilterParamEntity filter,
  }) = _Loaded;

  const factory GradePatternState.empty({
    required GradePatternFilterParamEntity filter,
  }) = _Empty;

  const factory GradePatternState.loadingMore({
    required List<GradePatternEntity> items,
    required int totalCount,
    required GradePatternFilterParamEntity filter,
  }) = _LoadingMore;

  const factory GradePatternState.detailLoading({
    @Default([]) List<GradePatternEntity> items,
  }) = _DetailLoading;

  const factory GradePatternState.detailLoaded({
    required GradePatternEntity item,
  }) = _DetailLoaded;

  const factory GradePatternState.formReady({
    required GradePatternEntity item,
  }) = _FormReady;

  const factory GradePatternState.referencesLoaded({
    required List<GradePatternEntity> patterns,
    required List<GradePatternReferenceEntity> references,
  }) = _ReferencesLoaded;

  const factory GradePatternState.submitting({
    GradePatternEntity? item,
    @Default([]) List<GradePatternEntity> items,
  }) = _Submitting;

  const factory GradePatternState.success({
    required GradePatternAction action,
    required String message,
    @Default([]) List<GradePatternEntity> items,
  }) = _Success;

  const factory GradePatternState.failure({
    required String message,
    @Default([]) List<GradePatternEntity> items,
  }) = _Failure;

  const factory GradePatternState.connectionError({
    required GradePatternFilterParamEntity filter,
    @Default([]) List<GradePatternEntity> items,
  }) = _ConnectionError;


}
