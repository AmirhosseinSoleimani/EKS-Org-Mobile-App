import 'dart:math' as math;

import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.icon = Icons.add_outlined,
  });

  static const double _minWidth = 160;
  static const double _maxWidth = AppSize.s220;

  final VoidCallback onPressed;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: theme.colorScheme.onPrimary,
    );
    final textPainter = TextPainter(
      text: TextSpan(text: title, style: titleStyle),
      maxLines: 1,
      textDirection: Directionality.of(context),
    )..layout();

    final desiredWidth = textPainter.width +
        AppSize.s22 +
        AppSize.s8 +
        (AppPadding.p8 * 2);
    final availableWidth = math
        .max(
          AppSize.s0,
          MediaQuery.sizeOf(context).width - (AppPadding.p16 * 2),
        )
        .toDouble();
    final contentWidth = math
        .max(
          _minWidth,
          math.min(_maxWidth, desiredWidth),
        )
        .toDouble();
    final effectiveWidth = math.min(availableWidth, contentWidth).toDouble();

    return InkwellButtonWidget(
      onTap: onPressed,
      borderRadius: AppSize.s150,
      width: effectiveWidth,
      textStyle: titleStyle,
      titleMaxLines: 1,
      titleOverflow: TextOverflow.ellipsis,
      prefixIcon: Icon(
        icon,
        color: theme.colorScheme.onPrimary,
        size: AppSize.s22,
      ),
      title: title,
    );
  }
}
