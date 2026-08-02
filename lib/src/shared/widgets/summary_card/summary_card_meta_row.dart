import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:flutter/material.dart';

class SummaryCardMetaRow extends StatelessWidget {
  const SummaryCardMetaRow({
    super.key,
    required this.item,
  });

  final SummaryCardMeta item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onPrimaryFixed,
      fontSize: 13,
      fontWeight: FontWeight.w400,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '${item.label}: ${_display(item.value)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style,
          ),
        ),
        Space.w8,
        Text(
          _display(item.date),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textDirection: item.dateTextDirection,
          style: style,
        ),
      ],
    );
  }

  String _display(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty
        ? item.fallback
        : normalized;
  }
}
