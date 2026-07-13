import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/Cartable_item_action_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/domain/entities/cartable_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/actions/cartable_action_codes.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/cubit/cartable_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/active_cartable_user_section.dart';
import 'widgets/cartable_items_section.dart';
import 'widgets/cartable_tree/cartable_selection_confirm_button.dart';
import 'widgets/cartable_tree/cartable_tree_selection_controller.dart';
import 'widgets/search_with_refresh_section.dart';
import 'widgets/searchable_tree_bottom_sheet_content.dart';

class CartablePage extends StatelessWidget {
  static const path = '/cartable-page';
  static const name = 'cartable-page';

  const CartablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartableCubit>(),
      child: const CartablePageView(),
    );
  }
}

class CartablePageView extends StatelessWidget {
  const CartablePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartableCubit>();
    final currentSessionManager = getIt<CurrentSessionManager>();

    return BlocConsumer<CartableCubit, CartableState>(
      listenWhen: (previous, current) {
        final wasUsersLoading =
            previous.data.isSubordinatedUsersLoading;

        final isUsersLoading =
            current.data.isSubordinatedUsersLoading;

        return wasUsersLoading && !isUsersLoading;
      },

      listener: (context, state) {
        state.whenOrNull(
          loaded: (data) {
            _showChangeActiveUserBottomSheet(context);
          },
          error: (data, message) {
            BottomSheetMessage.showError(
                context: context,
                data: message,
                onButtonTap: () {
                  context.pop();
                  cubit.retryLastAction();
                }
            );
          },
          connectionError: (data) {
            final cubit = context.read<CartableCubit>();

            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.getSubordinatedUsers,
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      builder: (context, state) {
        final data = state.data;

        return Scaffold(
          appBar: const MainAppBar(
            title: 'کارتابل',
          ),
          body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Space.h8,

                  StreamBuilder<CurrentSessionEntity?>(
                    stream: currentSessionManager.currentSessionStream,
                    initialData: currentSessionManager.currentSession,
                    builder: (context, sessionSnapshot) {
                      final currentSession = sessionSnapshot.data;
                      final selectedCartableUser = data.activeCartableUser;

                      final hasSelectedCartable =
                          selectedCartableUser != null;

                      final displayedName = hasSelectedCartable
                          ? selectedCartableUser.name
                          : currentSession?.displayName;

                      final displayedRoleTitle = hasSelectedCartable
                          ? data.activeCartableUserRoleTitle
                          : currentSession?.displayRoleName;

                      return ActiveCartableUserSection(
                        name: displayedName,
                        roleTitle: displayedRoleTitle,
                        isLoading: data.isSubordinatedUsersLoading,
                        onChangeCartableTap:
                        cubit.getSubordinatedUsers,
                      );
                    },
                  ),

                  Space.h24,

                  SearchWithRefreshSection(
                    controller: cubit.cartableSearchController,
                    hintText: 'جستجو در کارتابل',
                    onChanged: cubit.onCartableSearchChanged,
                    onRefreshTap: cubit.refreshCartableItems,
                  ),

                  Space.h24,

                  Expanded(
                    child: CartableItemsSection(
                      hasSelectedUser:
                      data.activeCartableUser != null,
                      isLoading:
                      data.isCartableItemsLoading,
                      items:
                      data.filteredCartableItems,
                      onActionTap: (item, action) =>
                          _handleCartableAction(
                            context: context,
                            item: item,
                            action: action,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleCartableAction({
    required BuildContext context,
    required CartableItemEntity item,
    required CartableItemActionEntity action,
  }) async {
    final actionType =
    CartableActionCodes.resolveType(
      action.code,
    );

    switch (actionType) {
      case CartableActionType.viewRequest:
        await _handleViewRequest(
          context: context,
          item: item,
          action: action,
        );
        break;

      case CartableActionType.delegateCartable:
        await _handleDelegateCartable(
          context: context,
          item: item,
          action: action,
        );
        break;

      case CartableActionType.archive:
        await _handleArchive(
          context: context,
          item: item,
          action: action,
        );
        break;

      case CartableActionType.insertReport:
        await _handleInsertReport(
          context: context,
          item: item,
          action: action,
        );
        break;

      case CartableActionType.invoiceObjectionConfirm:
      case CartableActionType.invoiceObjectionReject:
      case CartableActionType.createInvoice:
      case CartableActionType.cancelRequest:
      case CartableActionType.snooze:
      case CartableActionType.cartableCirculation:
      case CartableActionType.followUp:
      case CartableActionType.unknown:
        _showUnsupportedAction(
          context: context,
          action: action,
        );
        break;
    }
  }

  Future<void> _handleViewRequest({
    required BuildContext context,
    required CartableItemEntity item,
    required CartableItemActionEntity action,
  }) async {
    final serviceRequestId =
        item.serviceRequestId;

    if (serviceRequestId == null) {
      _showInvalidCartableItemMessage(context);
      return;
    }

    final cached = await context
        .read<CartableCubit>()
        .cacheSelectedRequestForDetails(item);

    if (!context.mounted) {
      return;
    }

    if (!cached) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'امکان آماده‌سازی اطلاعات درخواست وجود ندارد.',
          ),
        ),
      );

      return;
    }

    await context.push(
      RequestDetailPage.path,
      extra: serviceRequestId,
    );
  }

  Future<void> _handleDelegateCartable({
    required BuildContext context,
    required CartableItemEntity item,
    required CartableItemActionEntity action,
  }) async {
    final cartableItemId = item.id;

    if (cartableItemId == null) {
      _showInvalidCartableItemMessage(context);
      return;
    }

    // BottomSheet انتقال کارتابل اینجا باز می‌شود.
  }

  Future<void> _handleArchive({
    required BuildContext context,
    required CartableItemEntity item,
    required CartableItemActionEntity action,
  }) async {
    final cartableItemId = item.id;

    if (cartableItemId == null) {
      _showInvalidCartableItemMessage(context);
      return;
    }

    // بعد از ساخت UseCase آرشیو:
    // await context.read<CartableCubit>().archiveCartableItem(
    //   item: item,
    //   action: action,
    // );
  }

  Future<void> _handleInsertReport({
    required BuildContext context,
    required CartableItemEntity item,
    required CartableItemActionEntity action,
  }) async {
    final serviceRequestId =
        item.serviceRequestId;

    if (serviceRequestId == null) {
      _showInvalidCartableItemMessage(context);
      return;
    }

    // مسیر صفحه ثبت گزارش اینجا قرار می‌گیرد.
  }

  void _showUnsupportedAction({
    required BuildContext context,
    required CartableItemActionEntity action,
  }) {
    final title = action.title?.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title == null || title.isEmpty
              ? 'این عملیات هنوز پشتیبانی نمی‌شود.'
              : 'عملیات «$title» هنوز پیاده‌سازی نشده است.',
        ),
      ),
    );
  }

  void _showInvalidCartableItemMessage(
      BuildContext context,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'اطلاعات موردنیاز این آیتم کامل نیست.',
        ),
      ),
    );
  }


  Future<void> _showChangeActiveUserBottomSheet(
      BuildContext context,
      ) async {
    final cubit = context.read<CartableCubit>();
    final screenHeight = MediaQuery.sizeOf(context).height;

    final selectionController =
    CartableTreeSelectionController();

    final sheetHeight = screenHeight * 0.85;
    final contentHeight = (sheetHeight - 120)
        .clamp(300.0, sheetHeight)
        .toDouble();

    try {
      await BottomSheetMessage.showCustom(
        context: context,
        backgroundColor: Colors.white,
        maxHeight: 0.85,

        content: SizedBox(
          height: contentHeight,
          child: BlocProvider.value(
            value: cubit,
            child: BlocBuilder<CartableCubit, CartableState>(
              builder: (sheetContext, state) {
                return SearchableTreeBottomSheetContent(
                  searchController:
                  cubit.subordinatedUserSearchController,
                  hintText: 'جستجو در کاربران',
                  users:
                  state.data.filteredSubordinatedUsersTree,
                  onSearchChanged:
                  cubit.onSubordinatedUserSearchChanged,
                  selectionController: selectionController,
                );
              },
            ),
          ),
        ),

        actionWidget:
        ValueListenableBuilder<CartableTreeSelection?>(
          valueListenable:
          selectionController.selectedSelection,
          builder: (context, selection, _) {
            return CartableSelectionConfirmButton(
              enabled: selection != null,
              onPressed: () async {
                if (selection == null) {
                  return;
                }

                Navigator.of(context).pop();

                await cubit.selectActiveCartableUser(
                  selectedItem: selection.item,
                  selectedPath: selection.path,
                );
              },
            );
          },
        ),
      );
    } finally {
      selectionController.dispose();
    }
  }
}