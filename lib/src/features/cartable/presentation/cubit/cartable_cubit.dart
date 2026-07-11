import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/cartable_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_cartable_items_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_subordinated_users_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/use_cases/get_cartable_item_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/use_cases/get_subordinated_users_list_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cartable_cubit.freezed.dart';

part 'cartable_state.dart';

@injectable
class CartableCubit extends Cubit<CartableState> {
  CartableCubit(this._getSubordinatedUsersUseCase,
      this._getCartableItemListUseCase,) : super(const CartableState.idle());

  final GetSubordinatedUsersUseCase _getSubordinatedUsersUseCase;
  final GetCartableItemListUseCase _getCartableItemListUseCase;

  final TextEditingController cartableSearchController =
  TextEditingController();

  final TextEditingController subordinatedUserSearchController =
  TextEditingController();

  VoidCallback? _retryAction;

  void retryLastAction() => _retryAction?.call();

  CartableStateData get _data {
    return state.when(
      idle: (data) => data,
      loading: (data) => data,
      loaded: (data) => data,
      error: (data, message) => data,
      loadingMore: (data) => data,
      connectionError: (data) => data,
    );
  }

  Future<void> init() async {
    await getSubordinatedUsers();
  }

  Future<void> getSubordinatedUsers() async {
    _retryAction = getSubordinatedUsers;

    emit(
      CartableState.loading(
        data: _data.copyWith(
          isSubordinatedUsersLoading: true,
        ),
      ),
    );

    try {
      final result = await _getSubordinatedUsersUseCase(
        const GetSubordinatedUsersParamEntity(
          loadUsers: true,
          sameAndOneUpperLevelsCartableMessageId: null,
          includeCartableStats: true,
          includeUserAvailablilityStatus: true,
          includeWorkTimespanStatus: true,
        ),
      );

      SubordinatedUserEntity? selectedUser;

      result.whenOrNull(
        success: (items, failures, resultCode) {
          final tree = items;

          final root = _findRootNode(tree);

          final activeUser = _data.activeCartableUser ??
              _resolveInitialActiveCartableUser(
                root: root,
                tree: tree,
              );

          final activeUserRoleTitle = _resolveRoleTitleForUser(
            users: tree,
            user: activeUser,
          );

          selectedUser = activeUser;

          emit(
            CartableState.loaded(
              data: _data.copyWith(
                subordinatedUsersRoot: root,
                subordinatedUsersTree: tree,
                filteredSubordinatedUsersTree: tree,
                activeCartableUser: activeUser,
                activeCartableUserRoleTitle: activeUserRoleTitle,
                isSubordinatedUsersLoading: false,
              ),
            ),
          );
        },
        failure: (error, failures) {
          emit(
            CartableState.error(
              data: _data.copyWith(
                isSubordinatedUsersLoading: false,
              ),
              message: _buildErrorMessage(
                title: '',
                message: failures ?? error?.toString() ?? '',
              ),
            ),
          );
        },
        connectionError: () {
          emit(
            CartableState.connectionError(
              data: _data.copyWith(
                isSubordinatedUsersLoading: false,
              ),
            ),
          );
        },
      );

      final selectedUserGuid = selectedUser?.guid?.trim();

      if (selectedUserGuid != null && selectedUserGuid.isNotEmpty) {
        await getCartableItemsByActiveUser();
      }
    } catch (error) {
      emit(
        CartableState.error(
          data: _data.copyWith(
            isSubordinatedUsersLoading: false,
          ),
          message: _buildErrorMessage(
            title: 'خطا در دریافت کاربران',
            message: 'دریافت لیست کاربران زیرمجموعه با خطا مواجه شد.',
          ),
        ),
      );
    }
  }

