import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SelectableCheckItem extends StatelessWidget {
  const SelectableCheckItem({
    super.key,
    required this.title,
    required this.selected,
    this.enabled = true,
    this.onTap,
    this.suffix,
    this.maxWidth = 260,
    this.maxLines = 2,
  });

  final String title;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;
  final Widget? suffix;
  final double maxWidth;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final borderColor = selected ? primary : colorScheme.onInverseSurface;
    final textColor = selected ? primary : colorScheme.onSurface;
    final canTap = enabled && onTap != null;

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p14,
        vertical: AppPadding.p10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s10),
        border: Border.all(
          color: borderColor,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selected) ...[
            Icon(
              Icons.check_circle_outline_rounded,
              color: primary,
              size: AppSize.s18,
            ),
            Space.w8,
          ],
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              title,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          if (suffix != null) ...[
            Space.w8,
            suffix!,
          ],
        ],
      ),
    );

    return Semantics(
      button: canTap,
      selected: selected,
      enabled: enabled,
      child: Material(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s10),
        child: InkWell(
          onTap: canTap ? onTap : null,
          borderRadius: BorderRadius.circular(AppSize.s10),
          child: content,
        ),
      ),
    );
  }
}
