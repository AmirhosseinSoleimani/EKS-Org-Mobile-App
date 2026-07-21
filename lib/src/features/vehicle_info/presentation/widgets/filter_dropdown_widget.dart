import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class FilterDropdownWidget<T> extends StatelessWidget {
  const FilterDropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T?>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final borderRadius = BorderRadius.circular(
      AppSize.s8,
    );

    final textStyle = theme.textTheme.bodyMedium?.copyWith(
      fontSize: AppSize.s14,
      color: colorScheme.onSurface,
    );

    return SizedBox(
      height: AppSize.s60,
      child: DropdownButtonFormField<T?>(
        value: value,
        isExpanded: true,

        style: textStyle,

        decoration: InputDecoration(
          filled: true,
          fillColor: colorScheme.onPrimary,

          labelText: label,

          labelStyle: theme.textTheme.labelMedium?.copyWith(
            fontSize: AppSize.s14,
            color: colorScheme.onSurface,
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8,
            vertical: AppPadding.p16,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              width: AppSize.s1,
              color: colorScheme.inverseSurface,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              width: AppSize.s1,
              color: colorScheme.primary,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              width: AppSize.s1,
              color: colorScheme.error,
            ),
          ),
        ),

        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: AppSize.s24,
          color: colorScheme.onTertiary,
        ),

        items: items.map(
              (item) {
            return DropdownMenuItem<T?>(
              value: item.value,
              child: DefaultTextStyle(
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: AppSize.s14,
                  color: colorScheme.onSurface,
                ) ??
                    const TextStyle(),
                child: item.child,
              ),
            );
          },
        ).toList(),

        onChanged: onChanged,
      ),
    );
  }
}