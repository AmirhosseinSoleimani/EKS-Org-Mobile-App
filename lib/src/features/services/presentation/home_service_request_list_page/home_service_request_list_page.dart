import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/request_list_viewer.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/policies/current_session_access_policy.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/presentation/widgets/current_session_access_builder.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_service_request_list_cubit.dart';
import 'widgets/filters_box.dart';

class HomeServiceRequestListPage extends StatelessWidget {
  static const path = '/home-service-page';
  static const name = 'home-service-page';

  const HomeServiceRequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CurrentSessionAccessBuilder(
      emptyBuilder: (_) => const _AccessDeniedView(),
      builder: (context, access) {
        if (!access.canViewHomeServiceRequest()) {
          return const _AccessDeniedView();
        }

        return BlocProvider(
          create: (_) => getIt<HomeServiceRequestListCubit>()..fetchRequestList(),
          child: _SelectedServicesView(access: access),
        );
      },
    );
  }
}

class _SelectedServicesView extends StatelessWidget {
  const _SelectedServicesView({required this.access});

  final CurrentSessionAccessPolicy access;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeServiceRequestListCubit>();
    return BlocListener<HomeServiceRequestListCubit, HomeServiceRequestListState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: cubit.fetchRequestList,
            );
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
        appBar: const SimpleAppBar(title: 'درخواست های خدمت در محل'),
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
                child: BlocBuilder<HomeServiceRequestListCubit,
                    HomeServiceRequestListState>(
                  buildWhen: (previous, current) {
                    return current.maybeWhen(
                      loadingMoreError: (message) => false,
                      connectionError: () => false,
                      error: (message) => false,
                      orElse: () => true,
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      idle: () => const SizedBox.shrink(),
                      loading: () => Center(
                        child: CircularProgressIndicator(
                          color: ServiceType.homeService.serviceColor,
                        ),
                      ),
                      loaded: () => _buildList(cubit),
                      loadingMore: () => _buildList(cubit),
                      orElse: () => _buildList(cubit, hasMore: false),
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

  Widget _buildList(
    HomeServiceRequestListCubit cubit, {
    bool? hasMore,
  }) {
    return RequestListViewer(
      items: cubit.requestList,
      onSelected: cubit.cacheSelectedRequest,
      onLoadMore: cubit.loadMore,
      hasMore: hasMore ?? cubit.hasMore,
      totalCount: cubit.requestCount,
      access: access,
      onRefreshAfterReturn: cubit.fetchRequestList,
    );
  }
}

class _AccessDeniedView extends StatelessWidget {
  const _AccessDeniedView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'درخواست های خدمت در محل'),
      body: Center(
        child: Text(
          'شما دسترسی لازم برای مشاهده درخواست های خدمت در محل را ندارید.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
