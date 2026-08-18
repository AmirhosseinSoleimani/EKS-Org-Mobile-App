import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
class FilterButton extends StatefulWidget {
  final String title;
  final String? label;
  final bool expand;
  final bool hasFloatingLabel;
  final TextStyle? labelStyle;
  final bool enabled;
  final VoidCallback? onTap;
  final int titleMaxLines;
  final TextDirection? titleTextDirection;
  final bool fitTitleToAvailableWidth;

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
    this.expand = false,
    this.hasFloatingLabel = false,
    this.overlayBuilder,
    this.labelStyle,
    this.enabled = true,
    this.onTap,
    this.titleMaxLines = 1,
    this.titleTextDirection,
    this.fitTitleToAvailableWidth = false,
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

  Widget _buildTitle(String text) {
    final textDirection = widget.titleTextDirection ?? TextDirection.rtl;
    final title = BodyMediumText(
      text: text,
      maxLines: widget.fitTitleToAvailableWidth ? 1 : widget.titleMaxLines,
      textDirection: textDirection,
    );

    if (!widget.fitTitleToAvailableWidth) {
      return title;
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: textDirection == TextDirection.ltr
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasValue = widget.title.isNotEmpty;

    if (!widget.hasFloatingLabel) {

      return InkWell(
        key: _key,
        onTap: widget.enabled
            ? (widget.onTap ?? _toggleOverlay)
            : null,
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
                child: _buildTitle(widget.title),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 20),
            ],
          ),
        ),
      );
    }

    final colorScheme = theme.colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      key: _key,
      onTap: widget.enabled ? _toggleOverlay: null,
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        isEmpty: !hasValue,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: widget.labelStyle ??
              textTheme.labelMedium?.copyWith(
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
              child: _buildTitle(hasValue ? widget.title : ""),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 20),
          ],
        ),
      ),
    );
  }
}
