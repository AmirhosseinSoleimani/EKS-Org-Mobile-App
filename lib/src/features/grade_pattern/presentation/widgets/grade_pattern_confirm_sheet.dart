import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class GradePatternConfirmSheet extends StatelessWidget {
  const GradePatternConfirmSheet({
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
  final Future<void> Function() onConfirm;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: AppSize.s32,
              backgroundColor: Color(0xFFFFDAD6),
              child: Icon(
                Icons.delete_forever_rounded,
                size: AppSize.s32,
                color: theme.colorScheme.error,
              ),
            ),
            Space.h32,
            TitleLargeText(text: title),
            Space.h24,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BodyMediumText(
                textAlign: TextAlign.center,
                text: message,fontSize: 16,color: Color(0xFF574235),),
            ),
            Space.h24,
            Row(
              children: [

                Expanded(
                  child: InkwellButtonWidget(
                    title: 'حذف',
                    backgroundColor: theme.colorScheme.error,
                    titleColor: Colors.white,
                    loadingColor: Colors.white,
                    showLoading: isLoading,
                    onTap: () async {
                      if (isLoading) return;
                      if (context.mounted) Navigator.of(context).pop();
                      await onConfirm();
                    },
                  ),
                ),
                Space.w12,
                Expanded(
                  child: InkwellButtonWidget(
                    title: 'بستن',
                    backgroundColor: theme.colorScheme.surface,
                    borderColor: theme.colorScheme.outline,
                    titleColor: theme.colorScheme.onSurface,
                    onTap: isLoading
                        ? null
                        : () => Navigator.of(context).pop(),
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
