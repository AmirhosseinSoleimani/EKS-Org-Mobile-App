import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_responsive_field_row.dart';
import 'package:eks_sana_plus_org/src/features/general_content/presentation/widgets/form/general_content_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class GeneralContentScheduleSection extends StatelessWidget {
  const GeneralContentScheduleSection({
    super.key,
    required this.startDateController,
    required this.applyDateController,
  });

  final TextEditingController startDateController;
  final TextEditingController applyDateController;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onTertiaryFixed;

    return FormSectionContainer(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GeneralContentSectionHeader(
            title: 'زمان‌بندی',
            icon: Icons.calendar_month_rounded,
          ),
          Space.h20,
          GeneralContentResponsiveFieldRow(
            first: DatePickerWidget(
              controller: startDateController,
              labelText: 'تاریخ ابلاغ',
              hintText: 'انتخاب کنید',
              mandatory: true,
              firstDate: Jalali(1300, 1, 1),
              lastDate: Jalali(1500, 12, 29),
              suffixIcon: Icon(
                Icons.calendar_month_outlined,
                color: iconColor,
              ),
              validator: _requiredDate,
            ),
            second: DatePickerWidget(
              controller: applyDateController,
              labelText: 'تاریخ اجرا',
              hintText: 'انتخاب کنید',
              mandatory: true,
              firstDate: Jalali(1300, 1, 1),
              lastDate: Jalali(1500, 12, 29),
              suffixIcon: Icon(
                Icons.calendar_month_outlined,
                color: iconColor,
              ),
              validator: _requiredDate,
            ),
          ),
        ],
      ),
    );
  }

  static String? _requiredDate(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'انتخاب تاریخ الزامی است.';
    }
    return null;
  }
}
