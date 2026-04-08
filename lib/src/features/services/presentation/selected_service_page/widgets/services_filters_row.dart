import 'package:eks_sana_plus_org/src/features/services/presentation/selected_service_page/cubit/selected_service_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/search_request_form.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/status_drop_down.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServicesFiltersRow extends StatelessWidget {
  final SelectedServiceCubit cubit;

  const ServicesFiltersRow({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return FiltersRow(
      filters: [
        /// FILTERS BUTTON
        FilterButton(
          title: "فیلتر ها",
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
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
                ),
                actionWidget: InkwellButtonWidget(
                  title: "اعمال فیلتر",
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onTap: () {
                    cubit.init();
                    context.pop();
                  },
                ),
                isDismissible: true,
                enableDrag: true,
              );

              dismiss();
            });

            return const SizedBox.shrink();
          },
        ),

        /// STATUS FILTER
        ValueListenableBuilder(
          valueListenable: cubit.selectedStatusNotifier,
          builder: (_, status, __) {
            return FilterButton(
              title: status?.title ?? "وضعیت",
              expand: true,
              overlayBuilder: (context, position, width, dismiss) {
                return StatusDropdown(
                  position: position,
                  width: width,
                  onDismiss: dismiss,
                  onSelect: (value) {
                    cubit.setStatus(value);
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
}
