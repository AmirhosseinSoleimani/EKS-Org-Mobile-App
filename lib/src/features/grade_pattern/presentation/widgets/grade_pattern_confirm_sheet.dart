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
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 6,
              decoration: BoxDecoration(color: Color(0xFFDEC1AF),
              borderRadius: BorderRadius.circular(16)),
            ),
            Space.h24,
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
            Space.h32,
            Column(
              children: [

                InkwellButtonWidget(
                  title: confirmTitle,
                  backgroundColor: theme.colorScheme.error,
                  onTap: () async {
                    await onConfirm();
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
                Space.h12,
                InkwellButtonWidget(
                  title: 'انصراف',
                  backgroundColor: theme.colorScheme.onPrimary,
                  borderColor: Color(0x48626E33),
                  borderWidth: 2,
                  titleColor: Color(0xFF48626E),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
