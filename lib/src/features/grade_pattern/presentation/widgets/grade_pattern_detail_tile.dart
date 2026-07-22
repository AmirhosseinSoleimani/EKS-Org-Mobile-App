import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_detail_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_level_style.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class GradePatternDetailTile extends StatelessWidget {
  const GradePatternDetailTile({super.key, required this.detail});

  final GradePatternDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = gradePatternLevelStyle(detail.gradeTitle);

    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: style.title == 'بحرانی'
              ? style.color.withOpacity(0.35)
              : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(16),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Metric(
                  label: 'ضریب',
                  value: gradePatternNumber(detail.gradeCoefficient),
                ),
                Space.h4,
                _Metric(
                  label: 'حق مدیریت',
                  value: '${gradePatternNumber(detail.managmentCommisionPercent)}٪',
                  color: style.color,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  style.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: style.color,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Space.h8,
                Text(
                  style.description,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(color: style.color),
                ),
              ],
            ),
          ),
          Space.w12,
          Container(
            width: 8,
            height: 36,
            decoration: BoxDecoration(
              color: style.color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.label,
    required this.value,
    this.color,
  });

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '$label: '),
          TextSpan(
            text: value,
            style: TextStyle(
              color: color ?? theme.colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      style: theme.textTheme.bodySmall,
    );
  }
}
