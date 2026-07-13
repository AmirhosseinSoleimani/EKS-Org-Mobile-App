import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/Cartable_item_action_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/cartable_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/delegate_cartable_message_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/delegate_cartable_message_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/param/get_subordinated_users_param_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/subordinated_user_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/use_cases/delegate_cartable_message_use_case.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/use_cases/get_cartable_item_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/use_cases/get_subordinated_users_list_use_case.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/usecases/set_selected_request_item_use_case.dart';
import 'package:eks_sana_plus_org/src/services/network/network_state/result/api_result.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'cartable_cubit.freezed.dart';
part 'cartable_state.dart';

enum SubordinatedUsersLoadingType {
  changeCartable,
  delegateMessage,
}

@injectable
class CartableCubit extends Cubit<CartableState> {
  CartableCubit(
      this._getSubordinatedUsersUseCase,
      this._getCartableItemListUseCase,
      this._delegateCartableMessageUseCase,
      this._setSelectedRequestItemUseCase,
      ) : super(const CartableState.idle());

  final GetSubordinatedUsersUseCase _getSubordinatedUsersUseCase;
  final GetCartableItemListUseCase _getCartableItemListUseCase;
  final DelegateCartableMessageUseCase _delegateCartableMessageUseCase;
  final SetSelectedRequestItemUseCase _setSelectedRequestItemUseCase;

  final TextEditingController cartableSearchController =
  TextEditingController();

  final TextEditingController subordinatedUserSearchController =
  TextEditingController();

  VoidCallback? _retryAction;
  String? _delegatingMessageGuid;
  bool _isDelegateSubmitting = false;

  String? get delegatingMessageGuid => _delegatingMessageGuid;

  bool get isDelegateSubmitting => _isDelegateSubmitting;

  bool get hasRetryAction => _retryAction != null;

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

  Future<bool> cacheSelectedRequestForDetails(
      CartableItemEntity item,
      ) async {
    final request = _buildSelectedRequest(item);

    if (request == null) {
      return false;
    }

    try {
      await _setSelectedRequestItemUseCase(request);

      return true;
    } catch (error) {
      debugPrint(
        'cacheSelectedRequestForDetails ERROR → $error',
      );

      return false;
    }
  }

  BaseRequestEntity? _buildSelectedRequest(
      CartableItemEntity item,
      ) {
    final requestId = item.serviceRequestId;

    if (requestId == null) {
      return null;
    }
    ServiceType type = ServiceType.fromValue(item.serviceType);
    switch (type) {
      case ServiceType.reliefService:
        return ReliefRequestEntity(
          id: requestId,
          serviceType: ServiceType.reliefService,
          trackCode: item.serviceRequestTrackCode,
          requestStatus: item.status,
          requestStatusTitle: item.statusTitle,
          requestDateJalali: item.sendDateJalali,
          requestTime: item.sendTime,
          requestDateTime: item.sendDateTime,
          customerMobileNumber: item.relatedTelNo,
          description: item.description,
        );

      case ServiceType.homeService:
        return HomeServiceRequestEntity(
          id: requestId,
          serviceType: ServiceType.homeService,
          trackCode: item.serviceRequestTrackCode,
          requestStatus: item.status,
          requestStatusTitle: item.statusTitle,
          requestDateJalali: item.sendDateJalali,
          requestTime: item.sendTime,
          requestDateTime: item.sendDateTime,
          customerMobileNumber: item.relatedTelNo,
          description: item.description,
        );
    }
  }