  Future<void> getCartableItemsByActiveUser() async {
    final activeUser = _data.activeCartableUser;
    final userGuid = activeUser?.guid?.trim();

    if (userGuid == null || userGuid.isEmpty) {
      emit(
        CartableState.loaded(
          data: _data.copyWith(
            cartableItems: [],
            filteredCartableItems: [],
            isCartableItemsLoading: false,
          ),
        ),
      );
      return;
    }

    _retryAction = getCartableItemsByActiveUser;

    emit(
      CartableState.loading(
        data: _data.copyWith(
          isCartableItemsLoading: true,
        ),
      ),
    );

    try {
      final result = await _getCartableItemListUseCase(
        GetCartableItemParamEntity(
          userGuid: userGuid,
          includeSnoozedMessages: _data.includeSnoozedMessages ?? false,
          pageSize: _data.pageSize,
        ),
      );

      result.whenOrNull(
        success: (items, failures, resultCode) {
          final filteredItems = _filterCartableItems(
            items: items,
            query: _data.cartableSearchText,
          );

          emit(
            CartableState.loaded(
              data: _data.copyWith(
                cartableItems: items,
                filteredCartableItems: filteredItems,
                isCartableItemsLoading: false,
              ),
            ),
          );
        },
        failure: (error, failures) {
          emit(
            CartableState.error(
              data: _data.copyWith(
                isCartableItemsLoading: false,
              ),
              message: _buildErrorMessage(
                title: '',
                message: failures ?? error?.toString() ?? '',
              ),
            ),
          );
        },
        connectionError: () {
          emit(
            CartableState.connectionError(
              data: _data.copyWith(
                isCartableItemsLoading: false,
              ),
            ),
          );
        },
      );
    } catch (error) {
      emit(
        CartableState.error(
          data: _data.copyWith(
            isCartableItemsLoading: false,
          ),
          message: _buildErrorMessage(
            title: 'خطا در دریافت کارتابل',
            message: 'دریافت لیست آیتم‌های کارتابل با خطا مواجه شد.',
          ),
        ),
      );
    }
  }

  Future<void> refreshCartableItems() async {
    cartableSearchController.clear();

    emit(
      CartableState.loaded(
        data: _data.copyWith(
          cartableSearchText: '',
          filteredCartableItems: _data.cartableItems,
        ),
      ),
    );

    await getCartableItemsByActiveUser();
  }

  Future<void> selectActiveCartableUser({
    required SubordinatedUserEntity selectedItem,
    required List<SubordinatedUserEntity> selectedPath,
  }) async {
    final roleTitle = _resolveRoleTitleFromPath(selectedPath);

    cartableSearchController.clear();

    emit(
      CartableState.loaded(
        data: _data.copyWith(
          activeCartableUser: selectedItem,
          activeCartableUserRoleTitle: roleTitle,
          cartableSearchText: '',
          cartableItems: [],
          filteredCartableItems: [],
        ),
      ),
    );

    await getCartableItemsByActiveUser();
  }

  String? _resolveRoleTitleFromPath(
      List<SubordinatedUserEntity> path,
      ) {
    for (final item in path.reversed) {
      if (item.isUser == false) {
        final roleTitle = item.name?.trim();

        if (roleTitle != null && roleTitle.isNotEmpty) {
          return roleTitle;
        }
      }
    }

    return null;
  }

  void onCartableSearchChanged(String value) {
    final filteredItems = _filterCartableItems(
      items: _data.cartableItems,
      query: value,
    );

    emit(
      CartableState.loaded(
        data: _data.copyWith(
          cartableSearchText: value,
          filteredCartableItems: filteredItems,
        ),
      ),
    );
  }

  void clearCartableSearch() {
    cartableSearchController.clear();

    emit(
      CartableState.loaded(
        data: _data.copyWith(
          cartableSearchText: '',
          filteredCartableItems: _data.cartableItems,
        ),
      ),
    );
  }

  void onSubordinatedUserSearchChanged(String value) {
    final filteredUsers = _filterSubordinatedUsersTree(
      users: _data.subordinatedUsersTree,
      query: value,
    );

    emit(
      CartableState.loaded(
        data: _data.copyWith(
          subordinatedUserSearchText: value,
          filteredSubordinatedUsersTree: filteredUsers,
        ),
      ),
    );
  }

