import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_range_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/date_range_filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';

class FiltersBox extends StatelessWidget {
  final DashboardCubit cubit;

  const FiltersBox({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return FiltersRow(
      itemHeight: AppSize.s48,
      filters: [
        ValueListenableBuilder(
          valueListenable: cubit.selectedServiceTypeNotifier,
          builder: (_, serviceType, _) {
            return FilterButton(
              title: serviceType.label,
              expand: true,
              overlayBuilder: (context, position, width, dismiss) {
                return OverlayDropdownMenu<ServiceType>(
                  position: position,
                  width: width,
                  items: ServiceType.values,
                  onDismiss: dismiss,
                  onSelect: (value) {
                    cubit.setServiceType(value);
                    cubit.loadDashboardData();
                    dismiss();
                  },
                );
              },
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: cubit.selectedDateFilterActiveNotifier,
          builder: (_, isDateFilterActive, _) {
            return ValueListenableBuilder(
              valueListenable: cubit.selectedFromDateNotifier,
              builder: (_, fromDate, _) {
                return ValueListenableBuilder(
                  valueListenable: cubit.selectedToDateNotifier,
                  builder: (_, toDate, _) {
                    return DateRangeFilterButton(
                      fromDate: fromDate,
                      toDate: toDate,
                      isActive: isDateFilterActive,
                      onClear: cubit.resetDateRangeToToday,
                      onTap: () => _showDateFilter(
                        context,
                        fromDate: isDateFilterActive ? fromDate : null,
                        toDate: isDateFilterActive ? toDate : null,
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _showDateFilter(
    BuildContext context, {
    required DateTime? fromDate,
    required DateTime? toDate,
  }) {
    showFilterBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => DateRangeFilterSheet(
        initialFromDate: fromDate,
        initialToDate: toDate,
        onApply: cubit.applyDateRange,
        onClear: cubit.resetDateRangeToToday,
      ),
    );
  }
}
