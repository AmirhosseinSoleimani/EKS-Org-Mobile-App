import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_detail_tile.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class GradePatternDetailsSheet extends StatelessWidget {
  const GradePatternDetailsSheet({super.key, required this.item});

  final GradePatternEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p12,
                AppPadding.p16,
                AppPadding.p16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDEC1AF),
                        borderRadius: BorderRadius.circular(AppSize.s16),
                      ),
                    ),
                  ),
                  Space.h24,
                  const TitleLargeText(
                    text: 'جزئیات الگوی گرید',
                    fontSize: 16,
                  ),
                  const SizedBox(height: 20),
                  _PatternHeader(title: item.name),
                  Space.h16,
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.62,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: item.details.length,
                      itemBuilder: (context, index) {
                        return GradePatternDetailTile(detail: item.details[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                border: Border(
                  top: BorderSide(color: theme.dividerColor.withOpacity(0.5)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: InkwellButtonWidget(
                  title: 'بستن',
                  backgroundColor: theme.colorScheme.onPrimary,
                  borderColor: theme.colorScheme.onSurface,
                  titleColor: theme.colorScheme.onSurface,
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatternHeader extends StatelessWidget {
  const _PatternHeader({required this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9E9E9),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.workspace_premium_outlined,
            color: theme.colorScheme.primary,
          ),
          Space.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'عنوان الگو',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Space.h4,
                Text(
                  _value(title),
                  textAlign: TextAlign.right,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
