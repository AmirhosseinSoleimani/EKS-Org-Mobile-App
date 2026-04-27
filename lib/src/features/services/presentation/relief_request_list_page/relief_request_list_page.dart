import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/widgets/filters_box.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_list_viewer.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/main_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/relief_request_list_cubit.dart';

class ReliefRequestListPage extends StatelessWidget {
  static const path = "/relief-request-page";
  static const name = "relief-request-services";

  const ReliefRequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReliefRequestListCubit>()..fetchRequestList(),
      child: const _SelectedServicesView(),
    );
  }
}

class _SelectedServicesView extends StatelessWidget {
  const _SelectedServicesView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReliefRequestListCubit>();
    return BlocListener<ReliefRequestListCubit, ReliefRequestListState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: cubit.fetchRequestList,
            );
          },
          loadingMoreError: (items, totalCount, message) {
            SnakeBarWidget.showError(context: context, message: message);
          },
          connectionError: () {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(
                onRetry: cubit.fetchRequestList,
              ),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: Scaffold(
        appBar: const MainAppBar(title: "درخواست های امدادی"),
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
                padding: const EdgeInsets.all(16),
                child: FiltersBox(cubit: cubit),
              ),
              Expanded(
                child:
                    BlocBuilder<ReliefRequestListCubit, ReliefRequestListState>(
                  buildWhen: (previous, current) {
                    return current.maybeWhen(
                      loadingMoreError: (items, totalCount, message) => false,
                      connectionError: () => false,
                      error: (message) => false,
                      orElse: () => true,
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      idle: () => const SizedBox.shrink(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: (items, totalCount, hasMore) => RequestListViewer(
                        items: cubit.items,
                        onSelected: cubit.cacheSelectedRequest,
                        onLoadMore: cubit.loadMore,
                        hasMore: cubit.hasMore,
                        totalCount: cubit.requestCount,
                      ),
                      loadingMore: (items, totalCount) => RequestListViewer(
                        items: cubit.items,
                        onSelected: cubit.cacheSelectedRequest,
                        onLoadMore: cubit.loadMore,
                        hasMore: cubit.hasMore,
                        totalCount: cubit.requestCount,
                      ),
                      orElse: () {
                        if (cubit.items.isNotEmpty) {
                          return RequestListViewer(
                            items: cubit.items,
                            onSelected: cubit.cacheSelectedRequest,
                            onLoadMore: cubit.loadMore,
                            hasMore: false,
                            totalCount: cubit.requestCount,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
