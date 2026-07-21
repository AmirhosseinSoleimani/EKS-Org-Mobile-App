import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AppCheckboxWidget extends StatelessWidget {
  const AppCheckboxWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.size = 20,
    this.padding = const EdgeInsets.symmetric(vertical: AppPadding.p6),
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;
  final double size;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final disabledColor = colorScheme.onSurface.withOpacity(0.38);
    final borderColor = enabled
        ? colorScheme.onSurfaceVariant.withOpacity(0.55)
        : disabledColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? () => onChanged(!value) : null,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              Semantics(
                checked: value,
                enabled: enabled,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: value
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHighest.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(AppSize.s6),
                    border: Border.all(
                      color: value ? colorScheme.primary : borderColor,
                      width: 1.2,
                    ),
                  ),
                  child: value
                      ? Icon(
                    Icons.check_rounded,
                    size: size - 7,
                    color: colorScheme.onPrimary,
                  )
                      : null,
                ),
              ),
              Space.w12,
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: enabled ? colorScheme.onSurface : disabledColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
