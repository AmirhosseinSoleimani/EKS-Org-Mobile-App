import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/home_service_request_list_page/cubit/home_service_request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/search_request_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FiltersBox extends StatelessWidget {
  final HomeServiceRequestListCubit cubit;

  const FiltersBox({
    super.key,
    required this.cubit,
  });

  static final List<_RequestStatusFilterItem> _statusItems = [
    const _RequestStatusFilterItem(value: -1, label: 'همه'),
    ...RequestStatus.values.map(
      (status) => _RequestStatusFilterItem(
        value: status.value,
        label: status.label,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FiltersRow(
          filters: [
            FilterButton(
              title: 'فیلتر ها',
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
            ValueListenableBuilder<int>(
              valueListenable: cubit.selectedStatusNotifier,
              builder: (_, status, _) {
                return FilterButton(
                  title: _statusLabel(status),
                  expand: true,
                  overlayBuilder: (context, position, width, dismiss) {
                    return OverlayDropdownMenu<_RequestStatusFilterItem>(
                      position: position,
                      width: width,
                      items: _statusItems,
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
      BottomSheetMessage.showCustom(
        context: context,
        content: SearchRequestForm(
          requestNumberController: cubit.requestNumberController,
          phoneController: cubit.phoneController,
          chassisNumberController: cubit.chassisNumberController,
          rescuerNameController: cubit.rescuerNameController,
          cityController: cubit.cityController,
          provinceController: cubit.provinceController,
          serviceType: serviceType,
        ),
        actionWidget: Row(
          children: [
            Expanded(
              child: InkwellButtonWidget(
                title: 'اعمال فیلتر',
                backgroundColor: serviceType.serviceColor,
                onTap: () {
                  cubit.fetchRequestList();
                  context.pop();
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: InkwellButtonWidget(
                title: 'پاک کردن فیلتر',
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                borderColor: Theme.of(context).colorScheme.outline,
                titleColor: Theme.of(context).colorScheme.onSurface,
                onTap: () {
                  cubit.clearFilters();
                  context.pop();
                },
              ),
            ),
          ],
        ),
        isDismissible: true,
        enableDrag: true,
      );

      dismissOverlay();
    });
  }

  String _statusLabel(int value) {
    return _statusItems
        .firstWhere(
          (item) => item.value == value,
          orElse: () => const _RequestStatusFilterItem(
            value: -100,
            label: 'درخواست های باز',
          ),
        )
        .label;
  }
}

class _RequestStatusFilterItem implements DropdownItem<int> {
  const _RequestStatusFilterItem({
    required this.value,
    required this.label,
  });

  @override
  final int value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) => null;
}
