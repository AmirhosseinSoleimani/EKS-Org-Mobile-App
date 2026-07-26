import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ShiftDropdownField<T> extends StatelessWidget {
  const ShiftDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.mandatory = false,
    this.hintText = 'انتخاب کنید',
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final bool mandatory;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonFormField<T>(
      value: value,
      isExpanded: true,
      items: items,
      onChanged: items.isEmpty ? null : onChanged,
      validator: validator,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: AppSize.s22),
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: label),
              if (mandatory)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
            ],
          ),
        ),
        hintText: items.isEmpty ? 'موردی یافت نشد' : hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        fillColor: theme.colorScheme.onPrimary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
          vertical: AppPadding.p14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
      ),
      style: theme.textTheme.bodyMedium,
    );
  }

  static DropdownMenuItem<T> item<T>(T value, String text) {
    return DropdownMenuItem<T>(
      value: value,
      child: Text(text, overflow: TextOverflow.ellipsis),
    );
  }
}
