import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/cubit/cartable_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/manager/current_session_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/active_cartable_user_section.dart';
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
                      final selectedCartableUser =
                          data.activeCartableUser;

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
                        onChangeCartableTap: cubit.getSubordinatedUsers,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showChangeActiveUserBottomSheet(BuildContext context) {
    final cubit = context.read<CartableCubit>();
    final screenHeight = MediaQuery.sizeOf(context).height;

    BottomSheetMessage.showCustom(
      backgroundColor: Colors.white,
      context: context,
      content: SizedBox(
        height: screenHeight * 0.85,
        child: BlocProvider.value(
          value: cubit,
          child: BlocBuilder<CartableCubit, CartableState>(
            builder: (sheetContext, state) {
              return SearchableTreeBottomSheetContent(
                searchController:
                cubit.subordinatedUserSearchController,
                hintText: 'جستجو در کاربران',
                users: state.data.filteredSubordinatedUsersTree,
                onSearchChanged:
                cubit.onSubordinatedUserSearchChanged,

                onConfirm: (selectedItem, selectedPath) async {
                  Navigator.of(sheetContext).pop();

                  await cubit.selectActiveCartableUser(
                    selectedItem: selectedItem,
                    selectedPath: selectedPath,
                  );
                },
              );
            },
          ),
        ),
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }
}