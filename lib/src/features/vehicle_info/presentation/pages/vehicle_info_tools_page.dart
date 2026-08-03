import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_tool_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/tools/vehicle_tools_section.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_form/vehicle_info_form_scaffold.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_service_info_card.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selected_items_section.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selection_select_all_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/search_input_field.dart';
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
      listener: _onStateChanged,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: const SimpleAppBar(title: 'ابزارها'),
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
                    : () => cubit.submitTools(item.id!),
              );
            },
          ),
          body: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
            builder: (context, state) {
              final data = state.data;

              if (data.loadingToolsVehicleId != null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (data.tools.isEmpty) {
                return const Center(
                  child: Text('ابزاری برای این خودرو یافت نشد.'),
                );
              }

              final selectedTools = data.tools
                  .where((tool) => tool.isSelectable)
                  .toList(growable: false);

              return ListView(
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
                  if (selectedTools.isNotEmpty) ...[
                    SelectedItemsSection<VehicleToolEntity>(
                      title: 'ابزارهای انتخاب شده',
                      items: selectedTools,
                      itemTitle: (tool) => tool.emdadToolsTitle,
                      onRemove: data.isSubmitting
                          ? null
                          : (tool) => cubit.toggleTool(tool.emdadToolsId),
                    ),
                    Space.h24,
                  ],
                  SearchInputField(
                    hintText: 'جستجو',
                    controller: cubit.toolsSearchController,
                    onChanged: cubit.onToolsSearchChanged,
                  ),
                  Space.h16,
                  SelectionSelectAllTile(
                    value: data.tools.every((tool) => tool.isSelectable),
                    enabled: !data.isSubmitting,
                    onChanged: cubit.setAllTools,
                  ),
                  Space.h12,
                  if (data.filteredTools.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppPadding.p32,
                      ),
                      child: Center(
                        child: Text('ابزاری با این عنوان یافت نشد.'),
                      ),
                    )
                  else
                    VehicleToolsSection(
                      tools: data.filteredTools,
                      onSelect:
                          data.isSubmitting ? null : cubit.toggleTool,
                    ),
                ],
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
}
