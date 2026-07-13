import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class EmdadUnitConfirmSheet extends StatelessWidget {
  const EmdadUnitConfirmSheet({
    super.key,
    required this.title,
    required this.message,
    required this.confirmTitle,
    required this.onConfirm,
    this.isSubmitting = false,
  });

  final String title;
  final String message;
  final String confirmTitle;
  final Future<void> Function() onConfirm;
  final bool isSubmitting;

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
              width: AppSize.s40,
              height: AppSize.s4,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.28),
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
            ),
            Space.h24,
            Container(
              width: AppSize.s64,
              height: AppSize.s64,
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withOpacity(0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_forever_outlined,
                color: theme.colorScheme.error,
                size: AppSize.s34,
              ),
            ),
            Space.h24,
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Space.h12,
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.8,
              ),
            ),
            Space.h24,
            InkwellButtonWidget(
              title: confirmTitle,
              backgroundColor: theme.colorScheme.error,
              showLoading: isSubmitting,
              onTap: isSubmitting ? null : () => onConfirm(),
            ),
            Space.h12,
            InkwellButtonWidget(
              title: 'انصراف',
              backgroundColor: theme.colorScheme.onPrimary,
              borderColor: theme.colorScheme.outlineVariant.withOpacity(0.28),
              titleColor: theme.colorScheme.onSurface,
              onTap: isSubmitting ? null : () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
  }
}
