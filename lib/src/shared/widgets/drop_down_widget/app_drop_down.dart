import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final List<DropdownItem<T>> items;
  final DropdownItem<T>? value;
  final ValueChanged<DropdownItem<T>?> onChanged;
  final String? hint;

  const AppDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DropdownItem<T>>(
      value: value,
      onChanged: onChanged,
      icon: const Icon(Icons.keyboard_arrow_down),
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Row(
            children: [
              if (item.leading(context) != null) ...[
                item.leading(context)!,
                const SizedBox(width: 8),
              ],
              Expanded(child: Text(item.label)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
