part of 'agency_info_cubit.dart';

@freezed
abstract class AgencyInfoStateData with _$AgencyInfoStateData {
  const factory AgencyInfoStateData({
    @Default([]) List<AgencyInfoEntity> items,
    @Default([]) List<AgencyInfoEntity> selectorItems,
    AgencyInfoEntity? selectedAgency,
    @Default(AgencyInfoFilterParamEntity()) AgencyInfoFilterParamEntity filter,
    @Default(0) int totalCount,
    @Default(true) bool hasMore,
    @Default(false) bool isInitialLoading,
    @Default(false) bool isRefreshing,
    @Default(false) bool isPaginationLoading,
    @Default(false) bool isSelectorLoading,
    int? loadingDetailId,
    @Default('') String selectorSearchText,
    String? errorMessage,
  }) = _AgencyInfoStateData;
}

@freezed
abstract class AgencyInfoState with _$AgencyInfoState {
  const factory AgencyInfoState.idle({
    @Default(AgencyInfoStateData()) AgencyInfoStateData data,
  }) = _Idle;

  const factory AgencyInfoState.loading({
    required AgencyInfoStateData data,
  }) = _Loading;

  const factory AgencyInfoState.loaded({
    required AgencyInfoStateData data,
  }) = _Loaded;

  const factory AgencyInfoState.empty({
    required AgencyInfoStateData data,
  }) = _Empty;

  const factory AgencyInfoState.failure({
    required AgencyInfoStateData data,
  }) = _Failure;

  const factory AgencyInfoState.connectionError({
    required AgencyInfoStateData data,
  }) = _ConnectionError;
}

extension AgencyInfoStateX on AgencyInfoState {
  AgencyInfoStateData get data {
    return when(
      idle: (data) => data,
      loading: (data) => data,
      loaded: (data) => data,
      empty: (data) => data,
      failure: (data) => data,
      connectionError: (data) => data,
    );
  }
}
