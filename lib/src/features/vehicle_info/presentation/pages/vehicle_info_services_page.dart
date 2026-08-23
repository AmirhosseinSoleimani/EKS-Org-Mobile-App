import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_selection_x.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_group_section.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_form/vehicle_info_form_scaffold.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_service_info_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selected_items_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_select_all_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/search_input_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/refresh_widgets/swipe_refresh_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VehicleInfoServicesPage extends StatelessWidget {
  static const path = '/vehicle-info-services-page';
  static const name = 'vehicle-info-services-page';

  const VehicleInfoServicesPage({super.key, required this.item});

  final VehicleInfoEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VehicleInfoCubit>()
        ..loadServiceCategories(item.id ?? 0, grouped: true),
      child: _VehicleInfoServicesView(item: item),
    );
  }
}

class _VehicleInfoServicesView extends StatefulWidget {
  const _VehicleInfoServicesView({required this.item});

  final VehicleInfoEntity item;

  @override
  State<_VehicleInfoServicesView> createState() =>
      _VehicleInfoServicesViewState();
}

class _VehicleInfoServicesViewState extends State<_VehicleInfoServicesView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  VehicleInfoEntity get item => widget.item;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VehicleInfoCubit>();

    return BlocListener<VehicleInfoCubit, VehicleInfoState>(
      listener: _onStateChanged,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const SimpleAppBar(title: 'سرویس ها'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          bottomNavigationBar: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
            buildWhen: (previous, current) =>
                previous.data.isSubmitting != current.data.isSubmitting,
            builder: (context, state) {
              return VehicleInfoFormActions(
                submitTitle: 'ثبت',
                cancelTitle: 'انصراف',
                isSubmitting: state.data.isSubmitting,
                onCancel: () => context.pop(),
                onSubmit: item.id == null
                    ? () {}
                    : () => cubit.submitServiceCategories(
                          item.id!,
                          useBatchEndpoint: true,
                        ),
              );
            },
          ),
          body: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
            builder: (context, state) {
              final data = state.data;
              if (data.loadingServicesVehicleId != null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (data.serviceCategoryGroups.isEmpty) {
                return SwipeRefreshContainer(
                  onRefresh: () async {
                    final id = item.id;
                    if (id == null) return;
                    await cubit.loadServiceCategories(id, grouped: true);
                  },
                  child: const Center(
                    child: Text('سرویسی برای این خودرو یافت نشد.'),
                  ),
                );
              }

              final categories = data.serviceCategoryGroups
                  .expand((group) => group.categories)
                  .toList(growable: false);
              final selectedCategories = categories
                  .where((category) => category.isSelectedForVehicle)
                  .toList(growable: false);
              final visibleGroups = _filterServiceGroups(
                data.serviceCategoryGroups,
              );

              return RefreshIndicator(
                onRefresh: () async {
                  final id = item.id;
                  if (id == null) return;
                  await cubit.loadServiceCategories(id, grouped: true);
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(
                    AppPadding.p16,
                    AppPadding.p16,
                    AppPadding.p16,
                    AppPadding.p32,
                  ),
                  children: [
                    VehicleServiceInfoCard(item: item),
                    Space.h24,
                    if (selectedCategories.isNotEmpty) ...[
                      SelectedItemsSection<EmdadServiceCategoryEntity>(
                        title: 'سرویس های انتخاب شده',
                        items: selectedCategories,
                        itemTitle: (category) => category.title,
                        onRemove: data.isSubmitting
                            ? null
                            : (category) =>
                                cubit.toggleServiceCategory(category.id),
                      ),
                      Space.h24,
                    ],
                    SearchInputField(
                      hintText: 'جستجو',
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                    ),
                    Space.h16,
                    SelectionSelectAllTile(
                      value: categories.isNotEmpty &&
                          categories.every(
                            (category) => category.isSelectedForVehicle,
                          ),
                      enabled: !data.isSubmitting,
                      onChanged: cubit.setAllServiceCategories,
                    ),
                    Space.h12,
                    if (visibleGroups.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppPadding.p32,
                        ),
                        child: Center(
                          child: Text('سرویسی با این عنوان یافت نشد.'),
                        ),
                      )
                    else
                      ...visibleGroups.map(
                        (group) => ServiceGroupSection(
                          group: group,
                          onSelect: data.isSubmitting
                              ? null
                              : cubit.toggleServiceCategory,
                          onDefects: data.isSubmitting || item.id == null
                              ? null
                              : (categoryId) => _showDefects(
                                    context,
                                    item.id!,
                                    categoryId,
                                  ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, VehicleInfoState state) {
    state.maybeWhen(
      failure: (data) => _showError(context, data.errorMessage),
      connectionError: (data) => _showError(context, data.errorMessage),
      success: (data) {
        final message = data.successMessage;
        if (message?.isNotEmpty == true) {
          context.pop(message);
        }
      },
      orElse: () {},
    );
  }

  void _showError(BuildContext context, String? message) {
    if (message?.isNotEmpty != true) return;
    SnakeBarWidget.showError(context: context, message: message!);
  }

  List<EmdadServiceCategoryGroupEntity> _filterServiceGroups(
    List<EmdadServiceCategoryGroupEntity> groups,
  ) {
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return groups;

    return groups
        .map((group) {
          final filteredCategories = group.categories
              .where(
                (category) =>
                    category.title.toLowerCase().contains(normalizedQuery),
              )
              .toList(growable: false);

          return EmdadServiceCategoryGroupEntity(
            id: group.id,
            code: group.code,
            name: group.name,
            indeterminate: group.indeterminate,
            selectable: group.selectable,
            categories: filteredCategories,
          );
        })
        .where((group) => group.categories.isNotEmpty)
        .toList(growable: false);
  }

  void _showDefects(BuildContext context, int vehicleId, int categoryId) {
    final cubit = context.read<VehicleInfoCubit>();
    cubit.loadDefects(
      vehicleId: vehicleId,
      serviceCategoryId: categoryId,
    );

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s20),
        ),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: _DefectsSheet(vehicleId: vehicleId),
      ),
    );
  }
}

class _DefectsSheet extends StatelessWidget {
  const _DefectsSheet({required this.vehicleId});

  final int vehicleId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VehicleInfoCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
          builder: (context, state) {
            final data = state.data;
            if (data.loadingDefectsServiceCategoryId != null) {
              return const SizedBox(
                height: AppSize.s300,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleMediumText(
                    text: 'محدودیت عیوب',
                    fontWeight: FontWeight.w800,
                  ),
                  Space.h12,
                  Expanded(
                    child: data.defects.isEmpty
                        ? const Center(child: EmptyListWidget())
                        : ListView(
                            children: data.defects
                                .map(
                                  (defect) => CheckboxListTile(
                                    value: defect.selected,
                                    title: BodyMediumText(text: defect.title),
                                    onChanged: (_) =>
                                        cubit.toggleDefect(defect.id),
                                  ),
                                )
                                .toList(growable: false),
                          ),
                  ),
                  InkwellButtonWidget(
                    title: 'ثبت محدودیت عیوب',
                    showLoading: data.isSubmitting,
                    onTap: () => cubit.submitDefects(vehicleId),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
