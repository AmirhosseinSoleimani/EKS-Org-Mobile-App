import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class EmdadUnitActionSheet extends StatelessWidget {
  const EmdadUnitActionSheet({
    super.key,
    required this.onEditImage,
    required this.onChangeLocation,
    required this.onPersons,
    required this.onGradePatterns,
    required this.onDelete,
  });

  final VoidCallback onEditImage;
  final VoidCallback onChangeLocation;
  final VoidCallback onPersons;
  final VoidCallback onGradePatterns;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p24,
          AppPadding.p8,
          AppPadding.p24,
          AppPadding.p24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSize.s60,
              height: AppSize.s4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onInverseSurface,
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
            ),
            Space.h20,
            _ActionTile(
              icon: Icons.group_outlined,
              title: 'امدادرسان‌ها',
              onTap: onPersons,
            ),
            Divider(
              height: AppSize.s1,
              thickness: AppSize.s1,
              color: theme.colorScheme.onInverseSurface,
            ),
            _ActionTile(
              icon: Icons.grading_outlined,
              title: 'الگوی گرید',
              onTap: onGradePatterns,
            ),
            Divider(
              height: AppSize.s1,
              thickness: AppSize.s1,
              color: theme.colorScheme.onInverseSurface,
            ),
            _ActionTile(
              icon: Icons.bus_alert_outlined,
              title: 'تغییر محل استقرار',
              onTap: onChangeLocation,
            ),
            Divider(
              height: AppSize.s1,
              thickness: AppSize.s1,
              color: theme.colorScheme.onInverseSurface,
            ),
        /*    _ActionTile(
              icon: Icons.image_outlined,
              title: 'ویرایش تصویر',
              onTap: onEditImage,
            ),*/
            Divider(
              height: AppSize.s1,
              thickness: AppSize.s1,
              color: theme.colorScheme.onInverseSurface,
            ),
            _ActionTile(
              icon: Icons.delete_outlined,
              title: 'حذف',
              isDestructive: true,
              onTap: onDelete,
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
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDestructive ? theme.colorScheme.error : theme.colorScheme.onPrimaryFixed;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color, size: AppSize.s24),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }
}
