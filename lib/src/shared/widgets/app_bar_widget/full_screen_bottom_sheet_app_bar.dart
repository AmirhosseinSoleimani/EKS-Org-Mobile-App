
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
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

    return SizedBox(
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
              child: Text(
                title,
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