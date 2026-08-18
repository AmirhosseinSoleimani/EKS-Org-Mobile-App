import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/jalali_date_text_formatter.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class DateRangeFilterButton extends StatelessWidget {
  const DateRangeFilterButton({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.onTap,
    required this.onClear,
    required this.isActive,
  });

  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback onTap;
  final VoidCallback onClear;
  final bool isActive;

  bool get _hasRange => isActive && fromDate != null && toDate != null;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s8),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        decoration: BoxDecoration(
          color: _hasRange ? primary.withAlpha(25) : Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s8),
          border: Border.all(
            color: _hasRange ? primary : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: BodyMediumText(
                  text: _title,
                  maxLines: 1,
                  color: _hasRange ? primary : null,
                ),
              ),
            ),
            Space.w4,
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _hasRange ? onClear : null,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p2),
                child: Icon(
                  _hasRange
                      ? Icons.close_rounded
                      : Icons.calendar_today_outlined,
                  size: AppSize.s20,
                  color: _hasRange ? primary : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _title {
    if (!_hasRange) return 'فیلتر بر اساس تاریخ';
    return JalaliDateTextFormatter.compactRange(fromDate!, toDate!);
  }
}
