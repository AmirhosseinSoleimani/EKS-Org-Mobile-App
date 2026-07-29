import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_list_cubit.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/cubit/special_plan_list_state.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_filter_actions.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_filter_controller.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_filter_value.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_status_filter_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';

class SpecialPlanFiltersRow extends StatelessWidget {
  const SpecialPlanFiltersRow({
    super.key,
    required this.cubit,
    required this.state,
  });

  final SpecialPlanListCubit cubit;
  final SpecialPlanListState state;

  @override
  Widget build(BuildContext context) {
    final selectedStatus = SpecialPlanStatusFilterItem.values.firstWhere(
      (item) => item.value == state.pageStatusFilter,
      orElse: () => SpecialPlanStatusFilterItem.all,
    );

    return FiltersRow(
      filters: [
        FilterButton(
          title: 'فیلترها',
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showFilterSheet(context);
              dismiss();
            });

            return const SizedBox.shrink();
          },
        ),
        FilterButton(
          title: selectedStatus.label == 'همه'
              ? 'وضعیت'
              : selectedStatus.label,
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
            return OverlayDropdownMenu<SpecialPlanStatusFilterItem>(
              position: position,
              width: width,
              items: SpecialPlanStatusFilterItem.values,
              onDismiss: dismiss,
              onSelect: (item) {
                cubit.setStatusFilter(item.value);
                dismiss();
              },
            );
          },
        ),
      ],
    );
  }

  void _showFilterSheet(BuildContext context) {
    final controller = SpecialPlanFilterController(
      products: state.products,
      provinces: state.provinces,
      initialValue: SpecialPlanFilterValue(
        title: state.titleFilter,
        productId: state.productIdFilter,
        hasHighPriority: state.hasHighPriorityFilter,
        startDate: state.startDateFilter,
        endDate: state.endDateFilter,
        orderNo: state.orderNoFilter,
        provinceTitle: state.provinceTitleFilter,
        cityTitle: state.cityTitleFilter,
        isActive: state.isActiveFilter,
        onlySaipaCars: state.onlySaipaCarsFilter,
      ),
    );

    BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      isDismissible: true,
      enableDrag: true,
      content: SpecialPlanFilterSheet(
        products: state.products,
        provinces: state.provinces,
        controller: controller,
      ),
      actionWidget: SpecialPlanFilterActions(
        onApply: (sheetContext) {
          final value = controller.value;
          Navigator.of(sheetContext).pop();
          _applyFilter(value);
        },
        onClear: (sheetContext) {
          Navigator.of(sheetContext).pop();
          _applyFilter(const SpecialPlanFilterValue());
        },
      ),
    ).whenComplete(controller.dispose);
  }

  void _applyFilter(SpecialPlanFilterValue value) {
    cubit.applyFilter(
      title: value.title,
      productId: value.productId,
      hasHighPriority: value.hasHighPriority,
      startDate: value.startDate,
      endDate: value.endDate,
      orderNo: value.orderNo,
      provinceTitle: value.provinceTitle,
      cityTitle: value.cityTitle,
      isActive: value.isActive,
      onlySaipaCars: value.onlySaipaCars,
    );
  }
}
