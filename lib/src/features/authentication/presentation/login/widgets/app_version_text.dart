import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class AppVersionTextWidget extends StatelessWidget {
  const AppVersionTextWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'نسخه برنامه: ',
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.surfaceTint),
        ),
        Text(AppConstants.currentAppVersion, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
