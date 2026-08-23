import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.onChanged,
    this.floatingLabelBehavior,
    this.hintColor,
    this.labelColor,
  });

  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Color? hintColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormFieldWidget(
      hintText: hintText,
      labelText: labelText,
      controller: controller,
      onChanged: onChanged,
      floatingLabelBehavior:
          floatingLabelBehavior ?? FloatingLabelBehavior.always,
      hintColor: hintColor,
      labelColor: labelColor,
      maxLines: 1,
      textInputAction: TextInputAction.search,
      borderColor: colorScheme.onInverseSurface,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          top: AppPadding.p12,
          bottom: AppPadding.p12,
        ),
        child: SvgWidget(
          src: SvgAsset(SvgManager.searchIcon),
          width: AppSize.s22,
          height: AppSize.s22,
          color: colorScheme.onPrimaryFixed,
        ),
      ),
    );
  }
}
