import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/time_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class DateTimePickerSection extends StatelessWidget {
  final String dateLabel;
  final String timeLabel;

  final ValueNotifier<DateTime?> dateNotifier;
  final ValueNotifier<DateTime?>? timeNotifier;

  final void Function(DateTime?) onDateChange;
  final void Function(DateTime) onTimeChange;

  const DateTimePickerSection({
    super.key,
    required this.dateLabel,
    required this.timeLabel,
    required this.dateNotifier,
    this.timeNotifier,
    required this.onDateChange,
    required this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<DateTime?>(
            valueListenable: dateNotifier,
            builder: (context, value, _) {
              final initial = Jalali.fromDateTime(value ?? DateTime.now());
              final controller = TextEditingController(
                text: '${initial.year}/${initial.month}/${initial.day}',
              );

              return DatePickerWidget(
                controller: controller,
                labelText: dateLabel,
                hintText: 'انتخاب تاریخ',
                initialDate: initial,
                onTap: (picked) => onDateChange(picked?.toDateTime()),
              );
            },
          ),
        ),
        Space.w16,
        Expanded(
          child: TimePickerWidget(
            label: timeLabel,
            valueNotifier: timeNotifier ?? dateNotifier,
            initialTime: timeNotifier == null ? dateNotifier.value : timeNotifier?.value,
            onTimeSelected: onTimeChange,
          ),
        ),
      ],
    );
  }
}

/*
class DateTimePickerSection extends StatelessWidget {
  final String dateLabel;
  final String timeLabel;

  final ValueNotifier<DateTime?> dateNotifier;

  final void Function(DateTime?) onDateChange;
  final void Function(DateTime) onTimeChange;

  const DateTimePickerSection({
    super.key,
    required this.dateLabel,
    required this.timeLabel,
    required this.dateNotifier,
    required this.onDateChange,
    required this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<DateTime?>(
            valueListenable: dateNotifier,
            builder: (context, value, _) {
              final initial = Jalali.fromDateTime(value ?? DateTime.now());
              final controller = TextEditingController(
                text: '${initial.year}/${initial.month}/${initial.day}',
              );

              return DatePickerWidget(
                controller: controller,
                labelText: dateLabel,
                hintText: 'انتخاب تاریخ',
                initialDate: initial,
                onTap: (picked) => onDateChange(picked?.toDateTime()),
              );
            },
          ),
        ),

        Space.w16,
        Expanded(
          child: TimePickerWidget(
            label: timeLabel,
            valueNotifier: dateNotifier,
            onTimeSelected: (time) => onTimeChange(time),
          ),
        ),
      ],
    );
  }
}*/
