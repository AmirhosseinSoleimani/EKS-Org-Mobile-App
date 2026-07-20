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

class AddAgencyBottomActions extends StatelessWidget {
  const AddAgencyBottomActions({
    super.key,
    required this.isSubmitting,
    required this.onCancel,
    required this.onSubmit,
  });

  final bool isSubmitting;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p8,
          AppPadding.p16,
          AppPadding.p12,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: TextButton(
                onPressed: isSubmitting ? null : onCancel,
                child: Text(
                  'انصراف',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryFixed,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Space.w12,
            Expanded(
              flex: 5,
              child: InkwellButtonWidget(
                title: 'افزودن',
                showLoading: isSubmitting,
                onTap: onSubmit,
                backgroundColor: theme.colorScheme.primary,
                borderRadius: AppSize.s8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
