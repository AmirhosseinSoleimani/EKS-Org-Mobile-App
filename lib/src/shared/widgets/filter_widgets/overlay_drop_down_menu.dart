import 'package:flutter/material.dart';
import 'interfaces/dropdown_item.dart';

class OverlayDropdownMenu<T extends DropdownItem> extends StatelessWidget {
  final Offset position;
  final double width;
  final List<T> items;

  final ValueChanged<T> onSelect;
  final VoidCallback onDismiss;

  const OverlayDropdownMenu({
    super.key,
    required this.position,
    required this.width,
    required this.items,
    required this.onSelect,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// tap outside → dismiss
        GestureDetector(
          onTap: onDismiss,
          behavior: HitTestBehavior.translucent,
          child: const SizedBox.expand(),
        ),

        /// dropdown menu
        Positioned(
          top: position.dy,
          left: position.dx,
          width: width,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.onPrimary,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: items.map((item) {
                final leading = item.leading(context);

                return InkWell(
                  onTap: () => onSelect(item),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        if (leading != null) ...[
                          leading,
                          const SizedBox(width: 8),
                        ],
                        Text(item.label),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

