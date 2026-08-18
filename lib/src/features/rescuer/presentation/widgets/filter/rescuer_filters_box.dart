import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/list/rescuer_list_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/enums/rescuer_status_filter.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/filter/rescuer_filter_form.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/report_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';

class RescuerFiltersBox extends StatelessWidget {
  final RescuerListCubit cubit;
  final VoidCallback onReportTap;
  final bool isReportLoading;

  const RescuerFiltersBox({
    super.key,
    required this.cubit,
    required this.onReportTap,
    this.isReportLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        FiltersRow(
          filters: [
            ValueListenableBuilder<RescuerStatusFilter>(
              valueListenable: cubit.selectedStatusNotifier,
              builder: (context, status, _) {
                return FilterButton(
                  title: status == RescuerStatusFilter.all
                      ? 'وضعیت'
                      : status.label,
                  expand: true,
                  overlayBuilder: (context, position, width, dismiss) {
                    return OverlayDropdownMenu<RescuerStatusFilter>(
                      position: position,
                      width: width,
                      items: RescuerStatusFilter.values,
                      onDismiss: dismiss,
                      onSelect: (value) {
                        cubit.setSelectedStatus(value);
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
              overlayBuilder: (overlayContext, position, width, dismiss) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showFilterBottomSheet<void>(
                    context: overlayContext,
                    builder: (sheetContext) => RescuerFilterForm(
                      cubit: cubit,
                      onApply: () {
                        FocusScope.of(sheetContext).unfocus();
                        cubit.applyFilters();
                        Navigator.of(sheetContext).pop();
                      },
                      onClear: () {
                        cubit.clearFilters();
                        Navigator.of(sheetContext).pop();
                      },
                    ),
                  );
                  dismiss();
                });
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        Space.h12,
        ReportButtonWidget(
          isLoading: isReportLoading,
          onTap: () {
            if (isReportLoading) return;
            onReportTap();
          },
        )
      ],
    );
  }
}
