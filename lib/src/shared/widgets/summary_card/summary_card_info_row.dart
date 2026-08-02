import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class SummaryCardInfoRow extends StatelessWidget {
  const SummaryCardInfoRow({
    super.key,
    required this.item,
  });

  final SummaryCardInfo item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onTertiaryFixed;
    final iconColor = theme.colorScheme.onPrimaryFixed;
    final value = _display(item.value, item.fallback);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSize.s20,
            height: AppSize.s20,
            child: item.iconWidget ??
                Icon(
                  item.icon,
                  size: AppSize.s20,
                  color: iconColor,
                ),
          ),
          Space.w8,
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${item.label}: ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.start,
              textDirection: item.textDirection,
              maxLines: item.maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  static String _display(String? value, String fallback) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? fallback : normalized;
  }
}
