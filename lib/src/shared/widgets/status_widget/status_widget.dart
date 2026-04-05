import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String text;
  final Color color;
  final bool hasBorder;
  final bool hasBackground;

  const StatusWidget({
    super.key,
    required this.text,
    required this.color,
    this.hasBorder = false,
    this.hasBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
          vertical: AppPadding.p6,
        ),
        decoration: BoxDecoration(
          color: hasBackground ? color.withAlpha(20):Colors.transparent,
          borderRadius: BorderRadius.circular(AppSize.s20),
          border: hasBorder
              ? Border.all(color: color.withAlpha(50), width: 1)
              : null,
        ),
        child: Center(
          child: BodySmallText(
            text: text,
            color: color,
            fontSize: AppSize.s10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

