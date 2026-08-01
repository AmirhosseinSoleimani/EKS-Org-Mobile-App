import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' show PointerDeviceKind;

class TimePickerWidget extends StatelessWidget {
  const TimePickerWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.onTimeSelected,
    required this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<DateTime> onTimeSelected;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      labelText: label,
      hintText: '00:00',
      controller: controller,
      readOnly: true,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
      onTap: () => _pickTime(context),
      suffixIcon: suffixIcon,
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    var selectedDateTime = _createInitialDateTime();
    final theme = Theme.of(context);

    await BottomSheetMessage.showCustom(
      context: context,
      maxHeight: 0.55,
      topRadius: AppSize.s28,
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentGeometry.topRight,
              child: const TitleMediumText(
                text: 'انتخاب زمان',
                color: Color(0xFF1D1D1F),
                fontWeight: FontWeight.w800,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: AppSize.s12),
            SizedBox(
              height: 190,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: const {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.trackpad,
                          PointerDeviceKind.stylus,
                          PointerDeviceKind.invertedStylus,
                        },
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        use24hFormat: true,
                        minuteInterval: 1,
                        initialDateTime: selectedDateTime,
                        backgroundColor: Colors.transparent,
                        onDateTimeChanged: (value) {
                          selectedDateTime = value;
                        },
                      ),
                    ),
                  ),
                  const Positioned.fill(
                    child: IgnorePointer(
                      child: _TimePickerUnitLabels(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s8),
          ],
        ),
      ),
      actionWidget: InkwellButtonWidget(
        title: 'تأیید زمان',
        height: AppSize.s54,
        borderRadius: AppSize.s16,
        backgroundColor: theme.colorScheme.primary,
        titleColor: theme.colorScheme.onPrimary,
        textStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
          fontSize: AppSize.s16,
        ),
        onTap: () {
          controller.text = _formatTime(selectedDateTime);

          onTimeSelected(
            DateTime(
              selectedDateTime.year,
              selectedDateTime.month,
              selectedDateTime.day,
              selectedDateTime.hour,
              selectedDateTime.minute,
            ),
          );

          Navigator.of(context).pop();
        },
      ),
    );
  }

  DateTime _createInitialDateTime() {
    final now = DateTime.now();
    final selectedTime = _parseControllerTime();

    if (selectedTime == null) {
      return DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
      );
    }

    return DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  String _formatTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  TimeOfDay? _parseControllerTime() {
    final value = controller.text.trim();

    if (value.isEmpty) {
      return null;
    }

    final parts = value.split(':');

    if (parts.length != 2) {
      return null;
    }

    final hour = int.tryParse(parts.first);
    final minute = int.tryParse(parts.last);

    if (hour == null || minute == null) {
      return null;
    }

    if (hour < 0 || hour > 23) {
      return null;
    }

    if (minute < 0 || minute > 59) {
      return null;
    }

    return TimeOfDay(
      hour: hour,
      minute: minute,
    );
  }
}

class _TimePickerUnitLabels extends StatelessWidget {
  const _TimePickerUnitLabels();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _TimePickerUnitLabel(text: 'ساعت'),
          SizedBox(width: AppSize.s48),
          BodyMediumText(
            text: ':',
            fontSize: AppSize.s24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1D1D1F),
          ),
          SizedBox(width: AppSize.s48),
          _TimePickerUnitLabel(text: 'دقیقه'),
        ],
      ),
    );
  }
}
class _TimePickerUnitLabel extends StatelessWidget {
  const _TimePickerUnitLabel({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(AppSize.s6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p4,
          vertical: AppPadding.p2,
        ),
        child: BodyMediumText(
          text: text,
          fontSize: AppSize.s12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF8E8E93),
        ),
      ),
    );
  }
}