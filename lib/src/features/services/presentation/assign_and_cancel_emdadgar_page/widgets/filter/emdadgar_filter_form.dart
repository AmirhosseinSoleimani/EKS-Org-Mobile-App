import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/cubit/assign_and_cancel_emdadgar_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/assign_and_cancel_emdadgar_page/widgets/filter/emdadgar_filter_options_box.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class EmdadgarFilterForm extends StatelessWidget {
  final AssignAndCancelEmdadgarCubit cubit;

  const EmdadgarFilterForm({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final serviceColor = cubit.selectedRequest?.serviceType?.serviceColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormFieldWidget(
          controller: cubit.emdadgarNameController,
          labelText: 'نام امدادرسان',
          borderColor: serviceColor,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: cubit.aidPerCodeController,
          labelText: 'کد نمایندگی',
          borderColor: serviceColor,
        ),
        Space.h12,
        TextFormFieldWidget(
          controller: cubit.aidDistanceKmController,
          labelText: 'فاصله با امداد خواه (کیلومتر)',
          borderColor: serviceColor,
        ),
        Space.h16,
        EmdadgarFilterOptionsBox(cubit: cubit),
      ],
    );
  }
}
