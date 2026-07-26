import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class ShiftConfirmSheet extends StatelessWidget {
  const ShiftConfirmSheet({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmTitle = 'حذف',
    this.isLoading = false,
  });

  final String title;
  final String message;
  final String confirmTitle;
  final Future<bool> Function() onConfirm;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: AppSize.s32,
              backgroundColor: const Color(0xFFFFDAD6),
              child: Icon(
                Icons.delete_forever_rounded,
                size: AppSize.s32,
                color: theme.colorScheme.error,
              ),
            ),
            Space.h24,
            TitleLargeText(text: title),
            Space.h16,
            BodyMediumText(
              textAlign: TextAlign.center,
              text: message,
              fontSize: 16,
              color: const Color(0xFF574235),
            ),
            Space.h24,
            Row(
              children: [
                Expanded(
                  child: InkwellButtonWidget(
                    title: confirmTitle,
                    backgroundColor: theme.colorScheme.error,
                    titleColor: Colors.white,
                    loadingColor: Colors.white,
                    showLoading: isLoading,
                    onTap: () async {
                      if (isLoading) return;
                      final ok = await onConfirm();
                      if (ok && context.mounted) Navigator.of(context).pop();
                    },
                  ),
                ),
                Space.w12,
                Expanded(
                  child: InkwellButtonWidget(
                    title: 'انصراف',
                    backgroundColor: theme.colorScheme.surface,
                    borderColor: theme.colorScheme.outline,
                    titleColor: theme.colorScheme.onSurface,
                    onTap: isLoading ? null : () => Navigator.of(context).pop(),
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
