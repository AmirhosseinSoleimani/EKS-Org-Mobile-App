import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: AppSize.s80,
      height: AppSize.s80,
      padding: const EdgeInsets.all(AppPadding.p4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.onPrimary,
        border: Border.all(
          color: colorScheme.surfaceTint.withOpacity(0.7),
          width: AppSize.s1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.onPrimary,
              colorScheme.inverseSurface,
              colorScheme.surfaceTint,
            ],
          ),
          border: Border.all(
            color: colorScheme.onPrimaryFixed.withOpacity(0.55),
            width: AppSize.s2,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: const Alignment(0, -0.15),
              radius: 0.9,
              colors: [
                colorScheme.onPrimary,
                colorScheme.onSecondaryFixed,
                colorScheme.surfaceTint,
              ],
            ),
          ),
          child: Icon(
            Icons.person_rounded,
            size: AppSize.s48,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
