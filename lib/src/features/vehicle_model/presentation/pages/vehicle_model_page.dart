import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_state.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/pages/vehicle_model_form_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/pages/vehicle_model_services_page.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_action_sheet.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_card.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/delete_confirm_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/floating_action_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
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

class _VehicleModelView extends StatelessWidget {
  const _VehicleModelView();

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
          }
          final success = state.successMessage;
          if (success?.trim().isNotEmpty == true) {
            SnakeBarWidget.showSuccess(context: context, message: success!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: const SimpleActionBar(title: 'نوع خودرو'),
            floatingActionButton: FloatingActionButtonWidget(
              title: 'نوع خودرو جدید',
              onPressed: () async {
                final changed = await context.pushNamed(VehicleModelFormPage.name);
                if (changed == true && context.mounted) {
                  context.read<VehicleModelCubit>().fetchList(reset: true);
                }
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilterButton(
                    title: 'فیلترها',
                    onTap: () => _openFilter(context, state),
                  ),
                  Space.h16,
                  Expanded(
                    child: _VehicleModelList(
                      state: state,
                      onRetry: () => cubit.fetchList(reset: true),
                      onLoadMore: () => cubit.fetchList(),
                      onActions: (item) => _openActions(context, item),
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

  void _openFilter(BuildContext context, VehicleModelState state) {
    final cubit = context.read<VehicleModelCubit>();
    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: VehicleModelFilterSheet(
        initialCode: state.codeFilter,
        initialName: state.nameFilter,
        initialIsActive: state.isActiveFilter,
        initialNavganTypeTitle: state.navganTypeTitleFilter,
        initialHasDepot: state.hasDepotFilter,
        onSubmit: (
          code,
          name,
          isActive,
          navganTypeTitle,
          hasDepot,
        ) =>
            cubit.applyFilter(
          code: code,
          name: name,
          isActive: isActive,
          navganTypeTitle: navganTypeTitle,
          hasDepot: hasDepot,
        ),
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  void _openActions(BuildContext context, VehicleModelEntity item) {
    final cubit = context.read<VehicleModelCubit>();
    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      content: BlocBuilder<VehicleModelCubit, VehicleModelState>(
        bloc: cubit,
        builder: (context, state) {
          return VehicleModelActionSheet(
            isDeleting: state.deletingId == item.id,
            onServices: () {
              context.pop();
              context.pushNamed(VehicleModelServicesPage.name, extra: item);
            },
            onEdit: () async {
              context.pop();
              final changed = await context.pushNamed(
                VehicleModelFormPage.name,
                extra: VehicleModelFormPageArgs(item: item),
              );
              if (changed == true && context.mounted) {
                context.read<VehicleModelCubit>().fetchList(reset: true);
              }
            },
            onDelete: () {
              context.pop();
              _confirmDelete(context, item, cubit);
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
        builder: (context, setState) {
          return DeleteConfirmSheet(
            title: 'حذف نوع خودرو',
            message: 'آیا از حذف «${item.title ?? item.name ?? 'این مورد'}» مطمئن هستید؟',
            confirmTitle: 'حذف',
            isSubmitting: isSubmitting,
            onConfirm: () async {
              setState(() => isSubmitting = true);
              final success = await cubit.deleteVehicleModel(item);
              if (context.mounted && success) context.pop();
              if (context.mounted && !success) {
                setState(() => isSubmitting = false);
              }
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
    required this.state,
    required this.onRetry,
    required this.onLoadMore,
    required this.onActions,
  });

  final VehicleModelState state;
  final VoidCallback onRetry;
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
    if (state.records.isEmpty) {
      return const Center(child: EmptyListWidget());
    }
    return RefreshIndicator(
      onRefresh: () async => onRetry(),
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
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: AppPadding.p100),
          itemCount: state.records.length + (state.isLoadingMore ? 1 : 0),
          separatorBuilder: (_, __) => Space.h12,
          itemBuilder: (context, index) {
            if (index >= state.records.length) {
              return const Center(child: LoadingWidget());
            }
            final item = state.records[index];
            return VehicleModelCard(
              item: item,
              isActionLoading: state.deletingId == item.id,
              onActions: () => onActions(item),
            );
          },
        ),
      ),
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
