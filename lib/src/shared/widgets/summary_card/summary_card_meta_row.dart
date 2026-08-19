import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_models.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/list_item_text.dart';
import 'package:flutter/material.dart';

class SummaryCardMetaRow extends StatelessWidget {
  const SummaryCardMetaRow({
    super.key,
    required this.item,
  });

  final SummaryCardMeta item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListItemMetaText(
            text: '${item.label}: ${_display(item.value)}',
          ),
        ),
        Space.w8,
        ListItemMetaText(
          text: _display(item.date),
          textDirection: item.dateTextDirection,
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
