import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/cubit/cartable_cubit.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/widgets/active_cartable_user_info.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/cartable/presentation/cubit/cartable_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/active_cartable_user_section.dart';
import 'widgets/search_with_refresh_section.dart';

class CartablePage extends StatelessWidget {
  static const path = "/cartable-page";
  static const name = "cartable-page";

  const CartablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CartableCubit>()..init(),
      child: const CartablePageView(),
    );
  }
}

class CartablePageView extends StatefulWidget {
  const CartablePageView({super.key});

  @override
  State<CartablePageView> createState() => _CartablePageViewState();
}

class _CartablePageViewState extends State<CartablePageView> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _bottomSheetSearchController =
  TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _bottomSheetSearchController.dispose();
    super.dispose();
  }

  void _showChangeActiveUserBottomSheet(BuildContext context) {
    BottomSheetMessage.showCustom(
      context: context,
      content: SizedBox()/*SearchableTreeBottomSheetContent(
        searchController: _bottomSheetSearchController,
        hintText: 'جستجو در کاربران',
        onSearchChanged: (value) {

        },
        child: const SearchableTreeListPlaceholder(),
      ),*/
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartableCubit>();

    return BlocListener<CartableCubit, CartableState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: const MainAppBar(title: "کارتابل"),
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
                child: /*ActiveCartableUserSection(
                  onChangeCartableTap:() => _showChangeActiveUserBottomSheet(context),
                  activeUser: state.user,

                )*/SizedBox()
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SearchWithRefreshSection(
                  controller: _searchController,
                  hintText: 'جستجو در کارتابل',
                  onChanged: (value) {
                    // بعدا وصل میشه به سرچ آیتم‌های کارتابل
                  },
                  onRefreshTap: () {
                    _searchController.clear();

                    // بعدا:
                    // cubit.clearSearch();
                    // cubit.getCartableItems();
                  },
                ),
              ),

              const SizedBox(height: 12),

              /*const Expanded(
                child: ItemsPlaceholderList(
                  itemCount: 10,
                  itemHeight: 96,
                ),
              ),*/

            ],
          ),
        ),
      ),
    );
  }
}
