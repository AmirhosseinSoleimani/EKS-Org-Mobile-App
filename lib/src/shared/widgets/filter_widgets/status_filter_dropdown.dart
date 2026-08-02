import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';

class StatusFilterOption<T> implements DropdownItem<T> {
  const StatusFilterOption({
    required this.value,
    required this.label,
  });

  @override
  final T value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) => null;
}

class StatusFilterDropdown<T> extends StatelessWidget {
  const StatusFilterDropdown({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.placeholder = 'وضعیت',
    this.allLabel = 'همه',
    this.expand = true,
  }) : assert(options.length > 0, 'Status options must not be empty.');

  final T value;
  final List<StatusFilterOption<T>> options;
  final ValueChanged<T> onChanged;
  final String placeholder;
  final String allLabel;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final selected = options.firstWhere(
      (item) => item.value == value,
      orElse: () => options.first,
    );

    return FilterButton(
      title: selected.label == allLabel ? placeholder : selected.label,
      expand: expand,
      overlayBuilder: (context, position, width, dismiss) {
        return OverlayDropdownMenu<StatusFilterOption<T>>(
          position: position,
          width: width,
          items: options,
          onDismiss: dismiss,
          onSelect: (item) {
            onChanged(item.value);
            dismiss();
          },
        );
      },
    );
  }
}
