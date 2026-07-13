import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class GradePatternConfirmSheet extends StatelessWidget {
  const GradePatternConfirmSheet({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmTitle = 'حذف',
  });

  final String title;
  final String message;
  final String confirmTitle;
  final Future<void> Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Space.h12,
            Text(message, style: theme.textTheme.bodyMedium),
            Space.h24,
            Row(
              children: [
                Expanded(
                  child: InkwellButtonWidget(
                    title: 'انصراف',
                    backgroundColor: theme.colorScheme.onPrimary,
                    borderColor: theme.colorScheme.outline.withOpacity(0.65),
                    titleColor: theme.colorScheme.onSurface,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                Space.w12,
                Expanded(
                  child: InkwellButtonWidget(
                    title: confirmTitle,
                    backgroundColor: theme.colorScheme.error,
                    onTap: () async {
                      await onConfirm();
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
