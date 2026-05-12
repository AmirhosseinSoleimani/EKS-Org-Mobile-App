import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatelessWidget {
  final String label;
  final ValueNotifier<DateTime?>? valueNotifier;
  final ValueChanged<DateTime>? onTimeSelected;
  final DateTime? initialTime;

  const TimePickerWidget({
    super.key,
    required this.label,
    this.valueNotifier,
    this.onTimeSelected,
    this.initialTime,
  });

  String _formatTime(DateTime? value) {
    if (value == null) return "";
    final h = value.hour.toString().padLeft(2, '0');
    final m = value.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }

  Future<void> _pickTime(BuildContext context, DateTime? current) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current ?? DateTime.now()),
    );

    if (picked == null) return;

    final now = DateTime.now();

    final newDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );

    valueNotifier?.value = newDateTime;
    onTimeSelected?.call(newDateTime);
  }

  @override
  Widget build(BuildContext context) {
    if (valueNotifier == null) {
      final time = initialTime;

      return TextFormFieldWidget(
        labelText: label,
        hintText: "00:00",
        controller: TextEditingController(text: _formatTime(time)),
        readOnly: true,
        onTap: () => _pickTime(context, time),
      );
    }

    return ValueListenableBuilder<DateTime?>(
      valueListenable: valueNotifier!,
      builder: (context, value, _) {
        final time = value ?? initialTime;

        return TextFormFieldWidget(
          labelText: label,
          hintText: "00:00",
          controller: TextEditingController(text: _formatTime(time)),
          readOnly: true,
          onTap: () => _pickTime(context, time),
        );
      },
    );
  }
}

