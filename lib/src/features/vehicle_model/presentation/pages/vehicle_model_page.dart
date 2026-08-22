import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_state.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/pages/vehicle_model_form_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/pages/vehicle_model_services_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_card.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';

import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VehicleModelPage extends StatelessWidget {
  static const path = '/vehicle-model-page';
  static const name = 'vehicle-model-page';

  const VehicleModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VehicleModelCubit>()..init(),
      child: const _VehicleModelView(),
    );
  }
}

class _VehicleModelView extends StatefulWidget {
  const _VehicleModelView();

  @override
  State<_VehicleModelView> createState() => _VehicleModelViewState();
}

class _VehicleModelViewState extends State<_VehicleModelView> {
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
    final cubit = context.read<VehicleModelCubit>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<VehicleModelCubit, VehicleModelState>(
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
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: const SimpleAppBar(title: 'نوع خودرو'),
            floatingActionButton: FloatingActionButtonWidget(
              title: 'نوع خودرو جدید',
              onPressed: () => _openCreateForm(context, cubit),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VehicleModelFiltersRow(cubit: cubit, state: state),
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
                      child: _VehicleModelList(
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
    VehicleModelCubit cubit,
  ) async {
    final changed = await context.pushNamed(VehicleModelFormPage.name);
    if (changed != true || !context.mounted) return;

    await cubit.refreshCurrentList();
    if (!context.mounted) return;
    SnakeBarWidget.showSuccess(
      context: context,
      message: 'نوع خودرو ثبت شد.',
    );
  }

  void _openActions(BuildContext pageContext, VehicleModelEntity item) {
    final cubit = pageContext.read<VehicleModelCubit>();
    BottomSheetMessage.showCustom(
      context: pageContext,
      backgroundColor: Theme.of(pageContext).colorScheme.onPrimary,
      content: BlocBuilder<VehicleModelCubit, VehicleModelState>(
        bloc: cubit,
        builder: (sheetContext, state) {
          final isServicesLoading =
              state.isServicesActionLoading(item.id);
          return VehicleModelActionSheet(
            isDeleting: state.deletingId == item.id,
            isServicesLoading: isServicesLoading,
            onServices: () async {
              if (isServicesLoading) return;
              final groups =
                  await cubit.loadServiceGroupsForNavigation(item);
              if (groups == null ||
                  !pageContext.mounted ||
                  !sheetContext.mounted) {
                return;
              }

              Navigator.of(sheetContext).pop();
              final result = await pageContext.pushNamed(
                VehicleModelServicesPage.name,
                extra: VehicleModelServicesPageArgs(
                  item: item,
                  initialGroups: groups,
                ),
              );
              if (!pageContext.mounted ||
                  result != VehicleModelServicesResult.saved) {
                return;
              }
              SnakeBarWidget.showSuccess(
                context: pageContext,
                message: 'سرویس‌های نوع خودرو ثبت شد.',
              );
            },
            onEdit: () async {
              if (isServicesLoading) return;
              Navigator.of(sheetContext).pop();
              final changed = await pageContext.pushNamed(
                VehicleModelFormPage.name,
                extra: VehicleModelFormPageArgs(item: item),
              );
              if (changed != true || !pageContext.mounted) return;

              await cubit.refreshCurrentList();
              if (!pageContext.mounted) return;
              SnakeBarWidget.showSuccess(
                context: pageContext,
                message: 'نوع خودرو ویرایش شد.',
              );
            },
            onDelete: () {
              if (isServicesLoading) return;
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
    VehicleModelEntity item,
    VehicleModelCubit cubit,
  ) {
    var isSubmitting = false;
    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: StatefulBuilder(
        builder: (sheetContext, setState) {
          return DeleteConfirmSheet(
            title: 'حذف نوع خودرو',
            message:
                'آیا از حذف «${item.title ?? item.name ?? 'این مورد'}» مطمئن هستید؟',
            confirmTitle: 'حذف',
            isSubmitting: isSubmitting,
            onConfirm: () async {
              if (isSubmitting) return;
              setState(() => isSubmitting = true);
              final success = await cubit.deleteVehicleModel(item);
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

class _VehicleModelList extends StatelessWidget {
  const _VehicleModelList({
    required this.controller,
    required this.state,
    required this.onRetry,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onActions,
  });

  final ScrollController controller;
  final VehicleModelState state;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final ValueChanged<VehicleModelEntity> onActions;

  @override
  Widget build(BuildContext context) {
    if (state.isInitialLoading) {
      return const Center(child: LoadingWidget());
    }
    if (state.status == VehicleModelViewStatus.failure ||
        state.status == VehicleModelViewStatus.connectionError) {
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
              key: const PageStorageKey<String>('vehicle-model-list'),
              controller: controller,
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: AppPadding.p100),
              itemCount: records.length + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, __) => Space.h12,
              itemBuilder: (context, index) {
                if (index >= records.length) {
                  return const Center(child: LoadingWidget());
                }
                final item = records[index];
                return VehicleModelCard(
                  key: ValueKey(item.id ?? '${item.code}-$index'),
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
