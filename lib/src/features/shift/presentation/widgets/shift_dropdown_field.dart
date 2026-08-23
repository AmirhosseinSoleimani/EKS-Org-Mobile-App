import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ShiftDropdownField<T> extends StatefulWidget {
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
  State<ShiftDropdownField<T>> createState() => _ShiftDropdownFieldState<T>();

  static DropdownMenuItem<T> item<T>(T value, String text) {
    return DropdownMenuItem<T>(
      value: value,
      child: Text(text, overflow: TextOverflow.ellipsis),
    );
  }
}

class _ShiftDropdownFieldState<T> extends State<ShiftDropdownField<T>> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final labelColor = _isFocused ? colorScheme.primary : colorScheme.onSurface;

    return Focus(
      onFocusChange: (value) {
        if (_isFocused == value) return;
        setState(() => _isFocused = value);
      },
      child: DropdownButtonFormField<T>(
        value: widget.value,
        isExpanded: true,
        items: widget.items,
        onChanged: widget.items.isEmpty ? null : widget.onChanged,
        validator: widget.validator,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: AppSize.s22,
          color: colorScheme.onPrimaryFixed,
        ),
        decoration: InputDecoration(
          label: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: labelColor,
                  ),
                ),
                if (widget.mandatory)
                  TextSpan(
                    text: ' *',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          hintText: widget.items.isEmpty ? 'موردی یافت نشد' : widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: colorScheme.onPrimary,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p12,
            vertical: AppPadding.p14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(color: colorScheme.inverseSurface),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(color: colorScheme.inverseSurface),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(color: colorScheme.inverseSurface),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(color: colorScheme.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(color: colorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: BorderSide(color: colorScheme.error),
          ),
        ),
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
