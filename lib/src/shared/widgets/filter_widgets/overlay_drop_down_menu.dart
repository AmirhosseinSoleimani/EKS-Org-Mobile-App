import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 260,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
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
                          Expanded(
                            child: BodyMediumText(text:
                              item.label,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

