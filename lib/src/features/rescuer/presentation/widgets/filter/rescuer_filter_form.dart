import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/list/rescuer_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_bottom_sheet_scaffold.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RescuerFilterForm extends StatelessWidget {
  const RescuerFilterForm({
    super.key,
    required this.cubit,
    required this.onApply,
    required this.onClear,
  });

  final RescuerListCubit cubit;
  final VoidCallback onApply;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return FilterBottomSheetScaffold(
      title: 'فیلترها',
      onApply: onApply,
      onClear: onClear,
      child: Column(
        children: [
          TextFormFieldWidget(
            labelText: 'نام و نام خانوادگی',
            controller: cubit.nameController,
            textInputAction: TextInputAction.next,
          ),
          Space.h12,
          TextFormFieldWidget(
            labelText: 'کد ملی',
            controller: cubit.nationalNumberController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 10,
            textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
          ),
          Space.h12,
          TextFormFieldWidget(
            labelText: 'شماره همراه',
            controller: cubit.mobileController,
            textInputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
          ),
          Space.h12,
          TextFormFieldWidget(
            labelText: 'کد پرسنلی',
            controller: cubit.codeController,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
