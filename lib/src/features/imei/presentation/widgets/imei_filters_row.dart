import 'package:eks_sana_plus_org/src/features/imei/presentation/cubit/imei_cubit.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/widgets/imei_filter_sheet.dart';
import 'package:eks_sana_plus_org/src/features/imei/presentation/widgets/imei_status_filter_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';

class ImeiFiltersRow extends StatelessWidget {
  const ImeiFiltersRow({super.key, required this.cubit});

  final ImeiCubit cubit;

  @override
  Widget build(BuildContext context) {
    final selectedStatus = ImeiStatusFilterItem.values.firstWhere(
      (item) => item.value == cubit.state.pageStatusFilter,
      orElse: () => ImeiStatusFilterItem.all,
    );

    return FiltersRow(
      filters: [
        FilterButton(
          title: 'فیلترها',
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              BottomSheetMessage.showCustom(
                context: context,
                content: ImeiFilterSheet(cubit: cubit),
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
        FilterButton(
          title: selectedStatus.label == 'همه' ? 'وضعیت' : selectedStatus.label,
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
            return OverlayDropdownMenu<ImeiStatusFilterItem>(
              position: position,
              width: width,
              items: ImeiStatusFilterItem.values,
              onDismiss: dismiss,
              onSelect: (item) {
                cubit.setPageStatusFilter(item.value);
                dismiss();
              },
            );
          },
        ),
      ],
    );
  }
}
