import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:flutter/material.dart';

class CancelReasonDropdown<T extends DropdownItem> extends StatelessWidget {
  final String label;
  final String defaultTitle;
  final ValueNotifier<T?> selectedNotifier;
  final List<T> items;
  final bool isLoading;
  final bool enabled;
  final void Function(T) onSelect;
  final String Function(T) itemTitleBuilder;

  const CancelReasonDropdown({
    super.key,
    required this.label,
    required this.defaultTitle,
    required this.selectedNotifier,
    required this.items,
    required this.onSelect,
    required this.itemTitleBuilder,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T?>(
      valueListenable: selectedNotifier,
      builder: (_, selectedItem, __) {
        final title = isLoading
            ? "در حال بارگذاری..."
            : selectedItem != null
            ? itemTitleBuilder(selectedItem)
            : defaultTitle;

        return SizedBox(
          height: 52,
          child: FilterButton(
            title: title,
            label: label,
            hasFloatingLabel: true,
            expand: true,
            enabled: enabled,
            overlayBuilder: (context, position, width, dismiss) {
              return OverlayDropdownMenu<T>(
                position: position,
                width: width,
                items: items,
                onDismiss: dismiss,
                onSelect: (item) {
                  onSelect(item);
                  dismiss();
                },
              );
            },
          ),
        );
      },
    );
  }
}