  Future<bool> getSubordinatedUsers({
    SubordinatedUsersLoadingType loadingType =
        SubordinatedUsersLoadingType.changeCartable,
  }) async {
    final isAnyUsersLoading =
        _data.isChangeCartableUsersLoading ||
            _data.isDelegateUsersLoading;

    if (isAnyUsersLoading) {
      return false;
    }

    _retryAction = () {
      getSubordinatedUsers(
        loadingType: loadingType,
      );
    };

    subordinatedUserSearchController.clear();

    emit(
      CartableState.loading(
        data: _setSubordinatedUsersLoading(
          data: _data,
          loadingType: loadingType,
          isLoading: true,
        ),
      ),
    );

    var isSuccessful = false;

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

      result.whenOrNull(
        success: (items, failures, resultCode) {
          isSuccessful = true;

          final tree = items;
          final root = _findRootNode(tree);

          final updatedData = _setSubordinatedUsersLoading(
            data: _data.copyWith(
              subordinatedUsersRoot: root,
              subordinatedUsersTree: tree,
              filteredSubordinatedUsersTree: tree,
              subordinatedUserSearchText: '',
            ),
            loadingType: loadingType,
            isLoading: false,
          );

          emit(
            CartableState.loaded(
              data: updatedData,
            ),
          );
        },
        failure: (error, failures) {
          final updatedData = _setSubordinatedUsersLoading(
            data: _data,
            loadingType: loadingType,
            isLoading: false,
          );

          emit(
            CartableState.error(
              data: updatedData,
              message: _buildErrorMessage(
                title: 'خطا در دریافت کاربران',
                message:
                failures ??
                    error?.toString() ??
                    'دریافت لیست کاربران با خطا مواجه شد.',
              ),
            ),
          );
        },
        connectionError: () {
          final updatedData = _setSubordinatedUsersLoading(
            data: _data,
            loadingType: loadingType,
            isLoading: false,
          );

          emit(
            CartableState.connectionError(
              data: updatedData,
            ),
          );
        },
      );
    } catch (error) {
      final updatedData = _setSubordinatedUsersLoading(
        data: _data,
        loadingType: loadingType,
        isLoading: false,
      );

      emit(
        CartableState.error(
          data: updatedData,
          message: _buildErrorMessage(
            title: 'خطا در دریافت کاربران',
            message:
            'دریافت لیست کاربران زیرمجموعه با خطا مواجه شد.',
          ),
        ),
      );
    }

    return isSuccessful;
  }

  CartableStateData _setSubordinatedUsersLoading({
    required CartableStateData data,
    required SubordinatedUsersLoadingType loadingType,
    required bool isLoading,
  }) {
    switch (loadingType) {
      case SubordinatedUsersLoadingType.changeCartable:
        return data.copyWith(
          isChangeCartableUsersLoading: isLoading,
        );

      case SubordinatedUsersLoadingType.delegateMessage:
        return data.copyWith(
          isDelegateUsersLoading: isLoading,
        );
    }
  }
