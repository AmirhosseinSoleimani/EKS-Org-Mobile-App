import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/services/service_selection_page.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VehicleModelServicesPageArgs {
  const VehicleModelServicesPageArgs({
    required this.item,
    required this.initialGroups,
  });

  final VehicleModelEntity item;
  final List<VehicleServiceGroupEntity> initialGroups;
}

enum VehicleModelServicesResult { saved }

class VehicleModelServicesPage extends StatelessWidget {
  static const path = '/vehicle-model-services-page';
  static const name = 'vehicle-model-services-page';

  const VehicleModelServicesPage({
    super.key,
    required this.item,
    required this.initialGroups,
  });

  final VehicleModelEntity item;
  final List<VehicleServiceGroupEntity> initialGroups;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VehicleModelCubit>()
        ..initializeServices(item, initialGroups),
      child: const _VehicleModelServicesView(),
    );
  }
}

class _VehicleModelServicesView extends StatelessWidget {
  const _VehicleModelServicesView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VehicleModelCubit>();
    return BlocConsumer<VehicleModelCubit, VehicleModelState>(
      listener: (context, state) {
        final error = state.errorMessage;
        if (error?.trim().isNotEmpty == true) {
          SnakeBarWidget.showError(context: context, message: error!);
          cubit.clearErrorMessage();
        }
      },
      builder: (context, state) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
            },
          ),
          child: ServiceSelectionPage<
              VehicleServiceGroupEntity,
              EmdadServiceCategoryEntity>(
            title: 'سرویس‌های نوع خودرو',
            groups: state.serviceGroups,
            groupTitle: (group) => group.serviceTypeTitle ?? '---',
            groupItems: (group) => group.emdadCategories,
            itemTitle: (category) => category.title ?? '---',
            itemSelected: (category) => category.selected,
            itemSettingsLoading: (category) =>
                state.isDefectsLoading &&
                state.loadingDefectServiceCategoryId == category.id,
            isLoading: state.isServiceGroupsLoading,
            isSubmitting: state.isServicesSubmitting,
            submitTitle: 'ثبت سرویس‌ها',
            onItemToggle: cubit.toggleServiceCategory,
            onItemSettings: (category) {
              if (!category.selected || state.isDefectsLoading) return;
              _openDefects(context, category);
            },
            onCancel: () {
              if (state.isServicesSubmitting) return;
              context.pop();
            },
            onSubmit: () async {
              if (cubit.state.isServicesSubmitting) return;
              final success = await cubit.submitServiceCategories();
              if (!context.mounted || !success) return;
              context.pop(VehicleModelServicesResult.saved);
            },
          ),
        );
      },
    );
  }

  Future<void> _openDefects(
    BuildContext context,
    EmdadServiceCategoryEntity category,
  ) async {
    final cubit = context.read<VehicleModelCubit>();
    if (!category.selected || cubit.state.isDefectsLoading) return;

    final loaded = await cubit.loadDefects(category);
    if (!context.mounted || !loaded) return;

    final saved = await BottomSheetMessage.showFullScreenCustom<bool>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      content: BlocProvider.value(
        value: cubit,
        child: const _DefectsFullScreenSheet(),
      ),
    );

    if (!context.mounted || saved != true) return;
    SnakeBarWidget.showSuccess(
      context: context,
      message: 'ایرادات سرویس ثبت شد.',
    );
  }
}

class _DefectsFullScreenSheet extends StatelessWidget {
  const _DefectsFullScreenSheet();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VehicleModelCubit>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<VehicleModelCubit, VehicleModelState>(
        builder: (context, state) {
          return ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FullScreenBottomSheetAppBar(
                    title:
                        state.selectedServiceCategory?.title ?? 'ایرادات سرویس',
                    onClose: () {
                      if (state.isDefectsSubmitting) return;
                      Navigator.of(context).pop(false);
                    },
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.stylus,
                        },
                      ),
                      child: state.defects.isEmpty
                          ? const Center(child: EmptyListWidget())
                          : ListView.separated(
                              padding: const EdgeInsets.all(AppPadding.p16),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: state.defects.length,
                              separatorBuilder: (_, __) => Space.h8,
                              itemBuilder: (context, index) {
                                final defect = state.defects[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p12,
                                    vertical: AppPadding.p4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary,
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s8),
                                  ),
                                  child: AppCheckboxWidget(
                                    title: defect.title ?? '---',
                                    value: defect.selected,
                                    onChanged: (_) {
                                      if (state.isDefectsSubmitting) return;
                                      cubit.toggleDefect(defect.id);
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  StickyFormActionBar(
                    submitTitle: 'ثبت ایرادات',
                    cancelTitle: 'انصراف',
                    isSubmitting: state.isDefectsSubmitting,
                    onCancel: () {
                      if (state.isDefectsSubmitting) return;
                      Navigator.of(context).pop(false);
                    },
                    onSubmit: () async {
                      if (cubit.state.isDefectsSubmitting) return;
                      final success = await cubit.submitDefects();
                      if (!context.mounted || !success) return;
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
