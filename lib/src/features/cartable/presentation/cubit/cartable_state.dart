
part of 'cartable_cubit.dart';

@freezed
abstract class CartableStateData with _$CartableStateData {
  const factory CartableStateData({
    SubordinatedUserEntity? activeCartableUser,
    String? activeCartableUserRoleTitle,

    SubordinatedUserEntity? subordinatedUsersRoot,

    @Default([])
    List<SubordinatedUserEntity> subordinatedUsersTree,

    @Default([])
    List<SubordinatedUserEntity> filteredSubordinatedUsersTree,

    @Default([])
    List<CartableItemEntity> cartableItems,

    @Default([])
    List<CartableItemEntity> filteredCartableItems,

    @Default('') String cartableSearchText,
    @Default('') String subordinatedUserSearchText,

    @Default(false) bool isChangeCartableUsersLoading,
    @Default(false) bool isDelegateUsersLoading,

    @Default(false) bool isCartableItemsLoading,

    String? archivingMessageGuid,

    @Default(100) int pageSize,
    bool? includeSnoozedMessages,
  }) = _CartableStateData;
}

@freezed
abstract class CartableState with _$CartableState {
  const factory CartableState.idle({
    @Default(CartableStateData()) CartableStateData data,
  }) = _Initial;

  const factory CartableState.loading({
    required CartableStateData data,
  }) = _Loading;

  const factory CartableState.loaded({
    required CartableStateData data,
  }) = _Loaded;

  const factory CartableState.error({
    required CartableStateData data,
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory CartableState.loadingMore({
    required CartableStateData data,
  }) = _LoadingMore;

  const factory CartableState.connectionError({
    required CartableStateData data,
  }) = _ConnectionError;
}

extension CartableStateX on CartableState {
  CartableStateData get data {
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