import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class RescuerDropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final bool mandatory;

  const RescuerDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.mandatory = false,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<T>(
    value: value,
    isExpanded: true,
    items: items,
    onChanged: onChanged,
    validator: mandatory ? (v) => v == null ? '$label الزامی است' : null : null,
    decoration: InputDecoration(
      labelText: mandatory ? '$label *' : label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    ),
    style: Theme.of(context).textTheme.bodyMedium,
  );

  static DropdownMenuItem<T> item<T>(T value, String text) =>
      DropdownMenuItem<T>(
        value: value,
        child: BodyMediumText(text: text, fontSize: 14),
      );
}
