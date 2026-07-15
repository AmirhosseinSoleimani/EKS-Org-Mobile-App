import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VehicleInfoToolsPage extends StatelessWidget {
  static const path = '/vehicle-info-tools-page';
  static const name = 'vehicle-info-tools-page';

  const VehicleInfoToolsPage({super.key, required this.item});

  final VehicleInfoEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<VehicleInfoCubit>()..loadTools(item.id ?? 0),
      child: _VehicleInfoToolsView(item: item),
    );
  }
}

class _VehicleInfoToolsView extends StatelessWidget {
  const _VehicleInfoToolsView({required this.item});

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
        appBar: SimpleAppBar(title: 'ابزارهای ${item.title}'),
        bottomNavigationBar: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
          builder: (context, state) {
            return SafeArea(
              minimum: const EdgeInsets.all(AppPadding.p16),
              child: InkwellButtonWidget(
                title: 'ثبت',
                showLoading: state.data.isSubmitting,
                onTap: item.id == null ? null : () => cubit.submitTools(item.id!),
              ),
            );
          },
        ),
        body: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
          builder: (context, state) {
            final data = state.data;
            if (data.loadingToolsVehicleId != null) {
              return const Center(child: CircularProgressIndicator());
            }
            final allSelected = data.tools.isNotEmpty && data.tools.every((item) => item.isSelectable);
            final selectedTools = data.tools.where((item) => item.isSelectable).toList();
            return ListView(
              padding: const EdgeInsets.all(AppPadding.p16),
              children: [
                if (selectedTools.isNotEmpty)
                  Wrap(
                    spacing: AppSize.s8,
                    runSpacing: AppSize.s8,
                    children: selectedTools
                        .map((tool) => InputChip(
                              label: Text(tool.emdadToolsTitle),
                              onDeleted: () => cubit.toggleTool(tool.emdadToolsId),
                            ))
                        .toList(),
                  ),
                Space.h16,
                TextField(
                  controller: cubit.toolsSearchController,
                  decoration: const InputDecoration(
                    labelText: 'جستجوی ابزار',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                  onChanged: cubit.onToolsSearchChanged,
                ),
                CheckboxListTile(
                  value: allSelected,
                  title: const Text('انتخاب همه'),
                  onChanged: (value) => cubit.setAllTools(value ?? false),
                ),
                const Divider(),
                ...data.filteredTools.map((tool) {
                  return CheckboxListTile(
                    value: tool.isSelectable,
                    title: Text(tool.emdadToolsTitle),
                    onChanged: (_) => cubit.toggleTool(tool.emdadToolsId),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
