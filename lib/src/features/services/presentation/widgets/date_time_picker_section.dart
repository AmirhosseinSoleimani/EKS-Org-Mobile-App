import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/date_picker_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/date_picker_widget/time_picker_widget.dart';
import 'package:flutter/material.dart';

class DateTimePickerSection extends StatelessWidget {
  final String dateLabel;
  final String timeLabel;

  final TextEditingController dateController;
  final TextEditingController timeController;

  final void Function(DateTime?) onDateChange;
  final void Function(DateTime) onTimeChange;

  const DateTimePickerSection({
    super.key,
    required this.dateLabel,
    required this.timeLabel,
    required this.dateController,
    required this.timeController,
    required this.onDateChange,
    required this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DatePickerWidget(
            controller: dateController,
            labelText: dateLabel,
            hintText: 'انتخاب تاریخ',
            onTap: (picked) => onDateChange(picked?.toDateTime()),
          ),
        ),
        Space.w16,
        Expanded(
          child: TimePickerWidget(
            label: timeLabel,
            controller: timeController,
            onTimeSelected: onTimeChange,
          ),
        ),
      ],
    );
  }
}

