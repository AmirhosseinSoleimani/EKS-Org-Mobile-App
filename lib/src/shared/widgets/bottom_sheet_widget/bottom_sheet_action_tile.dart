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
    final effectiveColor = enabled ? color : color.withOpacity(0.45);

    return SizedBox(
      height: AppSize.s48,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: AppPadding.p0,
        minLeadingWidth: AppSize.s24,
        horizontalTitleGap: AppSize.s12,
        leading: SizedBox.square(
          dimension: AppSize.s24,
          child: isLoading
              ? CircularProgressIndicator(
                  strokeWidth: AppSize.s2,
                  color: effectiveColor,
                )
              : Icon(
                  icon,
                  color: effectiveColor,
                  size: AppSize.s24,
                ),
        ),
        title: BodyMediumText(
          text: title,
          color: effectiveColor,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.start,
        ),
        onTap: enabled && !isLoading ? onTap : null,
      ),
    );
  }
}
