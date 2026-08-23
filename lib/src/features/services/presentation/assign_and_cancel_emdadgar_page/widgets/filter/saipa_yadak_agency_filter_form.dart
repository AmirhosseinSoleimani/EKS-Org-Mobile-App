import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class SaipaYadakAgencyFilterForm extends StatelessWidget {
  final AssignAndCancelEmdadgarCubit cubit;

  const SaipaYadakAgencyFilterForm({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final serviceColor = cubit.selectedRequest?.serviceType?.serviceColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormFieldWidget(
          controller: cubit.agencyNameController,
          labelText: 'نام نمایندگی',
          borderColor: serviceColor,
        ),
        FilterBottomSheetScaffold.fieldGap,
        TextFormFieldWidget(
          controller: cubit.agencyCodeController,
          labelText: 'کد نمایندگی',
          borderColor: serviceColor,
        ),
      ],
    );
  }
}
