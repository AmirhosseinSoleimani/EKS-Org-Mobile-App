
import 'package:flutter/material.dart';

class EkDropDown extends StatefulWidget {
  final String? label;
  final List<String> items;
  final String? selectedItem;
  final bool mandatory;
  final bool enabled;
  final FocusNode? focusNode;
  final Color? borderColor;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? postfixIcon;
  final double? height;
  final double? width;
  final Function? onInitTap;
  final VoidCallback? onTap;
  final Color? dropdownColor;

  final bool? autoSelect;

  final Function(String)? onItemValue;

  const EkDropDown(
    this.items, {
    super.key,
    this.label,
    this.fillColor,
    this.selectedItem,
    required this.onItemValue,
    this.enabled = true,
    this.mandatory = false,
    this.borderColor,
    this.prefixIcon,
    this.postfixIcon,
    this.height = 50,
    this.width,
    this.autoSelect = false,
    this.focusNode,
    this.onInitTap,
    this.onTap,
    this.dropdownColor,
  });

  @override
  _EkDropDownState createState() => _EkDropDownState();
}

class _EkDropDownState extends State<EkDropDown> {
  String? _selectedItem;
  final List<String> _items = [];

  @override
  void initState() {
    _items.addAll(widget.items);

    if (widget.selectedItem != null) {
      if (_items
          .where((element) => element == widget.selectedItem)
          .isNotEmpty) {
        _selectedItem = widget.selectedItem;
      } else {
        _selectedItem = _items[0];
      }
    } else {
      _selectedItem = _items[0];
    }

    if(widget.onInitTap!=null){
      widget.onInitTap!();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant EkDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.fillColor,
      height: widget.height,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          if (widget.label!.isEmpty) {
            return DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                focusNode: widget.focusNode,
                value: _selectedItem,
                alignment: Alignment.center,
                isExpanded: true,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                onTap: widget.onTap,
                onChanged: (String? newValue) {
                  if (newValue != '') {
                    widget.onItemValue!(newValue!);
                  } else {
                    widget.onItemValue!('');
                  }
                  setState(() {
                    _selectedItem = newValue;
                    state.didChange(newValue);
                  });
                },
                items: _items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            );
          }
          return  InputDecorator(
            decoration: InputDecoration(
              labelText: widget.mandatory
                  ? "${widget.label} *"
                  : widget.label,

              labelStyle: Theme.of(context).textTheme.bodyMedium,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.2,
                ),
              ),

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),

              suffixIcon: IconTheme.merge(
                data: IconThemeData(
                  size: 22,
                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                ),
                child: widget.postfixIcon ??
                    const Icon(Icons.keyboard_arrow_down_rounded),
              ),

              prefixIcon: widget.prefixIcon == null
                  ? null
                  : IconTheme.merge(
                      data: IconThemeData(
                        size: 22,
                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                      ),
                      child: widget.prefixIcon!,
                    ),
            ),

            isEmpty: _selectedItem == null || _selectedItem!.isEmpty,

            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: widget.dropdownColor ?? Colors.white,
                padding: EdgeInsets.zero,
                focusNode: widget.focusNode,
                value: _selectedItem,
                isExpanded: true,
                icon: SizedBox(),
                style: Theme.of(context).textTheme.bodyMedium,

                onTap: widget.onTap,
                onChanged: (String? newValue) {
                  widget.onItemValue?.call(newValue ?? '');

                  setState(() {
                    _selectedItem = newValue;
                  });
                },

                items: _items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
