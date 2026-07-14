import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
class DropDownMapItemsWidget extends StatelessWidget {
  final Map<String, int> items;
  final ValueChanged<String> onChange;
  final String labelText;
  final String? initialValue;
  final bool? mandatory;

  const DropDownMapItemsWidget({
    super.key,
    required this.items,
    required this.onChange,
    required this.labelText,
    required this.initialValue,
    this.mandatory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selectedValueNotifier = ValueNotifier<String>(
      initialValue ?? items.keys.first,
    );

    final borderRadius = BorderRadius.circular(AppSize.s8);

    final borderSide = const BorderSide(
      color: ColorLightManager.onSecondaryFixed,
      width: AppSize.s1,
    );

    return SizedBox(
      height: AppSize.s60,
      child: ValueListenableBuilder<String>(
        valueListenable: selectedValueNotifier,
        builder: (context, selectedValue, child) {
          return  DropdownButtonFormField<String>(
            initialValue: selectedValue,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: (mandatory ?? false)
                  ? '$labelText *'
                  : labelText,
              hintText: 'یک گزینه را انتخاب کنید',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
                vertical: AppPadding.p16,
              ),
              labelStyle: theme.textTheme.displayMedium?.copyWith(
                fontSize: AppSize.s16,
              ),
              border: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: borderSide,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: borderSide,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 1.5,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: borderSide,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsetsDirectional.only(
                end: AppPadding.p8,
              ),
              child: Icon(
                Icons.arrow_drop_down,
                size: AppSize.s20,
                color: theme.colorScheme.onTertiary,
              ),
            ),
            selectedItemBuilder: (context) {
              return items.keys.map((key) {
                return Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.p8,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      key,
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontSize: AppSize.s14,
                      ),
                    ),
                  ),
                );
              }).toList();
            },
            items: items.keys.map((key) {
              return DropdownMenuItem<String>(
                value: key,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppPadding.p8,
                  ),
                  child: Text(
                    key,
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontSize: AppSize.s14,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value == null) return;

              selectedValueNotifier.value = value;
              onChange(value);
            },
          );
        },
      ),
    );
  }
}
