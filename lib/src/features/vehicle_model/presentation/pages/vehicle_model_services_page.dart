import 'dart:ui';

import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/vehicle_service_group_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_state.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_service_group_section.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_service_header_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/full_screen_bottom_sheet_app_bar.dart';

import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/sticky_form_action_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selected_items_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_select_all_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/search_input_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/refresh_widgets/swipe_refresh_container.dart';
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

class _VehicleModelServicesView extends StatefulWidget {
  const _VehicleModelServicesView();

  @override
  State<_VehicleModelServicesView> createState() =>
      _VehicleModelServicesViewState();
}

class _VehicleModelServicesViewState
    extends State<_VehicleModelServicesView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
        final categories = state.serviceGroups
            .expand((group) => group.emdadCategories)
            .toList(growable: false);
        final selectedCategories = categories
            .where((category) => category.selected)
            .toList(growable: false);
        final visibleGroups = _filterGroups(state.serviceGroups);

        return Directionality(
          textDirection: TextDirection.rtl,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.stylus,
              },
            ),
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: SimpleAppBar(
                title: 'سرویس های نوع خودرو',
                onBack: state.isServicesSubmitting
                    ? () {}
                    : () => context.pop(),
              ),
              body: _buildBody(
                context: context,
                cubit: cubit,
                state: state,
                categories: categories,
                selectedCategories: selectedCategories,
                visibleGroups: visibleGroups,
              ),
              bottomNavigationBar: StickyFormActionBar(
                submitTitle: 'ثبت',
                cancelTitle: 'انصراف',
                isSubmitting: state.isServicesSubmitting,
                onCancel: () => context.pop(),
                onSubmit: () => _submit(context, cubit),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required VehicleModelCubit cubit,
    required VehicleModelState state,
    required List<EmdadServiceCategoryEntity> categories,
    required List<EmdadServiceCategoryEntity> selectedCategories,
    required List<VehicleServiceGroupEntity> visibleGroups,
  }) {
    if (state.isServiceGroupsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.serviceGroups.isEmpty || state.selectedVehicleModel == null) {
      return SwipeRefreshContainer(
        onRefresh: () async {
          final item = state.selectedVehicleModel;
          if (item == null || state.isServicesSubmitting) return;
          await cubit.fetchServiceGroups(item);
        },
        child: const Center(child: EmptyListWidget()),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        final item = state.selectedVehicleModel;
        if (item == null || state.isServicesSubmitting) return;
        await cubit.fetchServiceGroups(item);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p16,
          AppPadding.p32,
        ),
        children: [
          VehicleModelServiceHeaderCard(item: state.selectedVehicleModel!),
          Space.h24,
          if (selectedCategories.isNotEmpty) ...[
            SelectedItemsSection<EmdadServiceCategoryEntity>(
              title: 'سرویس های انتخاب شده',
              items: selectedCategories,
              itemTitle: (category) => category.title ?? '---',
              onRemove: state.isServicesSubmitting
                  ? null
                  : cubit.toggleServiceCategory,
            ),
            Space.h24,
          ],
          SearchInputField(
            controller: _searchController,
            hintText: 'جستجو',
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          Space.h16,
          SelectionSelectAllTile(
            value: categories.isNotEmpty &&
                categories.every((category) => category.selected),
            enabled: !state.isServicesSubmitting,
            onChanged: cubit.setAllServiceCategories,
          ),
          Space.h12,
          if (visibleGroups.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p32),
              child: Center(
                child: Text('سرویسی با این عنوان یافت نشد.'),
              ),
            )
          else
            ...visibleGroups.map(
              (group) => VehicleModelServiceGroupSection(
                group: group,
                enabled: !state.isServicesSubmitting,
                onToggle: cubit.toggleServiceCategory,
                isSettingsLoading: (category) =>
                    state.isDefectsLoading &&
                    state.loadingDefectServiceCategoryId == category.id,
                onSettings: (category) {
                  if (state.isServicesSubmitting ||
                      !category.selected ||
                      state.isDefectsLoading) {
                    return;
                  }
                  _openDefects(context, category);
                },
              ),
            ),
        ],
      ),
    );
  }

  List<VehicleServiceGroupEntity> _filterGroups(
    List<VehicleServiceGroupEntity> groups,
  ) {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return groups;

    return groups
        .map(
          (group) => group.copyWith(
            emdadCategories: group.emdadCategories
                .where(
                  (category) => (category.title ?? '')
                      .toLowerCase()
                      .contains(query),
                )
                .toList(growable: false),
          ),
        )
        .where((group) => group.emdadCategories.isNotEmpty)
        .toList(growable: false);
  }

  Future<void> _submit(
    BuildContext context,
    VehicleModelCubit cubit,
  ) async {
    if (cubit.state.isServicesSubmitting) return;
    final success = await cubit.submitServiceCategories();
    if (!context.mounted || !success) return;
    context.pop(VehicleModelServicesResult.saved);
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
