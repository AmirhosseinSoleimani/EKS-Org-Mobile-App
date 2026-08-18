import 'package:eks_sana_plus_org/src/common/constants/request_status.dart';
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/relief_request_list_page/cubit/relief_request_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filters_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/search_request_form.dart';
import 'package:flutter/material.dart';

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
        FilterButton(
          title: 'فیلترها',
          expand: true,
          overlayBuilder: (context, position, width, dismiss) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showFilterBottomSheet<void>(
                context: context,
                builder: (sheetContext) => FilterBottomSheetScaffold(
                  title: 'فیلترها',
                  onApply: () {
                    cubit.fetchRequestList();
                    Navigator.of(sheetContext).pop();
                  },
                  onClear: () {
                    cubit.clearFilters();
                    Navigator.of(sheetContext).pop();
                  },
                  child: SearchRequestForm(
                    requestNumberController: cubit.requestNumberController,
                    phoneController: cubit.phoneController,
                    chassisNumberController: cubit.chassisNumberController,
                    rescuerNameController: cubit.rescuerNameController,
                    cityController: cubit.cityController,
                    provinceController: cubit.provinceController,
                    serviceType: ServiceType.reliefService,
                  ),
                ),
              );

              dismiss();
            });

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
