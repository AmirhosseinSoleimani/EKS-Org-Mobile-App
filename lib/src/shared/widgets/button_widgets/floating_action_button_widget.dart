import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key, required this.onPressed,
  required this.title, this.icon = Icons.add_rounded
  });

  final VoidCallback onPressed;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkwellButtonWidget(
      onTap: onPressed,
      borderRadius: 150,
      width: 160,
      prefixIcon: Icon(
        Icons.add_outlined,
        color: theme.colorScheme.onPrimary,
        size: AppSize.s22,
      ),
      title: title,
    );
  }
}
