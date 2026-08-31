import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class KeyValueRow extends StatelessWidget {
  final Widget? leadingWidget;
  final String label;
  final String value;
  final bool boldLabel;
  final bool boldValue;
  final double? labelFontSize;
  final double? valueFontSize;
  final MainAxisAlignment mainAxisAlignment;
  final double maxValueWidthFactor;

  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.boldLabel = false,
    this.boldValue = false,
    this.labelFontSize,
    this.valueFontSize,
    this.leadingWidget,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.maxValueWidthFactor = 0.75,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseFontSize =
        theme.textTheme.bodySmall?.fontSize ?? AppSize.s12;
    final defaultFontSize = baseFontSize + AppSize.s2;

    final resolvedLabelFontSize =
        labelFontSize ?? defaultFontSize;
    final resolvedValueFontSize =
        valueFontSize ?? defaultFontSize;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p4,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxValueWidth =
              constraints.maxWidth * maxValueWidthFactor;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (leadingWidget != null) ...[
                      leadingWidget!,
                      Space.w4,
                    ],
                    Flexible(
                      child: BodySmallText(
                        text: label,
                        textAlign: TextAlign.start,
                        fontWeight: boldLabel
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: resolvedLabelFontSize,
                      ),
                    ),
                  ],
                ),
              ),
              Space.w8,
              const Spacer(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxValueWidth,
                ),
                child: BodySmallText(
                  text: value,
                  textAlign: TextAlign.end,
                  fontWeight: boldValue
                      ? FontWeight.bold
                      : FontWeight.normal,
                  fontSize: resolvedValueFontSize,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}