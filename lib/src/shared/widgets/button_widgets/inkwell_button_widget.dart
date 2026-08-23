import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class InkwellButtonWidget extends StatelessWidget {
  const InkwellButtonWidget({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
    this.splashColor,
    this.borderColor,
    this.titleColor,
    this.buttonPadding,
    this.showLoading,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.textStyle,
    this.loadingColor,
    this.suffixIcon,
    this.prefixIcon,
    this.borderStyle,
    this.borderWidth,
    this.titleMaxLines,
    this.titleOverflow,
  });

  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? splashColor;
  final Color? borderColor;
  final BorderStyle? borderStyle;
  final Color? titleColor;
  final String? title;
  final bool? showLoading;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? buttonPadding;
  final TextStyle? textStyle;
  final Color? loadingColor;
  final double? borderWidth;
  final int? titleMaxLines;
  final TextOverflow? titleOverflow;

  bool get _isLoading => showLoading ?? false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveHeight = height ?? AppSize.s48;
    final effectiveWidth = width ?? double.infinity;
    final effectiveBorderRadius =
        BorderRadius.circular(borderRadius ?? AppSize.s6);

    return SizedBox(
      height: effectiveHeight,
      width: effectiveWidth,
      child: _buildMaterialButton(context, theme, effectiveBorderRadius),
    );
  }

  Widget _buildMaterialButton(
    BuildContext context,
    ThemeData theme,
    BorderRadius borderRadius,
  ) {
    return Material(
      color: onTap == null
          ? theme.colorScheme.onInverseSurface
          : backgroundColor ?? theme.colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          style: borderStyle ?? BorderStyle.solid,
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1,
        ),
      ),
      child: _buildInkWell(context, theme, borderRadius),
    );
  }

  Widget _buildInkWell(
    BuildContext context,
    ThemeData theme,
    BorderRadius borderRadius,
  ) {
    return InkWell(
      borderRadius: borderRadius,
      splashColor:
          splashColor ?? theme.colorScheme.onPrimary.withOpacity(0.1),
      highlightColor: theme.colorScheme.onPrimary.withOpacity(0.05),
      onTap: onTap == null
          ? null
          : () {
              if (_isLoading) return;
              onTap!.call();
            },
      child: _buildButtonContent(context),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    final paddingValue = buttonPadding ?? AppPadding.p8;

    return Padding(
      padding: EdgeInsets.all(paddingValue),
      child: _isLoading
          ? _buildLoadingIndicator(context)
          : _buildTitleText(context),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSize.s28,
        height: AppSize.s28,
        child: CircularProgressIndicator(
          color: loadingColor ?? Theme.of(context).colorScheme.onPrimary,
          strokeWidth: 3,
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    final titleWidget = Text(
      title ?? '',
      maxLines: titleMaxLines,
      overflow: titleOverflow,
      textAlign: TextAlign.center,
      style: _titleStyle(context),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          Space.w8,
        ],
        if (titleMaxLines != null || titleOverflow != null)
          Flexible(child: titleWidget)
        else
          titleWidget,
        if (suffixIcon != null) ...[
          Space.w8,
          suffixIcon!,
        ],
      ],
    );
  }

  TextStyle? _titleStyle(BuildContext context) {
    return textStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
              color: onTap == null
                  ? Theme.of(context).colorScheme.onSecondaryFixed
                  : titleColor ?? Theme.of(context).colorScheme.onPrimary,
            );
  }
}
