
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
  final Color? dropdownColor;

  final bool? autoSelect;

  final Function(String)? onItemValue;

  const EkDropDown(
    this.items, {
    Key? key,
    this.label,
    this.fillColor,
    this.selectedItem,
    required this.onItemValue,
    this.enabled = true,
    this.mandatory = false,
    this.borderColor,
    this.prefixIcon,
    this.postfixIcon,
    this.height,
    this.width,
    this.autoSelect = false,
    this.focusNode,
    this.onInitTap,
    this.dropdownColor,
  }) : super(key: key);

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
    return FormField<String>(
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
        return InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: widget.borderColor ??  Colors.grey
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            fillColor: widget.fillColor ?? Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(8),
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            errorStyle: Theme.of(context).textTheme.bodyLarge,
            labelText: widget.mandatory ? "${widget.label} *" : widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),

            ),
          ),
          isEmpty: _selectedItem == widget.label,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: widget.dropdownColor ??  Colors.grey,
              padding: EdgeInsets.zero,
              focusNode: widget.focusNode,
              value: _selectedItem,
              alignment: Alignment.center,
              isExpanded: true,
              style: Theme.of(context).textTheme.bodyMedium,
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
          ),
        );
      },
    );
  }
}
