import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_state.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VehicleModelServicesPage extends StatelessWidget {
  static const path = '/vehicle-model-services-page';
  static const name = 'vehicle-model-services-page';

  const VehicleModelServicesPage({
    super.key,
    required this.item,
  });

  final VehicleModelEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VehicleModelCubit>()..prepareServices(item),
      child: _VehicleModelServicesView(item: item),
    );
  }
}

class _VehicleModelServicesView extends StatelessWidget {
  const _VehicleModelServicesView({required this.item});

  final VehicleModelEntity item;

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
            appBar: const SimpleActionBar(title: 'سرویس‌های نوع خودرو'),
            body: SafeArea(
              top: false,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: _ServicesBody(
                  state: state,
                  onRetry: () => cubit.fetchServiceGroups(item),
                  onToggle: cubit.toggleServiceCategory,
                  onDefects: (category) => _openDefects(context, category),
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: InkwellButtonWidget(
                  title: 'ثبت سرویس‌ها',
                  showLoading: state.isServicesSubmitting,
                  onTap: state.isServicesSubmitting
                      ? null
                      : () => cubit.submitServiceCategories(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openDefects(BuildContext context, EmdadServiceCategoryEntity category) async {
    final cubit = context.read<VehicleModelCubit>();
    final loaded = await cubit.loadDefects(category);
    if (!context.mounted || !loaded) return;
    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      maxHeight: MediaQuery.of(context).size.height * 0.8,
      content: BlocBuilder<VehicleModelCubit, VehicleModelState>(
        bloc: cubit,
        builder: (context, state) {
          return _DefectsSheet(
            state: state,
            onToggle: cubit.toggleDefect,
            onSubmit: () async {
              final success = await cubit.submitDefects();
              if (context.mounted && success) context.pop();
            },
          );
        },
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }
}

class _ServicesBody extends StatelessWidget {
  const _ServicesBody({
    required this.state,
    required this.onRetry,
    required this.onToggle,
    required this.onDefects,
  });

  final VehicleModelState state;
  final VoidCallback onRetry;
  final ValueChanged<EmdadServiceCategoryEntity> onToggle;
  final ValueChanged<EmdadServiceCategoryEntity> onDefects;

  @override
  Widget build(BuildContext context) {
    if (state.isServiceGroupsLoading) {
      return const Center(child: LoadingWidget());
    }
    if (state.serviceGroups.isEmpty) {
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
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p16,
        AppPadding.p100,
      ),
      children: [
        for (final group in state.serviceGroups) ...[
          TitleMediumText(
            text: group.serviceTypeTitle ?? '---',
            fontWeight: FontWeight.w800,
          ),
          Space.h8,
          for (final category in group.emdadCategories)
            Container(
              margin: const EdgeInsets.only(bottom: AppPadding.p8),
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppCheckboxWidget(
                      title: category.title ?? '---',
                      value: category.selected,
                      onChanged: (_) => onToggle(category),
                    ),
                  ),
                  IconButton(
                    onPressed: () => onDefects(category),
                    icon:  Icon(Icons.settings_outlined, color: Theme.of(context).primaryColor,),
                  ),
                ],
              ),
            ),
          Space.h16,
        ],
      ],
    );
  }
}

class _DefectsSheet extends StatelessWidget {
  const _DefectsSheet({
    required this.state,
    required this.onToggle,
    required this.onSubmit,
  });

  final VehicleModelState state;
  final ValueChanged<int?> onToggle;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleMediumText(
                text: state.selectedServiceCategory?.title ?? 'ایرادات سرویس',
                fontWeight: FontWeight.w800,
              ),
              Space.h16,
              if (state.defects.isEmpty)
                const Center(child: EmptyListWidget())
              else
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final defect in state.defects)
                        AppCheckboxWidget(
                          title: defect.title ?? '---',
                          value: defect.selected,
                          onChanged: (_) => onToggle(defect.id),
                        ),
                    ],
                  ),
                ),
              Space.h16,
              InkwellButtonWidget(
                title: 'ثبت ایرادات',
                showLoading: state.isDefectsSubmitting,
                onTap: state.isDefectsSubmitting ? null : () => onSubmit(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
