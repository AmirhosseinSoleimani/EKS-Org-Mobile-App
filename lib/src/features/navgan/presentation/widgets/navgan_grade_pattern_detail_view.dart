import 'package:eks_sana_plus_org/src/features/navgan/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class NavganGradePatternDetailView extends StatelessWidget {
  const NavganGradePatternDetailView({super.key, required this.item});

  final GradePatternEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final details = item.details;

    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleLargeText(
            text: item.name ?? item.label,
            color: theme.colorScheme.onSurface,
            fontSize: AppSize.s16,
          ),
          Space.h12,
          if (details.isEmpty)
            BodySmallText(
              text: 'جزئیاتی برای این الگو ثبت نشده است.',
              color: theme.colorScheme.onSurfaceVariant,
            )
          else
            ...details.map((detail) => _GradeDetailRow(item: detail)),
        ],
      ),
    );
  }
}

class _GradeDetailRow extends StatelessWidget {
  const _GradeDetailRow({required this.item});

  final GradePatternEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p12),
      child: Row(
        children: [
          Expanded(
            child: BodyMediumText(
              text: item.gradeTitle ?? '---',
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          BodySmallText(
            text: 'ضریب: ${item.gradeCoefficient ?? 0}',
            color: theme.colorScheme.onSurfaceVariant,
          ),
          Space.w12,
          BodySmallText(
            text: 'کمیسیون: ${item.managmentCommisionPercent ?? 0}',
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
