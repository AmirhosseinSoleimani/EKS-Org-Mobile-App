
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class FullScreenBottomSheetAppBar extends StatelessWidget {
  const FullScreenBottomSheetAppBar({
    super.key,
    required this.title,
    required this.onClose,
  });

  final String title;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.colorScheme.onPrimary,
      child: SizedBox(
        height: kToolbarHeight,
        child: Directionality(
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
                child: TitleLargeText(text:
                  title,
                  textAlign: TextAlign.right,
                  fontSize: 17,
                ),
              ),
              Space.w16,
            ],
          ),
        ),
      ),
    );
  }
}