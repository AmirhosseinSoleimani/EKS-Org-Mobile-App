part of 'skills_certificates_cubit.dart';

@freezed
abstract class SkillsCertificatesStateData with _$SkillsCertificatesStateData {
  const factory SkillsCertificatesStateData({
    @Default([]) List<SkillCertificateEntity> items,
    @Default(0) int totalCount,
    @Default(false) bool hasMore,
    bool? activeFilter,
    SkillCertificateEntity? selectedSkill,
    @Default([]) List<SkillServiceEntity> services,
    @Default(<int>{}) Set<int> selectedServiceIds,
    @Default('') String serviceSearchText,
    @Default(false) bool isInitialLoading,
    @Default(false) bool isSubmitting,
    @Default(false) bool isServicesLoading,
    @Default(false) bool isServicesSubmitting,
    @Default(false) bool isReportLoading,
    int? deletingSkillId,
    String? message,
    String? reportFilePath,
  }) = _SkillsCertificatesStateData;
}

@freezed
abstract class SkillsCertificatesState with _$SkillsCertificatesState {
  const factory SkillsCertificatesState.idle({
    @Default(SkillsCertificatesStateData()) SkillsCertificatesStateData data,
  }) = _Idle;

  const factory SkillsCertificatesState.loading({
    required SkillsCertificatesStateData data,
  }) = _Loading;

  const factory SkillsCertificatesState.loaded({
    required SkillsCertificatesStateData data,
  }) = _Loaded;

  const factory SkillsCertificatesState.error({
    required SkillsCertificatesStateData data,
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory SkillsCertificatesState.loadingMore({
    required SkillsCertificatesStateData data,
  }) = _LoadingMore;

  const factory SkillsCertificatesState.connectionError({
    required SkillsCertificatesStateData data,
  }) = _ConnectionError;
}

extension SkillsCertificatesStateX on SkillsCertificatesState {
  SkillsCertificatesStateData get data {
    return when(
      idle: (data) => data,
      loading: (data) => data,
      loaded: (data) => data,
      error: (data, message) => data,
      loadingMore: (data) => data,
      connectionError: (data) => data,
    );
  }
}
