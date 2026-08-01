import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/jalali_year_picker_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class JalaliYearPickerWidget extends StatelessWidget {
  const JalaliYearPickerWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText = 'انتخاب سال',
    this.firstYear = 1300,
    this.lastYear,
    this.initialYear,
    this.suffixIcon,
    this.mandatory = false,
    this.validator,
    this.onChanged,
  });

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int firstYear;
  final int? lastYear;
  final int? initialYear;
  final Widget? suffixIcon;
  final bool mandatory;
  final String? Function(String?)? validator;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      mandatory: mandatory,
      validator: validator,
      readOnly: true,
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: suffixIcon,
      onTap: () => _pickYear(context),
    );
  }

  Future<void> _pickYear(BuildContext context) async {
    final currentYear = Jalali.now().year;
    final maxYear = lastYear ?? currentYear;
    var selectedYear = _normalizeSelectedYear(
      int.tryParse(controller.text.trim()) ?? initialYear ?? maxYear,
      maxYear,
    );
    var isConfirmed = false;

    await BottomSheetMessage.showCustom(
      context: context,
      maxHeight: 0.72,
      content: JalaliYearPickerSheet(
        firstYear: firstYear,
        lastYear: maxYear,
        selectedYear: selectedYear,
        onYearChanged: (value) => selectedYear = value,
      ),
      actionWidget: Builder(
        builder: (sheetContext) {
          return SubmitCancelButtons(
            submitTitle: 'تایید',
            submitButtonColor: Theme.of(sheetContext).colorScheme.primary,
            onSubmit: () {
              isConfirmed = true;
              Navigator.of(sheetContext).pop();
            },
            onCancel: () => Navigator.of(sheetContext).pop(),
          );
        },
      ),
    );

    if (!isConfirmed) return;

    controller.text = selectedYear.toString();
    onChanged?.call(selectedYear);
  }

  int _normalizeSelectedYear(int value, int maxYear) {
    if (value < firstYear) return firstYear;
    if (value > maxYear) return maxYear;
    return value;
  }
}
