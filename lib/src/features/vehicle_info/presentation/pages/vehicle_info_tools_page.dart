import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_info_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/cubit/vehicle_info_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_service_info_card.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/tools/vehicle_tool_chip.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
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
          appBar: SimpleAppBar(title: 'ابزار ها'),
          backgroundColor: const Color(0xFFF4F4F4),
          bottomNavigationBar: BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
            builder: (context, state) {
              return SafeArea(
                minimum: const EdgeInsets.all(AppPadding.p16),
                child: InkwellButtonWidget(
                  title: 'بستن',
                  showLoading: state.data.isSubmitting,
                  onTap: (){context.pop();}//item.id == null ? null : () => cubit.submitTools(item.id!),
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
                  _ToolsSearchField(cubit: cubit),
                  Space.h24,
                  if (data.filteredTools.isEmpty)
                    const Center(child: Text('ابزاری برای این خودرو یافت نشد.'))
                  else
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: AppSize.s8,
                      runSpacing: 10,
                      children: data.filteredTools.map((tool) {
                        return VehicleToolChip(
                          tool: tool,
                          // onTap: () => cubit.toggleTool(tool.emdadToolsId),
                        );
                      }).toList(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ToolsSearchField extends StatelessWidget {
  const _ToolsSearchField({required this.cubit});

  final VehicleInfoCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SearchInputField(hintText: 'جستجوی ابزار',
      controller: cubit.toolsSearchController,
      onChanged: cubit.onToolsSearchChanged,
    );
  }
}
