import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/input_formatter/persian_arabic_digits_to_english_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/switch_widgets/labeled_switch_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpecialPlanPrioritySection extends StatelessWidget {
  const SpecialPlanPrioritySection({
    super.key,
    required this.orderController,
    required this.hasHighPriority,
    required this.onlySaipaCars,
    required this.onHighPriorityChanged,
    required this.onOnlySaipaCarsChanged,
  });

  final TextEditingController orderController;
  final bool hasHighPriority;
  final bool onlySaipaCars;
  final ValueChanged<bool> onHighPriorityChanged;
  final ValueChanged<bool> onOnlySaipaCarsChanged;

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SpecialPlanSectionHeader(
            title: 'اولویت‌بندی',
            icon: Icons.format_list_numbered_rtl,
          ),
          Space.h20,
          TextFormFieldWidget(
            controller: orderController,
            labelText: 'شماره اولویت',
            textInputType: TextInputType.number,
            textInputFormatter: [
              PersianArabicDigitsToEnglishFormatter(),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          Space.h16,
          LabeledSwitchField(
            label: 'اولویت بالا',
            value: hasHighPriority,
            onChanged: onHighPriorityChanged,
          ),
          Space.h8,
          LabeledSwitchField(
            label: 'فقط خودروهای سایپایی',
            value: onlySaipaCars,
            onChanged: onOnlySaipaCarsChanged,
          ),
        ],
      ),
    );
  }
}
