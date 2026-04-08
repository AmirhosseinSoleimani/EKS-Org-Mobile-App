import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
class FilterButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool expand;

  final Widget Function(
      BuildContext context,
      Offset position,
      double width,
      VoidCallback dismiss,
      )? overlayBuilder;

  const FilterButton({
    super.key,
    required this.title,
    this.icon = Icons.keyboard_arrow_down,
    this.expand = false,
    this.overlayBuilder,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  final _key = GlobalKey();
  OverlayEntry? _overlayEntry;

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleOverlay() {
    if (widget.overlayBuilder == null) return;

    if (_overlayEntry != null) {
      _removeOverlay();
      return;
    }

    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (_) => widget.overlayBuilder!(
        context,
        offset,
        box.size.width,
        _removeOverlay,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: _key,
      onTap: _toggleOverlay,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Expanded(
              child: BodyMediumText(
                text: widget.title,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 4),
            Icon(widget.icon, size: 20),
          ],
        ),
      ),
    );

  }
}

