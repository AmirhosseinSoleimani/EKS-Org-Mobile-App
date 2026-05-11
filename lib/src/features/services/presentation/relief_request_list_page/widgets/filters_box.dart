import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/time_period.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/cubit/relief_request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/search_request_form.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FiltersBox extends StatelessWidget {
  final ReliefRequestListCubit cubit;

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
                        cubit.fetchRequestList();
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
              builder: (_, status, _) {
                return FilterButton(
                  title: status?.label ?? "وضعیت",
                  expand: true,
                  overlayBuilder: (context, position, width, dismiss) {
                    return OverlayDropdownMenu<RequestStatus>(
                      position: position,
                      width: width,
                      items: RequestStatus.values,
                      onDismiss: dismiss,
                      onSelect: (value) {
                        cubit.setSelectedStatus(value);
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

        /// TIME PERIOD
        ValueListenableBuilder(
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
}
