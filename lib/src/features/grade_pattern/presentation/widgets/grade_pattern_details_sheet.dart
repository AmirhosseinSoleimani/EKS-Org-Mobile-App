import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class GradePatternDetailsSheet extends StatelessWidget {
  const GradePatternDetailsSheet({super.key, required this.item});

  final GradePatternEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleLargeText(text: item.name ?? 'جزئیات الگوی گرید', fontSize: 16,),
        Space.h24,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Row(
                 children: [
                   Icon(Icons.grid_view_outlined),
                   Space.w4,
                   TitleMediumText(
                     text: 'سطوح گرید',
                     fontSize: 16,
                   ),
                 ],
               ),
                Space.h16,
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: item.details.length,
                    separatorBuilder: (_, __) => Divider(
                      color: theme.dividerColor.withOpacity(0.55),
                    ),
                    itemBuilder: (context, index) {
                      final detail = item.details[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              detail.gradeTitle,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Space.h8,
                            Wrap(
                              spacing: AppSize.s16,
                              runSpacing: AppSize.s8,
                              children: [
                                _Metric(
                                  label: 'ضریب گرید',
                                  value: detail.gradeCoefficient.toString(),
                                ),
                                _Metric(
                                  label: 'درصد کمیسیون مدیریت',
                                  value: '${detail.managmentCommisionPercent}٪',
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

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
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      style: theme.textTheme.bodySmall,
    );
  }
}
