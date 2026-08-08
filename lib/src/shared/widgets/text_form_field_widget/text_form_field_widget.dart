import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/value_listenable_builder_widget/value_listenable_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    this.labelText,
    this.controller,
    this.focusNode,
    this.hintText,
    this.readOnly,
    this.mandatory,
    this.prefixIcon,
    this.textInputFormatter,
    this.hintStyle,
    this.hintColor,
    this.textInputType,
    this.textStyle,
    this.onTap,
    this.suffixIcon,
    this.newKey,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textAlign,
    this.backgroundColor,
    this.borderRadius,
    this.cursorColor,
    this.labelStyle,
    this.labelColor,
    this.maxLines,
    this.contentPadding,
    this.autofocus,
    this.textCapitalization,
    this.onSaved,
    this.border,
    this.focusBorder,
    this.errorBorder,
    this.onChanged,
    this.validator,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.maxLength,
    this.textDirection,
    this.borderColor,
    this.obscureText,
  });

  final bool? obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool? readOnly;
  final List<TextInputFormatter>? textInputFormatter;
  final InputBorder? border;
  final InputBorder? focusBorder;
  final InputBorder? errorBorder;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? hintColor;
  final String? labelText;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? textInputType;
  final Key? newKey;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final Color? cursorColor;
  final TextStyle? labelStyle;
  final Color? labelColor;
  final bool? mandatory;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final bool? autofocus;
  final TextCapitalization? textCapitalization;
  final void Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final FloatingLabelBehavior floatingLabelBehavior;
  final int? maxLength;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  final ValueNotifier<bool> _isFocused = ValueNotifier(false);
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  late final bool _ownsFocusNode;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsFocusNode = widget.focusNode == null;
    _ownsController = widget.controller == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    _isFocused.value = _focusNode.hasFocus;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _isFocused.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final backgroundColor =
        widget.backgroundColor ?? Theme.of(context).colorScheme.onPrimary;
    return ValueListenableBuilder2<bool, TextEditingValue>(
      first: _isFocused,
      second: _controller,
      builder: (context, isFocus, textValue, _) {
        final hasText = textValue.text.isNotEmpty;
        final defaultLabelColor =
            isFocus ? colorScheme.primary : colorScheme.onSurface;
        final effectiveLabelColor = widget.labelColor ?? defaultLabelColor;
        return TextFormField(
          onTap: widget.onTap,
          controller: _controller,
          focusNode: _focusNode,
          textAlign: widget.textAlign ?? TextAlign.start,
          textDirection: widget.textDirection,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          cursorHeight: AppSize.s24,
          obscureText: widget.obscureText ?? false,
          cursorColor: widget.cursorColor,
          autofocus: widget.autofocus ?? false,
          key: widget.newKey,
          readOnly: widget.readOnly ?? false,
          maxLines: (widget.obscureText ?? false) ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
          style: widget.textStyle ?? textTheme.bodyMedium,
          decoration: InputDecoration(
            counterText: '',
            errorStyle: textTheme.bodySmall?.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: widget.contentPadding,
            fillColor: backgroundColor,
            filled: true,
            label: widget.labelText == null
                ? null
                : Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.labelText,
                          style: textTheme.bodyMedium?.copyWith(
                            color: effectiveLabelColor,
                          ),
                        ),
                        if (widget.mandatory ?? false)
                          TextSpan(
                            text: ' *',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),

            labelStyle: widget.labelStyle ??
                textTheme.labelMedium?.copyWith(
                color: effectiveLabelColor,
                ),
            hintTextDirection: widget.textDirection,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                textTheme.bodyMedium?.copyWith(color: widget.hintColor),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            enabledBorder: widget.border ?? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? AppSize.s8),
                    borderSide: BorderSide(
                        width: AppSize.s1,
                        color: hasText ? colorScheme.onSecondaryFixed : colorScheme.inverseSurface,
                    ),
                ),
            focusedBorder: widget.focusBorder ?? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? AppSize.s8),
                    borderSide: BorderSide(
                        width: AppSize.s1,
                        color: (widget.borderColor ?? colorScheme.primary),
                    ),
            ),
            errorBorder: widget.errorBorder ?? OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? AppSize.s8),
              borderSide: BorderSide(
                width: AppSize.s1,
                color: colorScheme.error,
              ),
            ),
            focusedErrorBorder: widget.errorBorder ?? OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? AppSize.s8),
              borderSide: BorderSide(
                width: AppSize.s1,
                color: colorScheme.error,
              ),
            ),
          ),
          inputFormatters: widget.textInputFormatter,
          validator: widget.validator,
          onSaved: widget.onSaved,
        );
      },
    );
  }
}
