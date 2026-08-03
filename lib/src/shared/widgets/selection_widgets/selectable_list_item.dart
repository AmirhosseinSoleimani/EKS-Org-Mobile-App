import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SelectableListItem extends StatelessWidget {
  const SelectableListItem({
    super.key,
    required this.title,
    required this.selected,
    this.enabled = true,
    this.onTap,
    this.suffix,
  });

  final String title;
  final bool selected;
  final bool enabled;
  final VoidCallback? onTap;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = colorScheme.primary;
    final canTap = enabled && onTap != null;

    return Semantics(
      button: canTap,
      selected: selected,
      enabled: enabled,
      child: Material(
        color: selected
            ? primary.withAlpha(18)
            : colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s10),
        child: InkWell(
          onTap: canTap ? onTap : null,
          borderRadius: BorderRadius.circular(AppSize.s10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            constraints: const BoxConstraints(minHeight: AppSize.s60),
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppPadding.p12,
              AppPadding.p10,
              AppPadding.p14,
              AppPadding.p10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10),
              border: Border.all(
                color: selected
                    ? primary.withAlpha(80)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                _SelectionBox(selected: selected, enabled: enabled),
                Space.w12,
                Expanded(
                  child: Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: selected ? primary : colorScheme.onSurface,
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
                if (suffix != null) ...[
                  Space.w8,
                  suffix!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectionBox extends StatelessWidget {
  const _SelectionBox({
    required this.selected,
    required this.enabled,
  });

  final bool selected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;
    final disabledColor = colorScheme.onSurface.withOpacity(0.32);
    final color = enabled ? primary : disabledColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: AppSize.s24,
      height: AppSize.s24,
      decoration: BoxDecoration(
        color: selected ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSize.s6),
        border: Border.all(color: color, width: 1.2),
      ),
      child: selected
          ? Icon(
              Icons.check_rounded,
              size: AppSize.s18,
              color: colorScheme.onPrimary,
            )
          : null,
    );
  }
}
