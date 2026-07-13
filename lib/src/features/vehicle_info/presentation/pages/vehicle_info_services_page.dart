import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/emdad_service_category_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
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
      child: Scaffold(
        appBar: SimpleAppBar(title: 'سرویس های ${item.title}'),
        bottomNavigationBar: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
          builder: (context, state) {
            return SafeArea(
              minimum: const EdgeInsets.all(AppPadding.p16),
              child: InkwellButtonWidget(
                title: 'ثبت سرویس ها',
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
            return ListView.builder(
              padding: const EdgeInsets.all(AppPadding.p16),
              itemCount: data.serviceCategoryGroups.length,
              itemBuilder: (context, index) {
                final group = data.serviceCategoryGroups[index];
                return _ServiceGroupTile(
                  group: group,
                  onToggle: cubit.toggleServiceCategory,
                  onDefects: item.id == null
                      ? null
                      : (categoryId) => _showDefects(context, item.id!, categoryId),
                );
              },
            );
          },
        ),
      ),
    );
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

class _ServiceGroupTile extends StatelessWidget {
  const _ServiceGroupTile({
    required this.group,
    required this.onToggle,
    required this.onDefects,
  });

  final EmdadServiceCategoryGroupEntity group;
  final ValueChanged<int> onToggle;
  final ValueChanged<int>? onDefects;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)),
      child: ExpansionTile(
        title: Text(group.name),
        children: group.categories.map((category) {
          return CheckboxListTile(
            value: category.selected ?? category.selectable,
            title: Text(category.title),
            onChanged: (_) => onToggle(category.id),
            secondary: IconButton(
              icon: const Icon(Icons.report_problem_outlined),
              onPressed: onDefects == null ? null : () => onDefects!(category.id),
            ),
          );
        }).toList(),
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
