import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/date_drop_down.dart';
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
      filters: [
        ValueListenableBuilder(
          valueListenable: cubit.selectedFromDateNotifier,
          builder: (_, fromDate, _) {
            return ValueListenableBuilder(
              valueListenable: cubit.selectedToDateNotifier,
              builder: (_, toDate, _) {
                return FilterButton(
                  title: fromDate != null || toDate != null
                      ? "تاریخ انتخاب شده"
                      : "فیلتر بر اساس تاریخ",
                  expand: true,
                  overlayBuilder: (context, position, width, dismiss) {
                    return DateDropdown(
                      position: position,
                      width: width + 50,
                      onDismiss: dismiss,
                      onApply: (from, to) {
                        if (from != null) cubit.setFromDate(from.toDateTime());
                        if (to != null) cubit.setToDate(to.toDateTime());
                        cubit.loadDashboardData();
                        dismiss();
                      },
                    );
                  },
                );
              },
            );
          },
        ),
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
        )
      ],
    );
  }
}
