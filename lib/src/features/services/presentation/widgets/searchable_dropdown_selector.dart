import 'dart:async';

import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class DebouncedSearchDropdownField<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final List<T> items;
  final bool isLoading;
  final bool enabled;
  final int minSearchLength;
  final Duration debounceDuration;
  final Future<void> Function(String query) onSearch;
  final void Function(T item) onSelect;
  final String Function(T item) itemTitleBuilder;

  const DebouncedSearchDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.items,
    required this.onSearch,
    required this.onSelect,
    required this.itemTitleBuilder,
    this.focusNode,
    this.isLoading = false,
    this.enabled = true,
    this.minSearchLength = 3,
    this.debounceDuration = const Duration(seconds: 1),
  });

  @override
  State<DebouncedSearchDropdownField<T>> createState() =>
      _DebouncedSearchDropdownFieldState<T>();
}

class _DebouncedSearchDropdownFieldState<T>
    extends State<DebouncedSearchDropdownField<T>> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();

  Timer? _debounce;
  OverlayEntry? _overlayEntry;

  @override
  void didUpdateWidget(covariant DebouncedSearchDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _removeOverlay();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();

    final query = value.trim();

    if (query.length < widget.minSearchLength) {
      _removeOverlay();
      return;
    }

    _debounce = Timer(widget.debounceDuration, () async {
      await widget.onSearch(query);

      if (!mounted) return;

      _showOverlay();
    });
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (_) {
        final size = _getFieldSize();

        return Positioned.fill(
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removeOverlay,
              ),
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 4),
                child: Material(
                  color: Colors.transparent,
                  child: _buildDropdown(size.width),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildDropdown(double width) {
    return Container(
      width: width,
      constraints: const BoxConstraints(
        maxHeight: 260,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 4),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: widget.isLoading
          ? const _DropdownLoading()
          : widget.items.isEmpty
          ? const _DropdownEmpty()
          : ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: widget.items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, index) {
          final item = widget.items[index];

          return InkWell(
            onTap: () {
              widget.onSelect(item);
              _removeOverlay();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Text(
                widget.itemTitleBuilder(item),
                textAlign: TextAlign.start,
              ),
            ),
          );
        },
      ),
    );
  }

  Size _getFieldSize() {
    final renderBox =
    _fieldKey.currentContext?.findRenderObject() as RenderBox?;

    return renderBox?.size ?? Size.zero;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormFieldWidget(
        newKey: _fieldKey,
        controller: widget.controller,
        focusNode: widget.focusNode,
        labelText: widget.label,
        hintText: widget.hintText,
        readOnly: !widget.enabled,
        textInputType: TextInputType.text,
        onChanged: _onChanged,
        suffixIcon: widget.isLoading
            ? const Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        )
            : null,
      ),
    );
  }
}

class _DropdownLoading extends StatelessWidget {
  const _DropdownLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}

class _DropdownEmpty extends StatelessWidget {
  const _DropdownEmpty();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text('هیچ موردی یافت نشد'),
      ),
    );
  }
}