  void clearSubordinatedUserSearch() {
    subordinatedUserSearchController.clear();

    emit(
      CartableState.loaded(
        data: _data.copyWith(
          subordinatedUserSearchText: '',
          filteredSubordinatedUsersTree: _data.subordinatedUsersTree,
        ),
      ),
    );
  }

  List<CartableItemEntity> _filterCartableItems({
    required List<CartableItemEntity> items,
    required String query,
  }) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return items;
    }

    return items.where((item) {
      final searchableText = [
        item.subject,
        item.statusTitle,
        item.stepTitle,
        item.relatedTelNo,
        item.serviceRequestTrackCode?.toString(),
        item.senderFullName,
        item.receiverFullName,
        item.description,
        item.typeTitle,
        item.sendDateJalali,
        item.sendTime,
        item.lastUpdateTime,
      ].whereType<String>().join(' ').toLowerCase();

      return searchableText.contains(normalizedQuery);
    }).toList();
  }

  List<SubordinatedUserEntity> _filterSubordinatedUsersTree({
    required List<SubordinatedUserEntity> users,
    required String query,
  }) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return users;
    }

    final filteredUsers = <SubordinatedUserEntity>[];

    for (final user in users) {
      final filteredChildren = _filterSubordinatedUsersTree(
        users: user.subordinateds,
        query: normalizedQuery,
      );

      final userName = user.name ?? '';

      final isMatched = userName.toLowerCase().contains(normalizedQuery);

      if (isMatched || filteredChildren.isNotEmpty) {
        filteredUsers.add(
          user.copyWith(
            subordinateds: filteredChildren,
          ),
        );
      }
    }

    return filteredUsers;
  }

  SubordinatedUserEntity? _findRootNode(List<SubordinatedUserEntity> users,) {
    for (final user in users) {
      if (user.isRoot == true) {
        return user;
      }

      final result = _findRootNode(user.subordinateds);

      if (result != null) {
        return result;
      }
    }

    return users.isNotEmpty ? users.first : null;
  }

  SubordinatedUserEntity? _resolveInitialActiveCartableUser({
    required SubordinatedUserEntity? root,
    required List<SubordinatedUserEntity> tree,
  }) {
    final rootGuid = root?.guid?.trim();

    if (root?.isUser == true && rootGuid != null && rootGuid.isNotEmpty) {
      return root;
    }

    return _findFirstSelectableUser(users: tree);
  }

  SubordinatedUserEntity? _findFirstSelectableUser({
    required List<SubordinatedUserEntity> users,
  }) {
    for (final user in users) {
      final guid = user.guid?.trim();

      if (user.isUser == true && guid != null && guid.isNotEmpty) {
        return user;
      }

      final childResult = _findFirstSelectableUser(
        users: user.subordinateds,
      );

      if (childResult != null) {
        return childResult;
      }
    }

    return null;
  }

  String? _resolveRoleTitleForUser({
    required List<SubordinatedUserEntity> users,
    required SubordinatedUserEntity? user,
  }) {
    if (user == null) {
      return null;
    }

    if (user.isRole == true) {
      return user.name;
    }

    return _findNearestRoleTitleForUser(
      users: users,
      userGuid: user.guid,
    );
  }

  String? _findNearestRoleTitleForUser({
    required List<SubordinatedUserEntity> users,
    required String? userGuid,
    String? currentRoleTitle,
  }) {
    if (userGuid == null || userGuid
        .trim()
        .isEmpty) {
      return null;
    }

    for (final user in users) {
      final nextRoleTitle =
      user.isRole == true ? user.name : currentRoleTitle;

      if (user.guid == userGuid) {
        return nextRoleTitle;
      }

      final result = _findNearestRoleTitleForUser(
        users: user.subordinateds,
        userGuid: userGuid,
        currentRoleTitle: nextRoleTitle,
      );

      if (result != null) {
        return result;
      }
    }

    return null;
  }

  BottomSheetMessageModel _buildErrorMessage({
    required String title,
    required String message,
  }) {
    return BottomSheetMessageModel(
      title: title,
      message: message,
    );
  }

  @override
  Future<void> close() {
    cartableSearchController.dispose();
    subordinatedUserSearchController.dispose();
    return super.close();
  }
}