import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/enums/request_type.dart';
import 'package:eks_sana_plus_org/src/features/requests/domain/entities/request_entity.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/cubit/request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/shimmer/request_list_shimmer_widget.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/request_item.dart';
import 'package:eks_sana_plus_org/src/features/requests/presentation/request_list/widgets/tab_bar_widget.dart';
import 'package:eks_sana_plus_org/src/routes/app_routing.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/app_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/request_list_state.dart';

class RequestListPage extends StatelessWidget {
  static const name = 'request-list-name';
  static const path = '/request-list-page';

  const RequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RequestListCubit>()..init(),
      child: const Scaffold(
        appBar: AppBarWidget(
          title: 'تاریخچه درخواست ها',
        ),
        body: RequestListViewWrapper(),
      ),
    );
  }
}

class RequestListViewWrapper extends StatefulWidget {
  const RequestListViewWrapper({super.key});

  @override
  State<RequestListViewWrapper> createState() => _RequestListViewWrapperState();
}

class _RequestListViewWrapperState extends State<RequestListViewWrapper>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<RequestListCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return const _RequestListView();
  }
}

class _RequestListView extends StatelessWidget {
  const _RequestListView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestListCubit, RequestListState>(
      listenWhen: (previous, current) => current.maybeWhen(
        error: (_) => true,
        notice: (_) => true,
        fetchRequestListLoading: () => true,
        fetchRequestListSuccess: () => true,
        connectionError: () => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.whenOrNull(
          error: (bottomSheetMessage) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: bottomSheetMessage,
              onPositive: context.read<RequestListCubit>().init,
            );
          },
          notice: (message) {
            SnakeBarWidget.showSuccess(
              context: context,
              message: message,
            );
          },
          connectionError: () {
            final cubit = context.read<RequestListCubit>();
            BottomSheetMessage.showCustom(
                context: context,
                content: NoInternetBottomSheet(
                    onRetry: cubit.init),
                actionWidget: const SizedBox.shrink(), isDismissible: false,enableDrag: false);
          },
        );
      },
      child: BlocBuilder<RequestListCubit, RequestListState>(
        buildWhen: (previous, current) => current.maybeWhen(
          fetchRequestListLoading: () => true,
          fetchRequestListSuccess: () => true,
          idle: () => true,
          orElse: () => false,
        ),
        builder: (context, state) {
          return state.maybeWhen(
            fetchRequestListLoading: () => const TabsWithShimmer(),
            idle: () => const TabsWithShimmer(),
            orElse: () => const _TabsContent(),
          );
        },
      ),
    );
  }

}


class _TabsContent extends StatelessWidget {
  const _TabsContent();

  final tabs = const ['خدمات امدادی', 'خدمت در محل'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestListCubit, RequestListState>(
      buildWhen: (previous, current) => current.maybeWhen(
        tabSelected: (_) => true,
        orElse: () => false,
      ),
      builder: (context, state) {

        var selectedTab = RequestType.reliefService;

        state.whenOrNull(
          tabSelected: (tab) => selectedTab = tab,
        );

        return Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              TabBarWidget(tabs: tabs, selectedTab: selectedTab),
              Space.h16,
              Expanded(child: _TabView(selectedTab: selectedTab)),
            ],
          ),
        );
      },
    );
  }
}


class _TabView extends StatelessWidget {
  final RequestType selectedTab;

  const _TabView({required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RequestListCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    final List<RequestEntity> activeItems;
    final List<RequestEntity> pastItems;
    late final Color themeColor;
    switch (selectedTab) {
      case RequestType.reliefService:
        activeItems = cubit.reliefActiveRequests;
        pastItems = cubit.reliefHistoryRequests;
        themeColor = colorScheme.primary;
      case RequestType.homeService:
        activeItems = cubit.homeServiceActiveRequests;
        pastItems = cubit.homeServiceHistoryRequests;
        themeColor = colorScheme.secondary;
    }

    return _RequestListWidget(
      activeItems: activeItems,
      pastItems: pastItems,
      itemThemeColor: themeColor,
    );
  }
}

class _RequestListWidget extends StatelessWidget {
  final List<RequestEntity> activeItems;
  final List<RequestEntity> pastItems;
  final Color itemThemeColor;

  const _RequestListWidget({
    required this.activeItems,
    required this.pastItems,
    required this.itemThemeColor,
  });

  @override
  Widget build(BuildContext context) {
    if (activeItems.isEmpty && pastItems.isEmpty) {
      return const _EmptyList();
    }


    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        if (activeItems.isNotEmpty) ...[
          const TitleLargeText(text: 'درخواست های فعال',fontSize: 16,),
          Space.h12,
          ...activeItems
              .map((e) => RequestItem(item: e, themeColor: itemThemeColor)),
          Space.h20,
        ],
        if (pastItems.isNotEmpty) ...[
          const  TitleLargeText(text: 'درخواست‌های قبلی', fontSize: 16,),
          Space.h12,
          ...pastItems
              .map((e) => RequestItem(item: e, themeColor: itemThemeColor)),
        ],
      ],
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SvgWidget(
          src: SvgAsset(SvgManager.emptyList),
        ),
        Space.h16,
        TitleLargeText(
          text: 'هیچ موردی جهت نمایش وجود ندارد',
          color: Theme.of(context).colorScheme.onPrimaryFixed,
          fontSize: AppSize.s16,
        )
      ],
    );
  }
}
