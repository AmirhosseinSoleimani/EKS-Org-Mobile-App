import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class NavganActionSheet extends StatelessWidget {
  const NavganActionSheet({
    super.key,
    required this.onAddGrade,
    required this.onAssignServices,
    required this.onVehicleServices,
  });

  final VoidCallback onAddGrade;
  final VoidCallback onAssignServices;
  final VoidCallback onVehicleServices;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p8,
          AppPadding.p16,
          AppPadding.p8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleLargeText(
              text: 'عملیات ناوگان',
              color: theme.colorScheme.onSurface,
              fontSize: AppSize.s18,
            ),
            Space.h16,
            _ActionTile(
              icon: Icons.grading_outlined,
              title: 'الگوی گرید',
              onTap: onAddGrade,
            ),
            _ActionTile(
              icon: Icons.miscellaneous_services_outlined,
              title: 'اختصاص سرویس‌ها',
              onTap: onAssignServices,
            ),
            _ActionTile(
              icon: Icons.car_repair_outlined,
              title: 'ایرادات سرویس خودرو',
              onTap: onVehicleServices,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
          child: Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              Space.w12,
              Expanded(
                child: BodyMediumText(
                  text: title,
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.chevron_left_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
