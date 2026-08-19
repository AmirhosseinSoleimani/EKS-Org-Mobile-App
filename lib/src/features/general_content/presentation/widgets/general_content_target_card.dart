import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_target_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/list_item_text.dart';
import 'package:flutter/material.dart';

class GeneralContentTargetCard extends StatelessWidget {
  const GeneralContentTargetCard({
    super.key,
    required this.item,
  });

  final GeneralContentTargetEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIncluded = item.isIncluded;
    final effectColor =
        isIncluded ? theme.colorScheme.onError : theme.colorScheme.error;

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: ListItemTitleText(
                  text: item.targetTitle ?? '---',
                  maxLines: 2,
                ),
              ),
              Space.w8,
              StatusLabel(
                text: 'شرط: ${item.operatorText ?? '---'}',
                color: theme.colorScheme.onTertiaryFixed,
                variant: StatusLabelVariant.filledWithoutBorder,
              ),
            ],
          ),
          Space.h16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodySmallText(
                      text: 'مقدار',
                      color: theme.colorScheme.onTertiaryFixed,
                    ),
                    Space.h4,
                    ListItemValueText(
                      text: item.targetCategoryTitle ?? '---',
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BodySmallText(
                      text: 'نحوه تاثیر',
                      color: theme.colorScheme.onTertiaryFixed,
                    ),
                    Space.h4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          isIncluded ? Icons.check_circle : Icons.cancel,
                          color: effectColor,
                          size: AppSize.s16,
                        ),
                        Space.w4,
                        BodyMediumText(
                          text: item.targetBoundaryTypeText ?? '---',
                          color: effectColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
