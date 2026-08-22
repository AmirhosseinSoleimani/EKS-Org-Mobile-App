import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/domain/entities/deployment_location_entity.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/cubit/deployment_location_cubit.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/cubit/deployment_location_state.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/pages/deployment_location_form_page.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_card.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';

import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeploymentLocationPage extends StatelessWidget {
  static const path = '/deployment-location-page';
  static const name = 'deployment-location-page';

  const DeploymentLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DeploymentLocationCubit>()..initList(),
      child: const _DeploymentLocationView(),
    );
  }
}

class _DeploymentLocationView extends StatefulWidget {
  const _DeploymentLocationView();

  @override
  State<_DeploymentLocationView> createState() =>
      _DeploymentLocationViewState();
}

class _DeploymentLocationViewState extends State<_DeploymentLocationView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeploymentLocationCubit>();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<DeploymentLocationCubit, DeploymentLocationState>(
        listener: (context, state) {
          final error = state.errorMessage;
          if (error?.trim().isNotEmpty == true) {
            SnakeBarWidget.showError(context: context, message: error!);
            cubit.clearErrorMessage();
          }

          final success = state.successMessage;
          if (success?.trim().isNotEmpty == true) {
            SnakeBarWidget.showSuccess(context: context, message: success!);
            cubit.clearSuccessMessage();
          }
        },
        builder: (context, state) {
          final theme = Theme.of(context);
          final isReportBusy = state.isReportLoading;
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: const SimpleAppBar(title: 'محل استقرار'),
            floatingActionButton: FloatingActionButtonWidget(
              title: 'محل استقرار جدید',
              onPressed: () => _openCreateForm(context, cubit),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DeploymentLocationFiltersRow(cubit: cubit, state: state),
                  Space.h12,
                  ReportButtonWidget(
                    isLoading: isReportBusy,
                    onTap: () {
                      if (isReportBusy) return;
                      cubit.exportReport();
                    },
                  ),
                  Space.h16,
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.stylus,
                        },
                      ),
                      child: _DeploymentLocationList(
                        controller: _scrollController,
                        state: state,
                        onRetry: () => cubit.fetchList(reset: true),
                        onRefresh: cubit.refreshCurrentList,
                        onLoadMore: () => cubit.fetchList(),
                        onActions: (item) => _openActions(context, item),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openCreateForm(
    BuildContext context,
    DeploymentLocationCubit cubit,
  ) async {
    final changed = await context.pushNamed(DeploymentLocationFormPage.name);
    if (changed != true || !context.mounted) return;

    await cubit.refreshCurrentList();
    if (!context.mounted) return;
    SnakeBarWidget.showSuccess(
      context: context,
      message: 'محل استقرار ثبت شد.',
    );
  }

  void _openActions(
    BuildContext pageContext,
    DeploymentLocationEntity item,
  ) {
    final cubit = pageContext.read<DeploymentLocationCubit>();

    BottomSheetMessage.showCustom(
      context: pageContext,
      backgroundColor: Theme.of(pageContext).colorScheme.onPrimary,
      content: BlocBuilder<DeploymentLocationCubit, DeploymentLocationState>(
        bloc: cubit,
        builder: (sheetContext, state) {
          final isDeleting = state.deletingId == item.id;
          return DeploymentLocationActionSheet(
            isDeleting: isDeleting,
            onEdit: () async {
              if (isDeleting) return;
              Navigator.of(sheetContext).pop();

              final changed = await pageContext.pushNamed(
                DeploymentLocationFormPage.name,
                extra: DeploymentLocationFormPageArgs(id: item.id),
              );
              if (changed != true || !pageContext.mounted) return;

              await cubit.refreshCurrentList();
              if (!pageContext.mounted) return;
              SnakeBarWidget.showSuccess(
                context: pageContext,
                message: 'محل استقرار ویرایش شد.',
              );
            },
            onDelete: () {
              if (isDeleting) return;
              Navigator.of(sheetContext).pop();
              _confirmDelete(pageContext, item, cubit);
            },
          );
        },
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  void _confirmDelete(
    BuildContext context,
    DeploymentLocationEntity item,
    DeploymentLocationCubit cubit,
  ) {
    var isSubmitting = false;

    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: StatefulBuilder(
        builder: (sheetContext, setState) {
          return DeleteConfirmSheet(
            title: 'حذف محل استقرار',
            message:
                'آیا از حذف «${item.title ?? 'این محل استقرار'}» مطمئن هستید؟',
            confirmTitle: 'حذف',
            isSubmitting: isSubmitting,
            onConfirm: () async {
              if (isSubmitting) return;
              setState(() => isSubmitting = true);

              final success = await cubit.deleteLocation(item);
              if (!sheetContext.mounted) return;

              if (success) {
                Navigator.of(sheetContext).pop();
                return;
              }
              setState(() => isSubmitting = false);
            },
          );
        },
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }
}

class _DeploymentLocationList extends StatelessWidget {
  const _DeploymentLocationList({
    required this.controller,
    required this.state,
    required this.onRetry,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onActions,
  });

  final ScrollController controller;
  final DeploymentLocationState state;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final ValueChanged<DeploymentLocationEntity> onActions;

  @override
  Widget build(BuildContext context) {
    if (state.isInitialLoading) {
      return const Center(child: LoadingWidget());
    }

    if (state.status == DeploymentLocationViewStatus.failure ||
        state.status == DeploymentLocationViewStatus.connectionError) {
      return _ErrorView(onRetry: onRetry);
    }

    final records = state.visibleRecords;
    if (records.isEmpty) {
      return const Center(child: EmptyListWidget());
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: onRefresh,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent - AppSize.s80 &&
                  state.canLoadMore) {
                onLoadMore();
              }
              return false;
            },
            child: ListView.separated(
              key: const PageStorageKey<String>(
                'deployment-location-list',
              ),
              controller: controller,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: AppPadding.p100),
              itemCount: records.length + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, __) => Space.h12,
              itemBuilder: (context, index) {
                if (index >= records.length) {
                  return const Center(child: LoadingWidget());
                }

                final item = records[index];
                return DeploymentLocationCard(
                  key: ValueKey(item.id ?? '${item.title}-$index'),
                  item: item,
                  isActionLoading: state.deletingId == item.id,
                  onActions: () => onActions(item),
                );
              },
            ),
          ),
        ),
        if (state.isRefreshing)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(minHeight: 2),
          ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EmptyListWidget(),
          Space.h12,
          TextButton(
            onPressed: onRetry,
            child: const BodyMediumText(text: 'تلاش مجدد'),
          ),
        ],
      ),
    );
  }
}
