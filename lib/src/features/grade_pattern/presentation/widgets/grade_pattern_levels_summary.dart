import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_level_style.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class GradePatternLevelsSummary extends StatelessWidget {
  const GradePatternLevelsSummary({super.key, required this.details});

  final List<GradePatternDetailEntity> details;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleDetails = details.take(3).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              BodyMediumText(
                text: 'سطح گرید',
                color: Color(0xFF1B1B1B),
                fontSize: 13,
              ),
              Spacer(),
              BodyMediumText(
                text: 'درصد | ضریب',
                color: Color(0xFF1B1B1B),
                fontSize: 13,
              ),
            ],
          ),
          Space.h8,
          ...visibleDetails.map((detail) {
            final style = gradePatternLevelStyle(detail.gradeTitle);
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  BodyMediumText(
                    text: style.title,
                    color: Color(0xFF383838),
                    fontWeight: FontWeight.w700,
                  ),
                  Spacer(),
                  BodyMediumText(
                    text:
                        '${gradePatternNumber(detail.gradeCoefficient)} '
                        '| ${gradePatternNumber(detail.managmentCommisionPercent)}٪',
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
