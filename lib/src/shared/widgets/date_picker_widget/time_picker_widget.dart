import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<DateTime> onTimeSelected;
  final Widget? suffixIcon;

  const TimePickerWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.onTimeSelected,
    required this.suffixIcon,
  });

  String _formatTime(DateTime value) {
    final h = value.hour.toString().padLeft(2, '0');
    final m = value.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _parseControllerTime() ?? TimeOfDay.now(),
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

    controller.text = _formatTime(newDateTime);
    onTimeSelected(newDateTime);
  }

  TimeOfDay? _parseControllerTime() {
    if (controller.text.isEmpty) return null;
    final parts = controller.text.split(':');
    if (parts.length != 2) return null;
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      labelText: label,
      hintText: "00:00",
      controller: controller,
      readOnly: true,
      onTap: () => _pickTime(context),
      suffixIcon: suffixIcon,
    );
  }
}


