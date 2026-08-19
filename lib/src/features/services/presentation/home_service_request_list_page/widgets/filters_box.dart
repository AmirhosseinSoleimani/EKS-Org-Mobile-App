import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/home_service_request_list_page/cubit/home_service_request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/session/domain/entity/current_session_enum_item_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/search_request_form.dart';
import 'package:flutter/material.dart';

class FiltersBox extends StatelessWidget {
  final HomeServiceRequestListCubit cubit;

  const FiltersBox({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FiltersRow(
          filters: [
            ValueListenableBuilder<int>(
              valueListenable: cubit.selectedStatusNotifier,
              builder: (_, status, _) {
                final statusItems = cubit.requestStatusItems
                    .map(_RequestStatusFilterItem.fromSessionItem)
                    .toList(growable: false);

                return FilterButton(
                  title: cubit.requestStatusTitle(status),
                  expand: true,
                  overlayBuilder: (context, position, width, dismiss) {
                    return OverlayDropdownMenu<_RequestStatusFilterItem>(
                      position: position,
                      width: width,
                      items: statusItems,
                      onDismiss: dismiss,
                      onSelect: (value) {
                        cubit.setSelectedStatus(value.value);
                        cubit.fetchRequestList();
                        dismiss();
                      },
                    );
                  },
                );
              },
            ),
            FilterButton(
              title: 'فیلترها',
              expand: true,
              overlayBuilder: (context, position, width, dismiss) {
                _showFilterBottomSheet(
                  context: context,
                  serviceType: ServiceType.homeService,
                  dismissOverlay: dismiss,
                );

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        Space.h8,
        ValueListenableBuilder<TimePeriod>(
          valueListenable: cubit.selectedTimePeriodNotifier,
          builder: (_, period, _) {
            return FilterButton(
              title: period.label,
              expand: true,
              overlayBuilder: (context, position, width, dismiss) {
                return OverlayDropdownMenu<TimePeriod>(
                  position: position,
                  width: width,
                  items: TimePeriod.values,
                  onDismiss: dismiss,
                  onSelect: (value) {
                    cubit.setSelectedTimePeriod(value);
                    cubit.fetchRequestList();
                    dismiss();
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _showFilterBottomSheet({
    required BuildContext context,
    required ServiceType serviceType,
    required VoidCallback dismissOverlay,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showFilterBottomSheet<void>(
        context: context,
        builder: (sheetContext) => FilterBottomSheetScaffold(
          title: 'فیلترها',
          shrinkWrapContent: true,
          applyButtonColor: serviceType.serviceColor,
          onApply: () {
            cubit.fetchRequestList();
            Navigator.of(sheetContext).pop();
          },
          onClear: () {
            cubit.clearFilters();
            Navigator.of(sheetContext).pop();
          },
          child: SearchRequestForm(
            requestNumberController: cubit.requestNumberController,
            phoneController: cubit.phoneController,
            chassisNumberController: cubit.chassisNumberController,
            rescuerNameController: cubit.rescuerNameController,
            cityController: cubit.cityController,
            provinceController: cubit.provinceController,
            serviceType: serviceType,
          ),
        ),
      );

      dismissOverlay();
    });
  }
}

class _RequestStatusFilterItem implements DropdownItem<int> {
  const _RequestStatusFilterItem({
    required this.value,
    required this.label,
  });

  factory _RequestStatusFilterItem.fromSessionItem(
    CurrentSessionEnumItemEntity item,
  ) {
    return _RequestStatusFilterItem(
      value: item.value!,
      label: item.title?.trim().isNotEmpty == true ? item.title!.trim() : '-',
    );
  }

  @override
  final int value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) => null;
}
