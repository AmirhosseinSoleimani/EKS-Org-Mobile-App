import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkwellButtonWidget(
      onTap: onPressed,
      borderRadius: 150,
      width: 160,
      prefixIcon: Icon(
        Icons.add_rounded,
        color: theme.colorScheme.onPrimary,
        size: AppSize.s22,
      ),
      title: 'نمایندگی جدید',
    );
  }
}
