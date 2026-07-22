import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class SelectableCheckItem extends StatelessWidget {
  final String title;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;
  final Widget? suffix;
  final double maxWidth;

  const SelectableCheckItem({
    super.key,
    required this.title,
    required this.selected,
    this.enabled = true,
    this.onTap,
    this.suffix,
    this.maxWidth = 260,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final borderColor = selected ? primary : colorScheme.onInverseSurface;
    final textColor = selected ? primary : colorScheme.onSurface;

    final child = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: IntrinsicWidth(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                Icon(Icons.check_circle_outline, color: primary, size: 18),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: BodyMediumText(
                  text: title,
                  color: textColor,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: 8),
                suffix!,
              ],
            ],
          ),
        ),
      ),
    );

    if (!enabled || onTap == null) {
      return child;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: child,
      ),
    );
  }
}