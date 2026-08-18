import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_cubit.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/cubit/vehicle_model_state.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_model/presentation/widgets/vehicle_model_status_filter_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleModelFiltersRow extends StatelessWidget {
  const VehicleModelFiltersRow({
    super.key,
    required this.cubit,
    required this.state,
  });

  final VehicleModelCubit cubit;
  final VehicleModelState state;

  @override
  Widget build(BuildContext context) {
    final selectedStatus = VehicleModelStatusFilterItem.values.firstWhere(
      (item) => item.value == state.pageStatusFilter,
      orElse: () => VehicleModelStatusFilterItem.all,
    );

    return FiltersRow(
      filters: [
        FilterButton(
          title: selectedStatus.label == 'همه' ? 'وضعیت' : selectedStatus.label,
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
            return OverlayDropdownMenu<VehicleModelStatusFilterItem>(
              position: position,
              width: width,
              items: VehicleModelStatusFilterItem.values,
              onDismiss: dismiss,
              onSelect: (item) {
                cubit.setPageStatusFilter(item.value);
                dismiss();
              },
            );
          },
        ),
        FilterButton(
          title: 'فیلترها',
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showFilterBottomSheet<void>(
                context: context,
                builder: (_) => BlocBuilder<VehicleModelCubit, VehicleModelState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return VehicleModelFilterSheet(
                      initialCode: state.codeFilter,
                      initialName: state.nameFilter,
                      initialIsActive: state.isActiveFilter,
                      initialNavganTypeTitle: state.navganTypeTitleFilter,
                      initialHasDepot: state.hasDepotFilter,
                      navgans: state.navgans,
                      isNavgansLoading: state.isNavgansLoading,
                      onSubmit: (
                        code,
                        name,
                        isActive,
                        navganTypeTitle,
                        hasDepot,
                      ) => cubit.applyFilter(
                        code: code,
                        name: name,
                        isActive: isActive,
                        navganTypeTitle: navganTypeTitle,
                        hasDepot: hasDepot,
                      ),
                    );
                  },
                ),
              );
              dismiss();
            });

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
