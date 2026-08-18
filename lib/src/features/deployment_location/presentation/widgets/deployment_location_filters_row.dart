import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/cubit/deployment_location_cubit.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/cubit/deployment_location_state.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/deployment_location/presentation/widgets/deployment_location_status_filter_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';

class DeploymentLocationFiltersRow extends StatelessWidget {
  const DeploymentLocationFiltersRow({
    super.key,
    required this.cubit,
    required this.state,
  });

  final DeploymentLocationCubit cubit;
  final DeploymentLocationState state;

  @override
  Widget build(BuildContext context) {
    final selectedStatus = DeploymentLocationStatusFilterItem.values.firstWhere(
      (item) => item.value == state.pageStatusFilter,
      orElse: () => DeploymentLocationStatusFilterItem.all,
    );

    return FiltersRow(
      filters: [
        FilterButton(
          title: selectedStatus.label == 'همه'
              ? 'وضعیت'
              : selectedStatus.label,
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
            return OverlayDropdownMenu<DeploymentLocationStatusFilterItem>(
              position: position,
              width: width,
              items: DeploymentLocationStatusFilterItem.values,
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
              BottomSheetMessage.showCustom(
                context: context,
                content: DeploymentLocationFilterSheet(
                  initialTitle: state.titleFilter,
                  initialProvinceTitle: state.provinceTitleFilter,
                  initialCityTitle: state.cityTitleFilter,
                  initialAddress: state.addressFilter,
                  initialIsActive: state.isActiveFilter,
                  onSubmit: (
                    title,
                    provinceTitle,
                    cityTitle,
                    address,
                    isActive,
                  ) =>
                      cubit.applyFilter(
                    title: title,
                    provinceTitle: provinceTitle,
                    cityTitle: cityTitle,
                    address: address,
                    isActive: isActive,
                  ),
                ),
                actionWidget: const SizedBox.shrink(),
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                isDismissible: true,
                enableDrag: true,
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
