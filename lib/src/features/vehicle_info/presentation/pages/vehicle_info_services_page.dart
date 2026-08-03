import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_form/vehicle_info_form_scaffold.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_service_info_card.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_selection_x.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_group_section.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/selected_vehicle_defects_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/app_checkbox_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/search_input_field.dart';
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
      create: (_) => getIt<VehicleInfoCubit>()..loadServiceCategories(item.id ?? 0, grouped: true),
      child: _VehicleInfoServicesView(item: item),
    );
  }
}

class _VehicleInfoServicesView extends StatefulWidget {
  const _VehicleInfoServicesView({required this.item});

  final VehicleInfoEntity item;

  @override
  State<_VehicleInfoServicesView> createState() => _VehicleInfoServicesViewState();
}

class _VehicleInfoServicesViewState extends State<_VehicleInfoServicesView> {
  final List<EmdadServiceCategoryEntity> _initialSelectedCategories = [];
  final TextEditingController _searchController = TextEditingController();

  bool _didCaptureInitialSelection = false;
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
      listener: (context, state) {
        _captureInitialSelectedCategories(state);

        state.maybeWhen(
          failure: (data) {
            if (data.errorMessage?.isNotEmpty == true) {
              SnakeBarWidget.showError(
                context: context,
                message: data.errorMessage!,
              );
            }
          },
          connectionError: (data) {
            if (data.errorMessage?.isNotEmpty == true) {
              SnakeBarWidget.showError(
                context: context,
                message: data.errorMessage!,
              );
            }
          },
          success: (data) {
            if (data.successMessage?.isNotEmpty == true) {
              context.pop(data.successMessage);
            }
          },
          orElse: () {},
        );
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: SimpleAppBar(title: 'سرویس ها'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          bottomNavigationBar: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
            builder: (context, state) {
              return VehicleInfoFormActions(
                submitTitle: 'ثبت',
                cancelTitle: 'انصراف',
                isSubmitting: state.data.isSubmitting,
                onCancel: () => context.pop(),
                onSubmit: item.id == null ? () {} : () => cubit.submitServiceCategories(item.id!, useBatchEndpoint: true),
              );
            },
          ),
          body: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
            builder: (context, state) {
              final data = state.data;
              final categories = data.serviceCategoryGroups
                  .expand((group) => group.categories)
                  .toList();
              final visibleGroups = _filterServiceGroups(
                data.serviceCategoryGroups,
              );
              if (data.loadingServicesVehicleId != null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (data.serviceCategoryGroups.isEmpty) {
                return const Center(child: Text('سرویسی برای این خودرو یافت نشد.'));
              }
              return ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p16,
                  AppPadding.p32,
                ),
                children: [
                  VehicleServiceInfoCard(item: item),
                  Space.h24,
                  SelectedVehicleDefectsSection(
                    items: _initialSelectedCategories,
                    onRemove: _removeInitialSelectedCategory,
                  ),
                  Space.h24,
                  SearchInputField(
                    hintText: 'جستجو',
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                  ),
                  Space.h16,
                  AppCheckboxWidget(
                    title: 'انتخاب همه',
                    value: categories.isNotEmpty &&
                        categories.every(
                          (category) => category.isSelectedForVehicle,
                        ),
                    onChanged: _setAllServiceCategories,
                  ),
                  Divider(
                    height: AppSize.s24,
                    color: Theme.of(context).dividerColor,
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
                    ...visibleGroups.map((group) {
                      return ServiceGroupSection(
                        group: group,
                        onSelect: _toggleServiceCategory,
                        onDefects: item.id == null
                            ? null
                            : (categoryId) => _showDefects(
                                  context,
                                  item.id!,
                                  categoryId,
                                ),
                      );
                    }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<EmdadServiceCategoryGroupEntity> _filterServiceGroups(
    List<EmdadServiceCategoryGroupEntity> groups,
  ) {
    final normalizedQuery = _searchQuery.trim().toLowerCase();
    if (normalizedQuery.isEmpty) {
      return groups;
    }

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

  void _captureInitialSelectedCategories(VehicleInfoState state) {
    if (_didCaptureInitialSelection ||
        state.data.loadingServicesVehicleId != null ||
        state.data.serviceCategoryGroups.isEmpty) {
      return;
    }

    final selectedCategories = state.data.serviceCategoryGroups
        .expand((group) => group.categories)
        .where((category) => category.isSelectedForVehicle)
        .toList(growable: false);

    setState(() {
      _didCaptureInitialSelection = true;
      _initialSelectedCategories
        ..clear()
        ..addAll(selectedCategories);
    });
  }

  void _toggleServiceCategory(int categoryId) {
    final cubit = context.read<VehicleInfoCubit>();
    final wasSelected = _isServiceCategorySelected(cubit.state, categoryId);

    cubit.toggleServiceCategory(categoryId);

    if (wasSelected) {
      _removeFromInitialSelection(categoryId);
    }
  }

  void _setAllServiceCategories(bool selected) {
    context.read<VehicleInfoCubit>().setAllServiceCategories(selected);

    if (!selected && _initialSelectedCategories.isNotEmpty) {
      setState(_initialSelectedCategories.clear);
    }
  }

  void _removeInitialSelectedCategory(int categoryId) {
    final cubit = context.read<VehicleInfoCubit>();
    if (_isServiceCategorySelected(cubit.state, categoryId)) {
      cubit.toggleServiceCategory(categoryId);
    }
    _removeFromInitialSelection(categoryId);
  }

  bool _isServiceCategorySelected(VehicleInfoState state, int categoryId) {
    for (final group in state.data.serviceCategoryGroups) {
      for (final category in group.categories) {
        if (category.id == categoryId) {
          return category.isSelectedForVehicle;
        }
      }
    }
    return false;
  }

  void _removeFromInitialSelection(int categoryId) {
    if (!_initialSelectedCategories.any((category) => category.id == categoryId)) {
      return;
    }

    setState(() {
      _initialSelectedCategories.removeWhere((category) => category.id == categoryId);
    });
  }

  void _showDefects(BuildContext context, int vehicleId, int categoryId) {
    final cubit = context.read<VehicleInfoCubit>();
    cubit.loadDefects(vehicleId: vehicleId, serviceCategoryId: categoryId);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
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
              return const SizedBox(height: AppSize.s300, child: Center(child: CircularProgressIndicator()));
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('محدودیت عیوب', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  Space.h12,
                  Expanded(
                    child: data.defects.isEmpty
                        ? const Center(child: Text('عیبی برای این سرویس یافت نشد.'))
                        : ListView(
                            children: data.defects
                                .map((defect) => CheckboxListTile(
                                      value: defect.selected,
                                      title: Text(defect.title),
                                      onChanged: (_) => cubit.toggleDefect(defect.id),
                                    ))
                                .toList(),
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
