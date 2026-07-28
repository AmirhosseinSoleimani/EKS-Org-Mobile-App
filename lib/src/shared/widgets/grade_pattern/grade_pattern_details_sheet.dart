import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_detail_tile.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/grade_pattern/grade_pattern_ui_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/material.dart';

class GradePatternDetailsSheet extends StatelessWidget {
  const GradePatternDetailsSheet({
    super.key,
    required this.item,
  });

  final GradePatternUiModel item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SafeArea(
      top: false,
      child: SizedBox(
        height: screenHeight * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p16,
                AppPadding.p12,
                AppPadding.p16,
                0,
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
                    fontSize: 15,
                  ),
                  Space.h20,
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: const _MouseDragScrollBehavior(),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p16,
                      0,
                      AppPadding.p16,
                      AppPadding.p16,
                    ),
                    itemCount: item.details.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _PatternHeader(title: item.title),
                            Space.h16,
                          ],
                        );
                      }

                      return GradePatternDetailTile(
                        detail: item.details[index - 1],
                      );
                    },
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                border: Border(
                  top: BorderSide(
                    color: theme.dividerColor.withOpacity(0.5),
                  ),
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

class _MouseDragScrollBehavior extends MaterialScrollBehavior {
  const _MouseDragScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

class _PatternHeader extends StatelessWidget {
  const _PatternHeader({
    required this.title,
  });

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عنوان الگو',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimaryFixed,
                  ),
                ),
                Space.h4,
                BodyMediumText(
                  text: _value(title),
                  textAlign: TextAlign.right,
                  color: const Color(0xFFC9590E),
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.verified_outlined,
            color: Color(0xFFC9590E),
          ),
        ],
      ),
    );
  }
}

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
