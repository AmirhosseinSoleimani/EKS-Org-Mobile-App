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
  final bool enabled;

  const DateTimePickerSection({
    super.key,
    required this.dateLabel,
    required this.timeLabel,
    required this.dateController,
    required this.timeController,
    required this.onDateChange,
    required this.onTimeChange,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DatePickerWidget(
            suffixIcon: Icon(Icons.expand_more_rounded),
            controller: dateController,
            labelText: dateLabel,
            hintText: 'انتخاب تاریخ',
            openPickerOnTap: enabled,
            onTap: (picked) => onDateChange(picked?.toDateTime()),
          ),
        ),
        Space.w16,
        Expanded(
          child: TimePickerWidget(
            suffixIcon: Icon(Icons.expand_more_rounded),
            label: timeLabel,
            controller: timeController,
            onTimeSelected: onTimeChange,
            enabled: enabled,
          ),
        ),
      ],
    );
  }
}

