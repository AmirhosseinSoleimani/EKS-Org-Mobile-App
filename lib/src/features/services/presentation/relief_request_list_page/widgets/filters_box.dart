import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/cubit/relief_request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/search_request_form.dart';
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
    return FiltersRow(
      filters: [
        FilterButton(
          title: 'فیلتر ها',
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
                  serviceType: ServiceType.reliefService,
                ),
                actionWidget: Row(
                  children: [
                    Expanded(
                      child: InkwellButtonWidget(
                        title: 'اعمال فیلتر',
                        backgroundColor: Theme.of(context).colorScheme.primary,
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

              dismiss();
            });

            return const SizedBox.shrink();
          },
        ),
        ValueListenableBuilder<RequestStatus>(
          valueListenable: cubit.selectedStatusNotifier,
          builder: (_, status, _) {
            return FilterButton(
              title: status.label,
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
    );
  }
}
