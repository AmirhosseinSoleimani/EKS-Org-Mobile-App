import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_service_info_card.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_category_selection_x.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/services/service_group_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
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

class _VehicleInfoServicesView extends StatelessWidget {
  const _VehicleInfoServicesView({required this.item});

  final VehicleInfoEntity item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VehicleInfoCubit>();

    return BlocListener<VehicleInfoCubit, VehicleInfoState>(
      listener: (context, state) {
        if (state.data.errorMessage?.isNotEmpty == true) {
          SnakeBarWidget.showError(context: context, message: state.data.errorMessage!);
        }
        if (state.data.successMessage?.isNotEmpty == true) {
          SnakeBarWidget.showSuccess(context: context, message: state.data.successMessage!);
          context.pop(true);
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: SimpleAppBar(title: 'سرویس ها'),
          backgroundColor: const Color(0xFFF4F4F4),
          bottomNavigationBar: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
            builder: (context, state) {
              return SafeArea(
                minimum: const EdgeInsets.all(AppPadding.p16),
                child: InkwellButtonWidget(
                  title: 'بستن',
                  showLoading: state.data.isSubmitting,
                  onTap: item.id == null ? null : () => cubit.submitServiceCategories(item.id!, useBatchEndpoint: true),
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
                  ...data.serviceCategoryGroups.map((group) {
                    return ServiceGroupSection(
                      group: group,
                      onSelect: (categoryId) => _selectSingleCategory(context, group, categoryId),
                      onDefects: item.id == null
                          ? null
                          : (categoryId) => _showDefects(context, item.id!, categoryId),
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

  void _selectSingleCategory(
    BuildContext context,
    EmdadServiceCategoryGroupEntity group,
    int categoryId,
  ) {
    final cubit = context.read<VehicleInfoCubit>();
    EmdadServiceCategoryEntity? target;
    for (final category in group.categories) {
      if (category.id == categoryId) {
        target = category;
        break;
      }
    }
    final targetIsSelected = target?.isSelectedForVehicle == true;

    for (final category in group.categories) {
      if (category.id != categoryId && category.isSelectedForVehicle) {
        cubit.toggleServiceCategory(category.id);
      }
    }

    if (!targetIsSelected) {
      cubit.toggleServiceCategory(categoryId);
    }
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
