import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VehicleInfoFormTextField extends StatelessWidget {
  const VehicleInfoFormTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.mandatory = false,
    this.readOnly = false,
    this.keyboardType,
    this.inputFormatters,
    this.suffixIcon,
    this.onTap,
    this.textDirection,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool mandatory;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final TextDirection? textDirection;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: controller,
      labelText: label,
      hintText: hint,
      mandatory: mandatory,
      readOnly: readOnly,
      textInputType: keyboardType,
      textInputFormatter: inputFormatters,
      suffixIcon: suffixIcon,
      onTap: onTap,
      textDirection: textDirection,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      textInputAction: TextInputAction.next,
      validator: validator,
    );
  }
}

class VehicleInfoFormDropDown extends StatelessWidget {
  const VehicleInfoFormDropDown({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.selectedTitle,
    this.placeholder = 'انتخاب کنید',
    this.mandatory = false,
  });

  final String label;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final String? selectedTitle;
  final String placeholder;
  final bool mandatory;

  @override
  Widget build(BuildContext context) {
    final safeItems = items.isEmpty ? [placeholder] : items;
    final selectedItem = safeItems.contains(selectedTitle)
        ? selectedTitle
        : safeItems.first;

    return EkDropDown(
      safeItems,
      key: ValueKey(
        '$label|$selectedItem|${safeItems.length}|'
        '${safeItems.first}|${safeItems.last}',
      ),
      label: label,
      mandatory: mandatory,
      selectedItem: selectedItem,
      onItemValue: onChanged,
    );
  }
}

class VehicleInfoFormCheckBox extends StatelessWidget {
  const VehicleInfoFormCheckBox({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s8),
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          Checkbox(
            value: value,
            activeColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s4),
            ),
            onChanged: (checked) => onChanged(checked ?? false),
          ),
          Space.w8,
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
