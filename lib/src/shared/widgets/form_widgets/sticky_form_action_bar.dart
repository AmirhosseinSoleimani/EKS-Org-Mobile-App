import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class StickyFormActionBar extends StatelessWidget {
  const StickyFormActionBar({
    super.key,
    required this.submitTitle,
    required this.cancelTitle,
    required this.onSubmit,
    required this.onCancel,
    this.isSubmitting = false,
  });

  final String submitTitle;
  final String cancelTitle;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p12,
          AppPadding.p16,
          AppPadding.p16,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.08),
              blurRadius: AppSize.s16,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: InkwellButtonWidget(
                title: submitTitle,
                showLoading: isSubmitting,
                onTap: () {
                  if (isSubmitting) return;
                  onSubmit?.call();
                },
                borderRadius: AppSize.s8,
              ),
            ),
            Space.w12,
            Flexible(
              flex: 2,
              child: InkwellButtonWidget(
                title: cancelTitle,
                onTap: () {
                  if (isSubmitting) return;
                  onCancel?.call();
                },
                backgroundColor: theme.colorScheme.onPrimary,
                borderColor: Colors.transparent,
                titleColor: theme.colorScheme.onSurface,
                borderRadius: AppSize.s8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
