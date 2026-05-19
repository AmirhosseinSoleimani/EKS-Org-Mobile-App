
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class FilterCheckboxRow extends StatelessWidget {
  final String title;
  final ValueNotifier<bool> notifier;
  final ServiceType serviceType;

  const FilterCheckboxRow({super.key,
    required this.title,
    required this.notifier,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final Color checkColor = serviceType.serviceColor;

    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (context, value, _) {
        return InkWell(
          onTap: () {
            notifier.value = !value;
          },
          borderRadius: BorderRadius.circular(AppSize.s8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.s4),
            child: Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: (newValue) {
                    notifier.value = newValue ?? false;
                  },

                  checkColor: checkColor,

                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    return colorScheme.surface;
                  }),

                  side: WidgetStateBorderSide.resolveWith((states) {
                    return BorderSide(color: Colors.grey.shade400, width: 0.8);
                  }),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),

                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),

                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
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