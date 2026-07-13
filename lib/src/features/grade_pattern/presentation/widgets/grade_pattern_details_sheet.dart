import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class GradePatternDetailsSheet extends StatelessWidget {
  const GradePatternDetailsSheet({super.key, required this.item});

  final GradePatternEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: AppSize.s40,
                height: AppSize.s4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
              ),
            ),
            Space.h24,
            Text(
              item.name ?? 'جزئیات الگوی گرید',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
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
                              value: detail.gradeCoefficient,
                            ),
                            _Metric(
                              label: 'درصد کمیسیون مدیریت',
                              value: detail.managmentCommisionPercent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Space.h16,
            InkwellButtonWidget(
              title: 'بستن',
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final num value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '$label: '),
          TextSpan(
            text: value.toString(),
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
