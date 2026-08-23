import 'dart:async';

import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/submit_cancel_buttons.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/persian_date_picker_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.onTap,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.suffixIcon,
    this.mandatory = false,
    this.validator,
    this.focusNode,
    this.onFieldTap,
    this.openPickerOnTap = true,
    this.border,
    this.focusBorder,
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.right,
  });

  final TextEditingController controller;
  final Jalali? initialDate;
  final Jalali? firstDate;
  final Jalali? lastDate;
  final Widget? suffixIcon;
  final FutureOr<void> Function(Jalali?)? onTap;
  final String labelText;
  final String hintText;
  final bool mandatory;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final VoidCallback? onFieldTap;
  final bool openPickerOnTap;
  final InputBorder? border;
  final InputBorder? focusBorder;
  final TextDirection textDirection;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormFieldWidget(
      readOnly: true,
      labelText: labelText,
      mandatory: mandatory,
      validator: validator,
      hintStyle: theme.textTheme.displayMedium?.copyWith(
        fontSize: 13,
      ),
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        fontSize: AppSize.s14,
      ),
      textStyle: theme.textTheme.displayMedium?.copyWith(
        fontSize: 13,
      ),
      controller: controller,
      focusNode: focusNode,
      hintText: hintText,
      textAlign: textAlign,
      textDirection: textDirection,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      onTap: openPickerOnTap ? () => _pickDate(context) : onFieldTap,
      suffixIcon: suffixIcon,
      border: border,
      focusBorder: focusBorder,
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final minDate = firstDate ?? Jalali(1300, 1, 1);
    final maxDate = lastDate ?? Jalali.now();
    var selectedDate = _clampDate(
      _controllerDate() ?? initialDate ?? Jalali.now(),
      minDate,
      maxDate,
    );
    var isConfirmed = false;

    await BottomSheetMessage.showCustom(
      context: context,
      maxHeight: 0.86,
      content: PersianDatePickerSheet(
        initialDate: selectedDate,
        firstDate: minDate,
        lastDate: maxDate,
        onDateChanged: (value) => selectedDate = value,
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

    controller.text = _format(selectedDate);
    await onTap?.call(selectedDate);
  }

  Jalali _clampDate(Jalali value, Jalali minDate, Jalali maxDate) {
    final valueKey = _dateKey(value);
    if (valueKey < _dateKey(minDate)) return minDate;
    if (valueKey > _dateKey(maxDate)) return maxDate;
    return value;
  }

  int _dateKey(Jalali value) {
    return (value.year * 10000) + (value.month * 100) + value.day;
  }

  Jalali? _controllerDate() {
    final parts = controller.text.trim().split('/');
    if (parts.length != 3) return null;

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);
    if (year == null || month == null || day == null) return null;

    try {
      return Jalali(year, month, day);
    } catch (_) {
      return null;
    }
  }

  String _format(Jalali value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}/$month/$day';
  }
}
