import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/list/rescuer_list_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/enums/rescuer_status_filter.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/filter/rescuer_filter_form.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RescuerFiltersBox extends StatelessWidget {
  final RescuerListCubit cubit;
  final VoidCallback onReportTap;

  const RescuerFiltersBox({
    super.key,
    required this.cubit,
    required this.onReportTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FiltersRow(
          filters: [
            FilterButton(
              title: 'فیلترها',
              expand: true,
              overlayBuilder: (overlayContext, position, width, dismiss) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  BottomSheetMessage.showCustom(
                    context: overlayContext,
                    content: RescuerFilterForm(
                      cubit: cubit,
                      onApply: () {
                        FocusScope.of(overlayContext).unfocus();
                        cubit.applyFilters();
                        overlayContext.pop();
                      },
                      onClear: () {
                        cubit.clearFilters();
                        overlayContext.pop();
                      },
                    ),
                    actionWidget: const SizedBox.shrink(),
                  );
                  dismiss();
                });
                return const SizedBox.shrink();
              },
            ),
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
          ],
        ),
        Space.h12,
        FilterButton(
          title: 'گزارش‌گیری',
          icon: Icons.summarize_outlined,
          expand: true,
          onTap: onReportTap,
        ),
      ],
    );
  }
}
