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

  const DropDownMapItemsWidget(
      {super.key,
      required this.items,
      required this.onChange,
      required this.labelText,
      required this.initialValue,
      this.mandatory});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedValueNotifier = ValueNotifier<String>(
      initialValue ?? items.keys.first,
    );
    return SizedBox(
      height: AppSize.s60,
      child: ValueListenableBuilder<String>(
        valueListenable: selectedValueNotifier,
        builder: (context, selectedValue, child) {
          return DropdownButtonFormField<String>(
            initialValue: selectedValue,
            decoration: InputDecoration(
              labelText: (mandatory ?? false) ? "$labelText *" : labelText,
              hintText: 'یک گزینه را انتخاب کنید',
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p8, vertical: AppPadding.p16),
              labelStyle: theme.textTheme.displayMedium
                  ?.copyWith(fontSize: AppSize.s16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s8),
                borderSide: const BorderSide(
                    color: ColorLightManager.onTertiaryFixed,
                    width: AppSize.s1),
              ),
            ),
            isExpanded: true,
            icon: Icon(
              IconManager.arrowDown,
              size: AppSize.s20,
              color: Theme.of(context).colorScheme.onTertiary,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            items: items.keys.map((key) {
              return DropdownMenuItem<String>(
                value: key,
                child: Text(key,
                    style: theme.textTheme.displayMedium
                        ?.copyWith(fontSize: AppSize.s14)),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                selectedValueNotifier.value = value;
                onChange(value);
              }
            },
          );
        },
      ),
    );
  }
}
