import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/evaluation_selected_part_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/amount_row/amount_row.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class SelectedPartListItem extends StatelessWidget {
  final EvaluationSelectedPartEntity item;
  final ColorScheme colorScheme;
  final VoidCallback onDelete;

  const SelectedPartListItem({
    super.key,
    required this.item,
    required this.colorScheme,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primary.withAlpha(15),
        border: Border.all(color: colorScheme.primary),
        borderRadius: BorderRadius.circular(6),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _buildDetailsColumn()),
            const SizedBox(width: 8),
            _buildActionAndPriceColumn(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyMediumText(text: item.partName, fontWeight: FontWeight.bold),
        Space.h8,
        BodySmallText(
          text: 'مارک: ${item.markName}',
          color: colorScheme.onPrimaryFixed,
          fontSize: 14,
        ),
        Space.h6,
        BodySmallText(
          text: 'تعداد: ${item.count}',
          color: colorScheme.onPrimaryFixed,
          fontSize: 14,
        ),
        Space.h6,
        BodySmallText(
          text: 'مرکز هزینه: ${item.costCenterName}',
          color: colorScheme.onPrimaryFixed,
          fontSize: 14,
        ),
      ],
    );
  }

  Widget _buildActionAndPriceColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: onDelete,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              Icons.delete_outline_rounded,
              color: colorScheme.primary,
              size: 22,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AmountRow(
            amount: item.price,
            valueStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }


}
