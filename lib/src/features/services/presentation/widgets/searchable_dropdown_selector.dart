import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
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

  bool get _canShowOverlay {
    return widget.enabled &&
        !widget.isLoading &&
        widget.controller.text
            .trim()
            .length >= 3;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _onTextChanged(String value) {
    widget.onSearchChanged(value);

    if (value
        .trim()
        .length < 3 || widget.isLoading) {
      _removeOverlay();
      return;
    }

    _showOverlay();
  }

  void _showOverlay() {
    if (!_canShowOverlay) return;

    if (_overlayEntry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_overlayEntry != null) {
          _overlayEntry!.markNeedsBuild();
        }
      });
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_canShowOverlay) return;

      final overlay = Overlay.of(context);
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final size = renderBox.size;

      _overlayEntry = OverlayEntry(
        builder: (_) {
          return Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _removeOverlay,
                  child: const SizedBox.expand(),
                ),
              ),
              Positioned(
                width: size.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(0, size.height + 4),
                  child: _SearchableDropdownOverlay<T>(
                    items: widget.items,
                    itemTitleBuilder: widget.itemTitleBuilder,
                    onSelect: (item) {
                      widget.onSelect(item);
                      _removeOverlay();
                    },
                  ),
                ),
              ),
            ],
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

    final shouldCloseOverlay =
        widget.isLoading ||
            !widget.enabled ||
            widget.controller.text.trim().length < 3;

    if (shouldCloseOverlay) {
      _removeOverlay();
      return;
    }

    final loadingFinished = oldWidget.isLoading && !widget.isLoading;
    final itemsChanged = oldWidget.items != widget.items;

    if (loadingFinished && widget.controller.text.trim().length >= 3) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showOverlay();
      });
      return;
    }

    if (itemsChanged && _overlayEntry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _overlayEntry?.markNeedsBuild();
      });
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
        suffixIcon: _buildSuffixIcon(),
        onChanged: _onTextChanged,
      ),
    );
  }

  Widget _buildSuffixIcon() {
    if (widget.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: _onSuffixIconTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(
          size: 20,
          _overlayEntry == null
              ? Icons.keyboard_arrow_down
              : Icons.keyboard_arrow_up,
        ),
      ),
    );
  }

  void _onSuffixIconTap() {
    if (!widget.enabled) return;

    if (_overlayEntry != null) {
      _removeOverlay();
      setState(() {});
      return;
    }

    if (widget.items.isEmpty) return;

    _showOverlay();
    setState(() {});
  }
}


class _SearchableDropdownOverlay<T extends DropdownItem>
    extends StatelessWidget {
  final List<T> items;
  final String Function(T) itemTitleBuilder;
  final void Function(T item) onSelect;

  const _SearchableDropdownOverlay({
    required this.items,
    required this.itemTitleBuilder,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: colorScheme.onPrimary,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 400,
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox(
        height: 44,
        child: Center(
          child: Text('هیچ موردی یافت نشد'),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: items.length,
      separatorBuilder: (_, __) =>
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(thickness: 1,
                height: 1, color: Theme
                    .of(context)
                    .colorScheme
                    .tertiaryFixed),
          ),
      itemBuilder: (_, index) {
        final item = items[index];

        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          dense: true,
          leading: item.leading(context),
          title: BodyMediumText(text: itemTitleBuilder(item)),
          onTap: () => onSelect(item),
        );
      },
    );
  }
}