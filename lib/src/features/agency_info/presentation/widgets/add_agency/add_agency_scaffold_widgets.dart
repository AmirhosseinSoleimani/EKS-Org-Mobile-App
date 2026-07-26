import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class AddAgencyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddAgencyAppBar({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: theme.colorScheme.onPrimary,
      titleSpacing: 0,
      title: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            IconButton(
              onPressed: onClose,
              icon: Icon(
                Icons.close_rounded,
                color: theme.colorScheme.onPrimaryFixedVariant,
              ),
            ),
            Expanded(
              child: Text(
                'افزودن نمایندگی',
                textAlign: TextAlign.right,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Space.w16,
          ],
        ),
      ),
    );
  }
}

class AddAgencyInitialLoadError extends StatelessWidget {
  const AddAgencyInitialLoadError({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: theme.colorScheme.error,
              size: AppSize.s40,
            ),
            Space.h16,
            Text(
              'آماده‌سازی فرم با خطا مواجه شد.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            Space.h16,
            InkwellButtonWidget(
              title: 'تلاش مجدد',
              width: AppSize.s150,
              onTap: onRetry,
              backgroundColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
