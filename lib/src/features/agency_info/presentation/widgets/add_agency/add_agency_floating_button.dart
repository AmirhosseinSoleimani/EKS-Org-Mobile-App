import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AddAgencyFloatingButton extends StatelessWidget {
  const AddAgencyFloatingButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FloatingActionButton.extended(
      heroTag: 'add-agency-floating-button',
      elevation: 0,
      highlightElevation: 0,
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s24),
      ),
      onPressed: onPressed,
      icon: const Icon(Icons.add_rounded, size: AppSize.s22),
      label: Text(
        'نمایندگی جدید',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
