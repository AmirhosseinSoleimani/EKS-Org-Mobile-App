import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class BottomSheetActionTile extends StatelessWidget {
  const BottomSheetActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
    this.isLoading = false,
    this.enabled = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDestructive
        ? theme.colorScheme.error
        : theme.colorScheme.onPrimaryFixed;
    final effectiveColor =
        enabled || isLoading ? color : color.withOpacity(0.45);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: SizedBox(
          width: AppSize.s24,
          height: AppSize.s24,
          child: isLoading
              ? CircularProgressIndicator(
                  strokeWidth: 2,
                  color: effectiveColor,
                )
              : Icon(icon, color: effectiveColor, size: AppSize.s24),
        ),
        title: BodyMediumText(
          text: title,
          color: effectiveColor,
          fontWeight: FontWeight.w700,
        ),
        onTap: () {
          if (!enabled || isLoading) return;
          onTap();
        },
      ),
    );
  }
}
