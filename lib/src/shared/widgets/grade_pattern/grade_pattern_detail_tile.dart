import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_level_style.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_ui_model.dart';
import 'package:flutter/material.dart';

class GradePatternDetailTile extends StatelessWidget {
  const GradePatternDetailTile({super.key, required this.detail});

  final GradePatternLevelUiModel detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = gradePatternLevelStyle(detail.title);

    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: style.title == 'بحرانی'
              ? style.color.withAlpha(50)
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
          Container(
            width: 8,
            height: 42,
            decoration: BoxDecoration(
              color: style.color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Space.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: style.title == 'بحرانی' ? style.color : null,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Space.h8,
                Text(
                  style.description,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: style.color,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Metric(
                  label: 'ضریب',
                  value: gradePatternNumber(detail.coefficient),
                ),
                Space.h4,
                _Metric(
                  label: 'حق مدیریت',
                  value:
                      '${gradePatternNumber(detail.managementCommissionPercent)}٪',
                  color: style.color,
                ),
              ],
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
