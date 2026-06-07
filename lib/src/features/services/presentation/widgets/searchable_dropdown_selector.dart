import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class SearchableDropdownSelector<T extends DropdownItem> extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final List<T> items;
  final bool isLoading;
  final bool enabled;
  final ValueNotifier<T?> selectedNotifier;
  final String Function(T) itemTitleBuilder;
  final void Function(String query) onSearchChanged;
  final void Function(T item) onSelect;

  const SearchableDropdownSelector({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.items,
    required this.selectedNotifier,
    required this.itemTitleBuilder,
    required this.onSearchChanged,
    required this.onSelect,
    this.focusNode,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  State<SearchableDropdownSelector<T>> createState() =>
      _SearchableDropdownSelectorState<T>();
}

class _SearchableDropdownSelectorState<T extends DropdownItem>
    extends State<SearchableDropdownSelector<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _onTextChanged(String value) {
    widget.onSearchChanged(value);

    if (value.trim().length >= 3) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _removeOverlay();

      final overlay = Overlay.of(context);
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final size = renderBox.size;

      _overlayEntry = OverlayEntry(
        builder: (_) {
          return Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 4),
              child: _SearchableDropdownOverlay<T>(
                items: widget.items,
                isLoading: widget.isLoading,
                itemTitleBuilder: widget.itemTitleBuilder,
                onSelect: (item) {
                  widget.onSelect(item);
                  _removeOverlay();
                },
              ),
            ),
          );
        },
      );

      overlay.insert(_overlayEntry!);
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void didUpdateWidget(covariant SearchableDropdownSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_overlayEntry != null) {
      _overlayEntry!.markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormFieldWidget(
        controller: widget.controller,
        focusNode: widget.focusNode,
        labelText: widget.label,
        hintText: widget.hintText,
        readOnly: !widget.enabled,
        suffixIcon: widget.isLoading
            ? const Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        )
            : const Icon(Icons.keyboard_arrow_down),
        onChanged: _onTextChanged,
      ),
    );
  }
}

class _SearchableDropdownOverlay<T extends DropdownItem>
    extends StatelessWidget {
  final List<T> items;
  final bool isLoading;
  final String Function(T) itemTitleBuilder;
  final void Function(T item) onSelect;

  const _SearchableDropdownOverlay({
    required this.items,
    required this.isLoading,
    required this.itemTitleBuilder,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      color: colorScheme.surface,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 260),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text('هیچ موردی یافت نشد'),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, index) {
        final item = items[index];

        return ListTile(
          dense: true,
          leading: item.leading(context),
          title: Text(itemTitleBuilder(item)),
          onTap: () => onSelect(item),
        );
      },
    );
  }
}