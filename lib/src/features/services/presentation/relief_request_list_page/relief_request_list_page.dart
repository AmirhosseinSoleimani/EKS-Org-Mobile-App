import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/widgets/filters_box.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_list_viewer.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/refresh_widgets/swipe_refresh_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/relief_request_list_cubit.dart';

class ReliefRequestListPage extends StatelessWidget {
  static const path = '/relief-request-page';
  static const name = 'relief-request-services';

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
              onPositive: () {
                context.pop();
                cubit.fetchRequestList();
              },
            );
          },
          loadingMoreError: (message) {
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
        appBar: const SimpleAppBar(title: 'درخواست های امدادی'),
        body: BlocBuilder<ReliefRequestListCubit, ReliefRequestListState>(
          buildWhen: (previous, current) {
            return current.maybeWhen(
              loadingMoreError: (message) => false,
              orElse: () => true,
            );
          },
          builder: (context, state) {
            if (cubit.operationAccess != null && !cubit.canViewRequests) {
              return const _AccessDeniedBody();
            }

            return ScrollConfiguration(
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
                    child: state.maybeWhen(
                      idle: () => const SizedBox.shrink(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      loaded: () => _buildList(cubit),
                      loadingMore: () => _buildList(cubit),
                      error: (message) => _EmptyRequestListBody(
                        onRefresh: cubit.fetchRequestList,
                      ),
                      connectionError: () => _EmptyRequestListBody(
                        onRefresh: cubit.fetchRequestList,
                      ),
                      orElse: () => _buildList(cubit, hasMore: false),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildList(
    ReliefRequestListCubit cubit, {
    bool? hasMore,
  }) {
    final operationAccess = cubit.operationAccess;
    if (operationAccess == null) return const SizedBox.shrink();

    return RequestListViewer(
      items: cubit.items,
      onSelected: cubit.cacheSelectedRequest,
      onLoadMore: cubit.loadMore,
      hasMore: hasMore ?? cubit.hasMore,
      totalCount: cubit.requestCount,
      operationAccess: operationAccess,
      onRefreshAfterReturn: cubit.fetchRequestList,
    );
  }
}

class _EmptyRequestListBody extends StatelessWidget {
  const _EmptyRequestListBody({required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return SwipeRefreshContainer(
      onRefresh: onRefresh,
      child: const Center(child: EmptyListWidget()),
    );
  }
}

class _AccessDeniedBody extends StatelessWidget {
  const _AccessDeniedBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'شما دسترسی لازم برای مشاهده درخواست های امدادی را ندارید.',
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
