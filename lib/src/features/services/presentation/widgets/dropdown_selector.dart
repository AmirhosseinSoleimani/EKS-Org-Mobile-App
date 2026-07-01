import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/material.dart';

class DropdownSelector<T extends DropdownItem> extends StatefulWidget {
  final String label;
  final String placeholder;
  final ValueNotifier<T?> selectedNotifier;
  final List<T> items;
  final bool isLoading;
  final bool enabled;
  final bool searchable;
  final void Function(T) onSelect;
  final String Function(T) itemTitleBuilder;

  const DropdownSelector({
    super.key,
    required this.label,
    required this.placeholder,
    required this.selectedNotifier,
    required this.items,
    required this.onSelect,
    required this.itemTitleBuilder,
    this.isLoading = false,
    this.enabled = true,
    this.searchable = false,
  });

  @override
  State<DropdownSelector<T>> createState() => _DropdownSelectorState<T>();
}

class _DropdownSelectorState<T extends DropdownItem>
    extends State<DropdownSelector<T>> {
  final GlobalKey _fieldKey = GlobalKey();

  late final TextEditingController _searchController;
  late final FocusNode _focusNode;

  OverlayEntry? _overlayEntry;
  String _query = '';

  static const double _overlayGap = 4;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _focusNode = FocusNode();

    widget.selectedNotifier.addListener(_syncTextWithSelectedItem);

    _syncTextWithSelectedItem();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus && widget.searchable) {
        _openOverlay();
      }
    });
  }

  @override
  void didUpdateWidget(covariant DropdownSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedNotifier != widget.selectedNotifier) {
      oldWidget.selectedNotifier.removeListener(_syncTextWithSelectedItem);
      widget.selectedNotifier.addListener(_syncTextWithSelectedItem);
      _syncTextWithSelectedItem();
    }

    _overlayEntry?.markNeedsBuild();
  }

  @override
  void dispose() {
    widget.selectedNotifier.removeListener(_syncTextWithSelectedItem);
    _removeOverlay();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<T> get _filteredItems {
    final normalizedQuery = _normalize(_query);

    if (normalizedQuery.isEmpty) {
      return widget.items;
    }

    return widget.items.where((item) {
      final title = _normalize(widget.itemTitleBuilder(item));
      return title.contains(normalizedQuery);
    }).toList();
  }

  void _syncTextWithSelectedItem() {
    if (!widget.searchable) return;

    final selectedItem = widget.selectedNotifier.value;
    final selectedTitle =
    selectedItem == null ? '' : widget.itemTitleBuilder(selectedItem);

    if (_searchController.text == selectedTitle) return;

    _searchController.text = selectedTitle;
  }

  String _normalize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll('ي', 'ی')
        .replaceAll('ك', 'ک')
        .replaceAll('‌', '');
  }

  void _onSearchChanged(String value) {
    _query = value;

    if (_overlayEntry == null) {
      _openOverlay();
    } else {
      _overlayEntry?.markNeedsBuild();
    }

    setState(() {});
  }

  void _openOverlay() {
    if (!widget.enabled || widget.isLoading) return;

    if (widget.items.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        SnakeBarWidget.showNotice(
          context: context,
          message: 'موردی برای نمایش وجود ندارد',
        );
      });
      return;
    }

    if (_overlayEntry != null) {
      _overlayEntry?.markNeedsBuild();
      return;
    }

    final renderBox =
    _fieldKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final position = renderBox.localToGlobal(
      Offset(0, renderBox.size.height + _overlayGap),
    );

    _overlayEntry = OverlayEntry(
      builder: (_) {
        return OverlayDropdownMenu<T>(
          position: position,
          width: renderBox.size.width,
          items: _filteredItems,
          itemTitleBuilder: widget.itemTitleBuilder,
          onDismiss: () {
            _removeOverlay();
            _focusNode.unfocus();
          },
          onSelect: (item) {
            final title = widget.itemTitleBuilder(item);

            _query = '';
            _searchController.text = title;

            widget.onSelect(item);

            _removeOverlay();
            _focusNode.unfocus();
          },
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchable) {
      return _buildSearchableField(context);
    }

    return _buildNormalDropdown();
  }

  Widget _buildNormalDropdown() {
    return ValueListenableBuilder<T?>(
      valueListenable: widget.selectedNotifier,
      builder: (_, selectedItem, _) {
        final title = widget.isLoading
            ? 'در حال بارگذاری...'
            : selectedItem != null
            ? widget.itemTitleBuilder(selectedItem)
            : widget.placeholder;

        return SizedBox(
          height: 52,
          child: FilterButton(
            title: title,
            label: widget.label,
            hasFloatingLabel: true,
            expand: true,
            enabled: widget.enabled,
            overlayBuilder: (context, position, width, dismiss) {
              if (!widget.isLoading && widget.items.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  SnakeBarWidget.showNotice(
                    context: context,
                    message: 'موردی برای نمایش وجود ندارد',
                  );
                });
                return const SizedBox.shrink();
              }

              return OverlayDropdownMenu<T>(
                position: position,
                width: width,
                items: widget.items,
                itemTitleBuilder: widget.itemTitleBuilder,
                onDismiss: dismiss,
                onSelect: (item) {
                  widget.onSelect(item);
                  dismiss();
                },
              );
            },
          ),
        );
      },
    );
  }
  Widget _buildSearchableField(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final bodyMediumStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurface,
    );

    return SizedBox(
      key: _fieldKey,
      height: 52,
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        enabled: widget.enabled,
        readOnly: widget.isLoading,
        onTap: _openOverlay,
        onChanged: _onSearchChanged,
        textInputAction: TextInputAction.search,

        // متن تایپ‌شده / آیتم انتخاب‌شده
        style: bodyMediumStyle,

        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.isLoading ? 'در حال بارگذاری...' : widget.placeholder,

          // متن لیبل
          labelStyle: bodyMediumStyle,

          // متن placeholder
          hintStyle: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withAlpha(140),
          ),

          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () {
                    _query = '';
                    _searchController.clear();
                    _overlayEntry?.markNeedsBuild();
                    setState(() {});
                  },
                ),
              const Icon(Icons.keyboard_arrow_down, size: 20),
              const SizedBox(width: 8),
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}