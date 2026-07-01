import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

import 'interfaces/dropdown_item.dart';

class OverlayDropdownMenu<T extends DropdownItem> extends StatefulWidget {
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
  State<OverlayDropdownMenu<T>> createState() => _OverlayDropdownMenuState<T>();
}

class _OverlayDropdownMenuState<T extends DropdownItem>
    extends State<OverlayDropdownMenu<T>> {
  static const double _menuMaxHeight = 260;
  static const double _itemHeight = 44;

  late final ScrollController _scrollController;

  bool get _shouldShowScrollbar {
    return widget.items.length * _itemHeight > _menuMaxHeight;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ScrollbarOrientation _resolveScrollbarOrientation(BuildContext context) {
    final direction = Directionality.of(context);

    return direction == TextDirection.rtl
        ? ScrollbarOrientation.left
        : ScrollbarOrientation.right;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// tap outside → dismiss
        GestureDetector(
          onTap: widget.onDismiss,
          behavior: HitTestBehavior.translucent,
          child: const SizedBox.expand(),
        ),

        /// dropdown menu
        Positioned(
          top: widget.position.dy,
          left: widget.position.dx,
          width: widget.width,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.onPrimary,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: _menuMaxHeight,
              ),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: _shouldShowScrollbar,
                trackVisibility: _shouldShowScrollbar,
                scrollbarOrientation: _resolveScrollbarOrientation(context),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  primary: false,
                  itemExtent: _itemHeight,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    final leading = item.leading(context);

                    return InkWell(
                      onTap: () => widget.onSelect(item),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Row(
                          children: [
                            if (leading != null) ...[
                              leading,
                              const SizedBox(width: 8),
                            ],
                            Expanded(
                              child: BodyMediumText(
                                text: item.label,
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
        ),
      ],
    );
  }
}