/*
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
  }*/

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

  Future<bool> prepareDelegateUsers(String messageGuid,) async {
    final normalizedGuid = messageGuid.trim();

    if (normalizedGuid.isEmpty ||
        _delegatingMessageGuid != null) {
      return false;
    }

    _delegatingMessageGuid = normalizedGuid;

    emit(
      CartableState.loading(
        data: _data,
      ),
    );

    final loaded = await getSubordinatedUsers(
      loadingType:
      SubordinatedUsersLoadingType.delegateMessage,
    );

    _delegatingMessageGuid = null;

    emit(
      CartableState.loaded(
        data: _data,
      ),
    );

    return loaded;
  }

  Future<DelegateCartableMessageResponseEntity?> delegateCartableMessage({
    required String messageGuid,
    required String targetUserGuid,
  }) async {
    if (_isDelegateSubmitting) {
      return null;
    }

    _retryAction = null;
    _isDelegateSubmitting = true;
    emit(CartableState.loading(data: _data));

    DelegateCartableMessageResponseEntity? response;

    try {
      final result = await _delegateCartableMessageUseCase(
        DelegateCartableMessageParamEntity(
          messageGuid: messageGuid,
          targetUserGuid: targetUserGuid,
        ),
      );

      result.whenOrNull(
        success: (data, failures, resultCode) {
          response = data;
        },
        failure: (error, failures) {
          _isDelegateSubmitting = false;
          emit(
            CartableState.error(
              data: _data,
              message: _buildErrorMessage(
                title: 'خطا در انتقال پیام',
                message: failures ??
                    error?.toString() ??
                    'انتقال پیام به کارتابل کاربر انتخاب‌شده انجام نشد.',
              ),
            ),
          );
        },
        connectionError: () {
          _isDelegateSubmitting = false;
          emit(CartableState.connectionError(data: _data));
        },
      );

      if (response == null) {
        return null;
      }

      _isDelegateSubmitting = false;
      await getCartableItemsByActiveUser();
      return response;
    } catch (_) {
      _isDelegateSubmitting = false;
      emit(
        CartableState.error(
          data: _data,
          message: _buildErrorMessage(
            title: 'خطا در انتقال پیام',
            message: 'انتقال پیام به کارتابل کاربر انتخاب‌شده انجام نشد.',
          ),
        ),
      );
      return null;
    }
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

  Future<void> getCartableItemsByActiveUser() async {
    final userGuid = _data.activeCartableUser?.guid?.trim();

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
      // شبیه‌سازی زمان پاسخ سرور
      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );

      final items = _buildFakeCartableItems();

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
    } catch (error) {
      emit(
        CartableState.error(
          data: _data.copyWith(
            isCartableItemsLoading: false,
          ),
          message: _buildErrorMessage(
            title: 'خطا در دریافت کارتابل',
            message: 'ساخت اطلاعات آزمایشی کارتابل با خطا مواجه شد.',
          ),
        ),
      );
    }
  }


  List<CartableItemEntity> _buildFakeCartableItems() {
    return [
      _buildFakeInvoiceItem(
        id: 4377165,
        serviceRequestId: 30465,
        guid: '4f034951-2346-42bc-ad86-b9ac8e7ccf69',
        cycleId: '2eb365de-1cb5-42c9-9cd3-b8acfda6bad9',
        relatedTelNo: '+989132870765',
        serviceRequestTrackCode: 88078,
        sendDateTime: '2026-06-20T17:27:17',
        sendDateJalali: '1405/03/30',
        sendTime: '17:27:17',
      ),
      _buildFakeInvoiceItem(
        id: 4377159,
        serviceRequestId: 30460,
        guid: 'dad21615-c702-4650-b1da-bf050289c987',
        cycleId: 'd08404e0-3749-4cc5-9c07-0dd764221e03',
        relatedTelNo: '+989128730308',
        serviceRequestTrackCode: 88073,
        sendDateTime: '2026-06-20T15:13:54',
        sendDateJalali: '1405/03/30',
        sendTime: '15:13:54',
      ),
      _buildFakeInvoiceItem(
        id: 4377138,
        serviceRequestId: 30414,
        guid: '1252c412-b36b-4c98-99be-e1bff906c61c',
        cycleId: 'ac56e04f-862f-4b04-a5d4-0fbd8ba5c18c',
        relatedTelNo: '+989125376054',
        serviceRequestTrackCode: 88027,
        sendDateTime: '2026-06-14T10:58:52',
        sendDateJalali: '1405/03/24',
        sendTime: '10:58:52',
      ),
      _buildFakeInvoiceItem(
        id: 4377105,
        serviceRequestId: 30373,
        guid: 'de0a7b00-7589-41f9-a805-fcf319d8f910',
        cycleId: 'f8e7181e-5d5b-4680-ae50-e2bc9a6eaffc',
        relatedTelNo: '+989128047190',
        serviceRequestTrackCode: 87986,
        sendDateTime: '2026-05-31T10:44:32',
        sendDateJalali: '1405/03/10',
        sendTime: '10:44:32',
      ),
      _buildFakeFollowUpItem(
        id: 4377100,
        serviceRequestId: 30368,
        guid: '4e3361f7-7e30-4a4d-ae56-62935ee91f85',
        cycleId: '2f846fd0-3bdd-44cc-a0fe-366f566e93b4',
        relatedTelNo: '+989033702757',
        serviceRequestTrackCode: 87981,
        subject:
        'پیگیری درخواست خدمات در محل به شماره 87981. امدادگر: بخشعلی شجاعی ثمرین',
        description:
        'پیگیری درخواست خدمات در محل به شماره 87981.\n'
            'امدادخواه: زهرا سعید کریمی,\n'
            'تلفن همراه: 09033702757,',
        sendDateTime: '2026-05-30T16:28:00',
        sendDateJalali: '1405/03/09',
        sendTime: '16:28:00',
      ),
      _buildFakeInvoiceItem(
        id: 4376585,
        serviceRequestId: 19885,
        guid: '667c8a77-727f-43f5-bdef-816a324aea61',
        cycleId: '413c45cd-0ff2-49e0-8eaf-0407b1eff838',
        relatedTelNo: '+989381909505',
        serviceRequestTrackCode: 67798,
        sendDateTime: '2026-02-24T10:49:27',
        sendDateJalali: '1404/12/05',
        sendTime: '10:49:27',
      ),
      _buildFakeInvoiceItem(
        id: 4177481,
        serviceRequestId: 19852,
        guid: 'fc42fa18-20c8-4d33-8455-e733b4dc918b',
        cycleId: '2b4e907f-bd2e-4d3c-82d5-d7ea437d8b88',
        relatedTelNo: '+989154065695',
        serviceRequestTrackCode: 67765,
        sendDateTime: '2025-06-30T15:16:15',
        sendDateJalali: '1404/04/09',
        sendTime: '15:16:15',
      ),
      _buildFakeFollowUpItem(
        id: 4158917,
        serviceRequestId: 18998,
        guid: '2f160b7d-aa31-4c86-a33f-ed32916a0975',
        cycleId: 'd39ea717-72c4-4b93-ac9a-19c50a61d2e3',
        relatedTelNo: '+989336337607',
        serviceRequestTrackCode: 66911,
        subject:
        'پیگیری درخواست خدمات در محل به شماره 66911. امدادگر: مهدی رنجبری',
        description:
        'پیگیری درخواست خدمات در محل به شماره 66911.\n'
            'امدادخواه: حدیث نظری,\n'
            'تلفن همراه: 09336337607,',
        sendDateTime: '2025-06-27T15:20:00',
        sendDateJalali: '1404/04/06',
        sendTime: '15:20:00',
      ),
      _buildFakeFollowUpItem(
        id: 4143969,
        serviceRequestId: 17614,
        guid: 'b897867b-88a6-43a7-96d3-87e0ee8494b3',
        cycleId: '72180332-3ed3-4e26-a4c8-bc44a5143fb8',
        relatedTelNo: '+989194167971',
        serviceRequestTrackCode: 65527,
        subject:
        'پیگیری درخواست خدمات در محل به شماره 65527. امدادگر: ساسان حشمتی',
        description:
        'پیگیری درخواست خدمات در محل به شماره 65527.\n'
            'امدادخواه: محسن بوربور,\n'
            'تلفن همراه: 09194167971,',
        sendDateTime: '2025-06-24T15:20:00',
        sendDateJalali: '1404/04/03',
        sendTime: '15:20:00',
      ),
    ];
  }

  CartableItemEntity _buildFakeInvoiceItem({
    required int id,
    required int serviceRequestId,
    required String guid,
    required String cycleId,
    required String relatedTelNo,
    required int serviceRequestTrackCode,
    required String sendDateTime,
    required String sendDateJalali,
    required String sendTime,
  }) {
    return CartableItemEntity(
      id: id,
      serviceType: 2,
      serviceRequestId: serviceRequestId,
      guid: guid,
      isBeginningOfCycle: false,
      isEndingOfCycle: false,
      type: 2,
      flowId: 21,
      flowCode: 'SERVICE-REQUEST',
      cycleId: cycleId,
      subject: 'ثبت فاکتور',
      status: 41,
      statusTitle: 'در انتظار ثبت فاکتور',
      stepId: 41,
      stepTitle: 'ثبت فاکتور',
      relatedTelNo: relatedTelNo,
      relatedCallLogId: 0,
      serviceRequestTrackCode: serviceRequestTrackCode,
      senderType: 4,
      senderTypeName: 'Dispatcher',
      senderTypeTitle: 'اعزامگر',
      senderId: 48029857,
      senderUid: 'a67e2330-9465-4437-b988-14e963b5968f',
      senderFullName: 'سیستم سیستم',
      receiverType: 0,
      receiverTypeName: 'NotSpecified',
      receiverTypeTitle: 'تعیین نشده',
      receiverId: 47424481,
      receiverUid: 'ef537774-8ddb-4d85-9f68-b9b3fa8b6477',
      receiverFullName: 'عقیل خزائی',
      isActive: true,
      isDeleted: false,
      priority: 0,
      snoozeTimeElapsed: false,
      stepCode: 'SERVICE-REQUEST-CREATE-INVOICE',
      displayTime: '',
      displayColor: '',
      typeTitle: 'درخواست خدمات',
      sendDateTime: sendDateTime,
      sendDateJalali: sendDateJalali,
      sendTime: sendTime,
      lastUpdateTime: '17:44:30',
      dueTimeIsPassed: true,
      availableActions: _buildFakeInvoiceActions(),
    );
  }

  CartableItemEntity _buildFakeFollowUpItem({
    required int id,
    required int serviceRequestId,
    required String guid,
    required String cycleId,
    required String relatedTelNo,
    required int serviceRequestTrackCode,
    required String subject,
    required String description,
    required String sendDateTime,
    required String sendDateJalali,
    required String sendTime,
  }) {
    return CartableItemEntity(
      id: id,
      serviceType: 2,
      serviceRequestId: serviceRequestId,
      guid: guid,
      isBeginningOfCycle: false,
      isEndingOfCycle: false,
      type: 2,
      flowId: 21,
      flowCode: 'SERVICE-REQUEST',
      cycleId: cycleId,
      subject: subject,
      status: 23,
      statusTitle: 'در حال پیگیری',
      stepId: 23,
      stepTitle: 'پیگیری',
      relatedTelNo: relatedTelNo,
      relatedCallLogId: 0,
      serviceRequestTrackCode: serviceRequestTrackCode,
      senderType: 4,
      senderTypeName: 'Dispatcher',
      senderTypeTitle: 'اعزامگر',
      senderId: 48029857,
      senderUid: 'a67e2330-9465-4437-b988-14e963b5968f',
      senderFullName: 'سیستم سیستم',
      receiverType: 0,
      receiverTypeName: 'NotSpecified',
      receiverTypeTitle: 'تعیین نشده',
      receiverId: 47424481,
      receiverUid: 'ef537774-8ddb-4d85-9f68-b9b3fa8b6477',
      receiverFullName: 'عقیل خزائی',
      description: description,
      descriptionHtml:
      '<span inline-block dir-rtl>'
          '<span>آخرین وضعیت پیگیری:</span> '
          '<span dir-ltr class="cartable-desc-value-param">'
          '<b>در حال پیگیری</b>'
          '</span>'
          '</span>',
      isActive: true,
      isDeleted: false,
      priority: 0,
      snoozeTimeElapsed: false,
      stepCode: 'SERVICE-REQUEST-FOLLOW-UP',
      displayTime: '',
      displayColor: '',
      typeTitle: 'درخواست خدمات',
      sendDateTime: sendDateTime,
      sendDateJalali: sendDateJalali,
      sendTime: sendTime,
      lastUpdateTime: '17:44:30',
      dueTimeIsPassed: true,
      availableActions: _buildFakeFollowUpActions(),
    );
  }

  List<CartableItemActionEntity> _buildFakeCommonActions() {
    return [
      CartableItemActionEntity(
        guid: 'dbe19769-669f-4a5f-96ee-be4d78539a6f',
        title: 'انتقال کارتابل',
        code: 'ServiceRequest-DelegateCartable',
        buttonCssClass: 'btn btn-purple',
        iconCssClass: 'fa fa-share',
        orderNo: 1,
      ),
      CartableItemActionEntity(
        guid: 'abb1e284-fd3a-46af-b7dc-e4408783cd10',
        title: 'جزئیات درخواست',
        code: 'ServiceRequest-ViewRequest',
        buttonCssClass: 'btn btn-purple',
        iconCssClass: 'fa fa-search',
        orderNo: 1,
      ),
      CartableItemActionEntity(
        guid: 'dd8b1ee8-48f4-4e77-97b3-34877f96b2f1',
        title: 'چرخه کارتابل',
        code: 'cartable-circulation',
        buttonCssClass: 'btn btn-warning',
        iconCssClass: 'fa fa-retweet',
        orderNo: 103,
      ),
      CartableItemActionEntity(
        guid: '2be0413b-cb43-41e1-9aa6-19f0e8f09cfa',
        title: 'تعویق',
        code: 'ServiceRequest-Snooz',
        buttonCssClass: 'btn btn-success',
        iconCssClass: 'fa fa-clock',
        orderNo: 101,
      ),
    ];
  }
  List<CartableItemActionEntity> _buildFakeInvoiceActions() {
    return [
      ..._buildFakeCommonActions(),
      CartableItemActionEntity(
        guid: '2bf4414j-41e1-cb43-1as4-19f0e8f09cfa',
        title: 'ثبت فاکتور',
        code: 'ServiceRequest-CreateInvoice',
        buttonCssClass: 'btn btn-primary',
        iconCssClass: 'fa fa-file',
        orderNo: 102,
      ),
      CartableItemActionEntity(
        guid: '08b47027-5242-4da1-87c0-6b4035c92b08',
        title: 'لغو درخواست',
        code: 'ServiceRequest-Cancel',
        buttonCssClass: 'btn btn-danger',
        iconCssClass: 'fa fa-times',
        orderNo: 100,
      ),
    ]..sort(
          (first, second) =>
          (first.orderNo ?? 0).compareTo(second.orderNo ?? 0),
    );
  }

  List<CartableItemActionEntity> _buildFakeFollowUpActions() {
    return [
      ..._buildFakeCommonActions(),
      CartableItemActionEntity(
        guid: '87081787-69e1-42b4-b8a5-b5fbe073e7c9',
        title: 'پیگیری',
        code: 'ServiceRequest-FollowUp',
        buttonCssClass: 'btn btn-secondary',
        iconCssClass: 'fa fa-headphones-alt',
        orderNo: 1,
      ),
    ]..sort(
          (first, second) =>
          (first.orderNo ?? 0).compareTo(second.orderNo ?? 0),
    );
  }
}