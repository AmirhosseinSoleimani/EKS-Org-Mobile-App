
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LabeledCheckboxRow extends StatelessWidget {
  final String title;
  final ValueNotifier<bool> notifier;
  final Color activeColor;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry padding;
  final double checkboxScale;
  final bool enabled;

  const LabeledCheckboxRow({
    super.key,
    required this.title,
    required this.notifier,
    required this.activeColor,
    this.titleStyle,
    this.padding = const EdgeInsets.symmetric(vertical: AppSize.s4),
    this.checkboxScale = 1.12,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (context, value, _) {
        return InkWell(
          onTap: enabled ? () => notifier.value = !value : null,
          borderRadius: BorderRadius.circular(AppSize.s8),
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                Transform.scale(
                  scale: checkboxScale,
                  child: Checkbox(
                    value: value,
                    onChanged: enabled
                        ? (newValue) {
                      notifier.value = newValue ?? false;
                    }
                        : null,

                    activeColor: Colors.transparent,
                    checkColor: activeColor,

                    fillColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.transparent;
                        }

                        return Colors.transparent;
                      },
                    ),

                    side: WidgetStateBorderSide.resolveWith(
                          (states) {
                        final color = states.contains(WidgetState.selected)
                            ? activeColor
                            : Colors.grey.shade400;

                        return BorderSide(
                          color: color,
                          width: 1,
                        );
                      },
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s4),
                    ),

                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),

                Space.w8,

                Expanded(
                  child: Text(
                    title,
                    style: titleStyle ??
                        theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}