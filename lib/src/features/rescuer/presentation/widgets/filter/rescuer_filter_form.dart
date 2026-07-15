import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/list/rescuer_list_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RescuerFilterForm extends StatelessWidget {
  final RescuerListCubit cubit;
  final VoidCallback onApply;
  final VoidCallback onClear;

  const RescuerFilterForm({
    super.key,
    required this.cubit,
    required this.onApply,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BodyMediumText(
            text: 'فیلتر امدادرسان‌ها',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          const SizedBox(height: 20),
          TextFormFieldWidget(
            labelText: 'نام و نام خانوادگی',
            controller: cubit.nameController,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 12),
          TextFormFieldWidget(
            labelText: 'کد ملی',
            controller: cubit.nationalNumberController,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 10,
            textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 12),
          TextFormFieldWidget(
            labelText: 'شماره همراه',
            controller: cubit.mobileController,
            textInputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 12),
          TextFormFieldWidget(
            labelText: 'کد پرسنلی',
            controller: cubit.codeController,
            textInputAction: TextInputAction.done,
          ),
          SubmitCancelButtons(
            submitTitle: 'اعمال فیلتر',
            submitButtonColor: Theme.of(context).colorScheme.primary,
            cancelTitle: 'پاک کردن',
            onSubmit: onApply,
            onCancel: onClear,
          ),
        ],
      ),
    );
  }
}
