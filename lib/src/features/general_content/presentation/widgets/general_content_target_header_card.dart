import 'package:eks_sana_plus_org/src/features/general_content/domain/entities/general_content_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class GeneralContentTargetHeaderCard extends StatelessWidget {
  const GeneralContentTargetHeaderCard({
    super.key,
    required this.item,
  });

  final GeneralContentEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.08),
            blurRadius: AppSize.s12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleMediumText(
                  text: item.title ?? '---',
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                ),
                Space.h8,
                BodyMediumText(
                  text: 'نوع: ${item.contentTypeText ?? '---'}',
                  color: theme.colorScheme.onTertiaryFixed,
                ),
              ],
            ),
          ),
          Space.w12,
          StatusLabel(
            text: item.isActive == true ? 'فعال' : 'غیرفعال',
            color: item.isActive == true
                ? theme.colorScheme.onError
                : theme.colorScheme.error,
            variant: StatusLabelVariant.filledWithoutBorder,
          ),
        ],
      ),
    );
  }
}
