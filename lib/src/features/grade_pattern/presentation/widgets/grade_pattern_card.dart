import 'package:eks_sana_plus_org/src/features/grade_pattern/domain/entities/grade_pattern_entity.dart';
import 'package:eks_sana_plus_org/src/features/grade_pattern/presentation/widgets/grade_pattern_levels_summary.dart';
import 'package:eks_sana_plus_org/src/shared/date_helper/jalali_date_helper.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/request_widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_large_text.dart';
import 'package:flutter/material.dart';

class GradePatternCard extends StatelessWidget {
  const GradePatternCard({
    super.key,
    required this.item,
    required this.onDetails,
    required this.onEdit,
    required this.onDelete,
  });

  final GradePatternEntity item;
  final VoidCallback onDetails;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppPadding.p12),
      padding: const EdgeInsets.all(AppPadding.p18),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TitleLargeText(text:
                _value(item.name),
                  textAlign: TextAlign.right,
                ),
              ),
              Space.w8,
              StatusLabel(text: item.isActive ? 'فعال' : 'غیرفعال',
                color: item.isActive ? theme.colorScheme.onError : theme
                    .colorScheme.error,
                variant: StatusLabelVariant.filledWithoutBorder,),
            ],
          ),
          Space.h16,
          GradePatternLevelsSummary(details: item.details),
          Space.h8,
          Divider(color: theme.dividerColor),
          Space.h8,
          Row(
            children: [
              Expanded(
                child: BodySmallText(
                  text: 'ثبت‌کننده: ${_value(item.insertUserFullName)}',
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                  color: theme.colorScheme.onPrimaryFixed,
                  fontWeight: FontWeight.w500,
                ),
              ),
              BodySmallText(
                text: JalaliDateHelper.formatStringJalaliDateTime(
                  item.insertDateTimeJalali,
                ),
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
                color: theme.colorScheme.onPrimaryFixed,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Space.h16,
          Row(
            children: [
              Expanded(
                child: InkwellButtonWidget(
                  title: 'مشاهده جزئیات',
                  onTap: onDetails,
                  prefixIcon: Icon(
                    Icons.visibility_outlined,
                    color: theme.colorScheme.onPrimary,
                    size: 22,
                  ),
                ),
              ),
              Space.w8,
              Expanded(
                child: InkwellButtonWidget(
                  title: 'عملیات',
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  titleColor: theme.colorScheme.onTertiaryFixed,
                  prefixIcon: Icon(
                    Icons.settings_outlined,
                    color: theme.colorScheme.onTertiaryFixed,
                  ),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.colorScheme.onTertiaryFixed,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


enum _GradePatternOperation { edit, delete }

String _value(String? value) {
  return value?.trim().isNotEmpty == true ? value!.trim() : '---';
}
