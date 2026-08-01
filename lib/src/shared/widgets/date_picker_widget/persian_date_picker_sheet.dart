import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class PersianDatePickerSheet extends StatelessWidget {
  const PersianDatePickerSheet({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateChanged,
  });

  final Jalali initialDate;
  final Jalali firstDate;
  final Jalali lastDate;
  final ValueChanged<Jalali> onDateChanged;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Localizations.override(
        context: context,
        locale: const Locale('fa', 'IR'),
        delegates: const [
          PersianMaterialLocalizations.delegate,
          PersianCupertinoLocalizations.delegate,
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TitleMediumText(
              text: 'انتخاب تاریخ',
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSize.s12),
            SizedBox(
              height: 390,
              child: PersianCalendarDatePicker(
                initialDate: initialDate,
                firstDate: firstDate,
                lastDate: lastDate,
                currentDate: Jalali.now(),
                initialCalendarMode: PersianDatePickerMode.day,
                onDateChanged: onDateChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
