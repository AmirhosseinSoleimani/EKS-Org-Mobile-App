import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final radius = BorderRadius.circular(AppSize.s12);

    return Material(
      color: colorScheme.onPrimary,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          height: AppSize.s54,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: AppSize.s24,
                color: colorScheme.outline,
              ),
              Space.w12,
              Expanded(
                child: BodyMediumText(
                  text: title,
                  fontSize: AppSize.s16,
                  color: colorScheme.onSurface,
                ),
              ),
              Icon(
                CupertinoIcons.chevron_left,
                size: AppSize.s20,
                color: colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
