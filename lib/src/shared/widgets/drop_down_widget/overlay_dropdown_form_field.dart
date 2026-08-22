import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/interfaces/dropdown_item.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class SimpleDropdownItem<T> implements DropdownItem<T> {
  const SimpleDropdownItem({required this.value, required this.label});

  @override
  final T value;

  @override
  final String label;

  @override
  Widget? leading(BuildContext context) => null;
}

class OverlayDropdownFormField<T extends DropdownItem> extends StatefulWidget {
  const OverlayDropdownFormField({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.value,
    this.mandatory = false,
    this.enabled = true,
    this.hintText = 'انتخاب کنید',
    this.validator,
    this.itemTitleBuilder,
  });

  final String labelText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final bool mandatory;
  final bool enabled;
  final String hintText;
  final FormFieldValidator<T>? validator;
  final String Function(T)? itemTitleBuilder;

  @override
  State<OverlayDropdownFormField<T>> createState() =>
      _OverlayDropdownFormFieldState<T>();
}

class _OverlayDropdownFormFieldState<T extends DropdownItem>
    extends State<OverlayDropdownFormField<T>> {
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _open(FormFieldState<T> fieldState) {
    if (!widget.enabled || widget.items.isEmpty || _overlayEntry != null) return;

    final box = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    final overlay = Overlay.of(context);
    if (box == null) return;

    final position = box.localToGlobal(Offset(0, box.size.height + 4));
    _overlayEntry = OverlayEntry(
      builder: (_) => OverlayDropdownMenu<T>(
        position: position,
        width: box.size.width,
        items: widget.items,
        itemTitleBuilder: widget.itemTitleBuilder,
        onDismiss: _removeOverlay,
        onSelect: (item) {
          fieldState.didChange(item);
          widget.onChanged(item);
          _removeOverlay();
        },
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  String _title(T item) => widget.itemTitleBuilder?.call(item) ?? item.label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormField<T>(
      initialValue: widget.value,
      validator: widget.validator,
      builder: (fieldState) {
        final selected = fieldState.value;
        final hasError = fieldState.hasError;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              key: _fieldKey,
              onTap: () => _open(fieldState),
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: InputDecorator(
                isEmpty: selected == null,
                decoration: InputDecoration(
                  isDense: true,
                  label: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.labelText,
                          style: theme.textTheme.bodyMedium,
                        ),
                        if (widget.mandatory)
                          TextSpan(
                            text: ' *',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  errorText: null,
                  enabled: widget.enabled,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: AppSize.s22,
                    color: theme.colorScheme.onPrimaryFixed,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    borderSide: BorderSide(
                      color: hasError
                          ? theme.colorScheme.error
                          : theme.colorScheme.inverseSurface,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    borderSide: BorderSide(color: theme.colorScheme.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                    vertical: AppPadding.p14,
                  ),
                ),
                child: SizedBox(
                  height: AppSize.s24,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: BodyMediumText(
                      text: selected == null ? widget.hintText : _title(selected),
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      color: selected == null
                          ? theme.colorScheme.onSurfaceVariant
                          : theme.colorScheme.onSurface,
                      lineHeight: 1.2,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
            if (hasError) ...[
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: BodySmallText(
                  text: fieldState.errorText!,
                  color: theme.colorScheme.error,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
