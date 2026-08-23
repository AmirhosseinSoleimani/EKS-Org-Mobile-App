import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/ek_dropdown.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAgencyTextField extends StatelessWidget {
  const AddAgencyTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.mandatory = false,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines,
    this.prefixIcon,
    this.textDirection,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool mandatory;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final Widget? prefixIcon;
  final TextDirection? textDirection;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: controller,
      labelText: label,
      hintText: hint,
      mandatory: mandatory,
      textInputType: keyboardType,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      textInputFormatter: inputFormatters,
      maxLines: maxLines,
      prefixIcon: prefixIcon,
      textDirection: textDirection,
      textAlign: textDirection == TextDirection.ltr ? TextAlign.left : null,
      textInputAction: maxLines == null || maxLines == 1
          ? TextInputAction.next
          : TextInputAction.newline,
      validator: validator,
    );
  }
}

class AddAgencyDropDown extends StatelessWidget {
  const AddAgencyDropDown({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.selectedTitle,
    this.placeholder = 'انتخاب کنید',
    this.mandatory = false,
    this.onTap,
  });

  final String label;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final String? selectedTitle;
  final String placeholder;
  final bool mandatory;
  final VoidCallback? onTap;

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
      onTap: onTap,
    );
  }
}
