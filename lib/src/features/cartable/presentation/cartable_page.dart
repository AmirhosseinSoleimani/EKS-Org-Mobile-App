import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/cubit/cartable_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/active_cartable_user_section.dart';
import 'widgets/search_with_refresh_section.dart';

class CartablePage extends StatelessWidget {
  static const path = '/cartable-page';
  static const name = 'cartable-page';

  const CartablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartableCubit>()..init(),
      child: const CartablePageView(),
    );
  }
}

class CartablePageView extends StatelessWidget {
  const CartablePageView({super.key});

  void _showChangeActiveUserBottomSheet(BuildContext context) {
    final cubit = context.read<CartableCubit>();

    BottomSheetMessage.showCustom(
      context: context,
      content: const SizedBox(),

      /*
      content: SearchableTreeBottomSheetContent(
        searchController: cubit.subordinatedUserSearchController,
        hintText: 'جستجو در کاربران',
        onSearchChanged: cubit.onSubordinatedUserSearchChanged,
        child: const SearchableTreeListPlaceholder(),
      ),
      */
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartableCubit>();

    return BlocConsumer<CartableCubit, CartableState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (data, message) {
            // BottomSheet خطا اینجا نمایش داده شود.
          },
          connectionError: (data) {
            // BottomSheet خطای اینترنت اینجا نمایش داده شود.
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: ActiveCartableUserSection(
                    activeUser: state.data.activeCartableUser,
                    activeUserRoleTitle: state.data.activeCartableUserRoleTitle,
                    onChangeCartableTap: () {
                      _showChangeActiveUserBottomSheet(context);
                    },
                  ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SearchWithRefreshSection(
                    controller: cubit.cartableSearchController,
                    hintText: 'جستجو در کارتابل',
                    onChanged: cubit.onCartableSearchChanged,
                    onRefreshTap: cubit.refreshCartableItems,
                  ),
                ),

                const SizedBox(height: 12),

                /*
                Expanded(
                  child: CartableItemsList(
                    items: data.filteredCartableItems,
                    isLoading: data.isCartableItemsLoading,
                  ),
                ),
                */
              ],
            ),
          ),
        );
      },
    );
  }
}