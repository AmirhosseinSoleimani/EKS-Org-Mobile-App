import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/indicator_report/presentation/indicator_report_page/cubit/indicator_report_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/date_drop_down.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class FiltersBox extends StatelessWidget {
  final IndicatorReportCubit cubit;

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
              fitTitleToAvailableWidth: true,
              expand: true,
              overlayBuilder: (context, position, width, dismiss) {
                return OverlayDropdownMenu<ServiceType>(
                  position: position,
                  width: width,
                  items: ServiceType.values,
                  onDismiss: dismiss,
                  onSelect: (value) {
                    cubit.setServiceType(value);
                    cubit.loadReports();
                    dismiss();
                  },
                );
              },
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: cubit.selectedFromDateNotifier,
          builder: (_, fromDate, _) {
            return ValueListenableBuilder(
              valueListenable: cubit.selectedToDateNotifier,
              builder: (_, toDate, _) {
                return FilterButton(
                  title: _dateFilterTitle(fromDate, toDate),
                  fitTitleToAvailableWidth: true,
                  titleTextDirection: fromDate != null && toDate != null
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  expand: true,
                  overlayBuilder: (context, position, width, dismiss) {
                    return DateDropdown(
                      position: position,
                      width: width + 50,
                      onDismiss: dismiss,
                      initialFromDate: fromDate == null
                          ? null
                          : Jalali.fromDateTime(fromDate),
                      initialToDate:
                          toDate == null ? null : Jalali.fromDateTime(toDate),
                      requireDateRange: true,
                      onApply: (from, to) {
                        if (from == null || to == null) return;

                        cubit.setFromDate(from.toDateTime());
                        cubit.setToDate(to.toDateTime());
                        cubit.loadReports();
                        dismiss();
                      },
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

  String _dateFilterTitle(DateTime? fromDate, DateTime? toDate) {
    if (fromDate == null || toDate == null) {
      return 'فیلتر بر اساس تاریخ';
    }

    return '${_formatJalaliDate(fromDate)} - ${_formatJalaliDate(toDate)}';
  }

  String _formatJalaliDate(DateTime date) {
    final jalali = Jalali.fromDateTime(date);
    final month = jalali.month.toString().padLeft(2, '0');
    final day = jalali.day.toString().padLeft(2, '0');

    return '${jalali.year}/$month/$day';
  }
}
