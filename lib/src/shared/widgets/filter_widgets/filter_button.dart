import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
class FilterButton extends StatefulWidget {
  final String title;
  final String? label;
  final IconData icon;
  final bool expand;
  final bool hasFloatingLabel;
  final TextStyle? labelStyle;

  final Widget Function(
      BuildContext context,
      Offset position,
      double width,
      VoidCallback dismiss,
      )? overlayBuilder;

  const FilterButton({
    super.key,
    required this.title,
    this.label,
    this.icon = Icons.keyboard_arrow_down,
    this.expand = false,
    this.hasFloatingLabel = false,
    this.overlayBuilder,
    this.labelStyle,
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
    final theme = Theme.of(context);
    final hasValue = widget.title.isNotEmpty;

    if (!widget.hasFloatingLabel) {

      return InkWell(
        key: _key,
        onTap: _toggleOverlay,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
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

    final colorScheme = theme.colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      key: _key,
      onTap: _toggleOverlay,
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        isEmpty: !hasValue,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: widget.labelStyle ??
              textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
            BorderSide(color: theme.colorScheme.primary, width: 1.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: BodyMediumText(
                text: hasValue ? widget.title : "",
                maxLines: 1,
              ),
            ),
            Icon(widget.icon, size: 20),
          ],
        ),
      ),
    );
  }
}
