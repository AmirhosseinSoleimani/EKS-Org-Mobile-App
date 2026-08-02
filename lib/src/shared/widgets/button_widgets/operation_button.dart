import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class OperationButton extends StatelessWidget {
  const OperationButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkwellButtonWidget(
      title: 'عملیات',
      backgroundColor: colorScheme.secondaryContainer,
      titleColor: colorScheme.onTertiaryFixed,
      showLoading: isLoading,
      suffixIcon: Icon(
        Icons.keyboard_arrow_down,
        color: colorScheme.onTertiaryFixed,
      ),
      prefixIcon: Icon(
        Icons.settings_outlined,
        color: colorScheme.onTertiaryFixed,
        size: AppSize.s20,
      ),
      onTap: onTap,
    );
  }
}
