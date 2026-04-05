import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class DropDownListItemsWidget extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onChange;
  final String labelText;
  final String? initialValue;
  final bool? mandatory;

  const DropDownListItemsWidget(
      {super.key,
      required this.items,
      required this.onChange,
      required this.labelText,
      required this.initialValue,
      this.mandatory});

  @override
  State<DropDownListItemsWidget> createState() =>
      _DropDownListItemsWidgetState();
}

class _DropDownListItemsWidgetState extends State<DropDownListItemsWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s60,
      child: DropdownButtonFormField<String>(
        dropdownColor: ColorLightManager.surfaceBright,
        value: selectedValue ?? 'لطفا یک گزینه را انتخاب کنید',
        decoration: InputDecoration(
          labelText: (widget.mandatory ?? false)
              ? "${widget.labelText} *"
              : widget.labelText,
          hintText: 'یک گزینه را انتخاب کنید',
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p8, vertical: AppPadding.p16),
          hintStyle:
              const TextStyle(fontSize: 14.0, color: ColorLightManager.shadow),
          labelStyle:
              const TextStyle(fontSize: 14.0, color: ColorLightManager.shadow),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: const BorderSide(
                color: ColorLightManager.onTertiaryFixed, width: AppSize.s1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: const BorderSide(
                color: ColorLightManager.onTertiaryFixed, width: AppSize.s1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderSide: const BorderSide(
                color: ColorLightManager.onTertiaryFixed, width: AppSize.s1),
          ),
        ),
        isExpanded: true,
        icon: const Icon(
          IconManager.arrowDown,
          size: AppSize.s20,
          color: ColorLightManager.primaryContainer,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        items: widget.items.map((key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 14.0, color: ColorLightManager.shadow)),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selectedValue = value;
            });
            widget.onChange(value);
          }
        },
      ),
    );
  }
}
