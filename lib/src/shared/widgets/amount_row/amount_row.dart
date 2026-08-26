import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/utils/invoice_presentation_formatter.dart';
import 'package:flutter/material.dart';

class AmountRow extends StatelessWidget {
  const AmountRow({
    super.key,
    required this.amount,
    this.label,
    this.valueColor,
    this.isEmphasized = false,
    this.showRial = true,
    this.showColon = true,
    this.labelStyle,
    this.valueStyle,
    this.labelFlex = 1,
    this.valueFlex,
    this.spacing = AppSize.s8,
    this.valueAlignment = Alignment.centerLeft,
    this.fitValue = false,
    this.padding = EdgeInsets.zero,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final String? label;
  final num? amount;
  final Color? valueColor;
  final bool isEmphasized;
  final bool showRial;
  final bool showColon;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final int labelFlex;
  final int? valueFlex;
  final double spacing;
  final AlignmentGeometry valueAlignment;
  final bool fitValue;
  final EdgeInsetsGeometry padding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveLabelStyle = labelStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: isEmphasized ? FontWeight.w700 : FontWeight.w500,
        );
    final effectiveValueStyle = (valueStyle ?? theme.textTheme.bodyMedium)?.copyWith(
      color: valueColor ?? valueStyle?.color,
      fontWeight: valueStyle?.fontWeight ??
          (isEmphasized ? FontWeight.w800 : FontWeight.w600),
      fontSize: valueStyle?.fontSize ?? (isEmphasized ? AppSize.s16 : AppSize.s12),
    );

    Widget value = _AmountValue(
      amount: amount,
      showRial: showRial,
      style: effectiveValueStyle,
    );

    if (fitValue) {
      value = FittedBox(
        fit: BoxFit.scaleDown,
        alignment: valueAlignment,
        child: value,
      );
    }

    value = Align(
      alignment: valueAlignment,
      widthFactor: 1,
      child: value,
    );

    if (valueFlex != null) {
      value = Expanded(flex: valueFlex!, child: value);
    }

    final normalizedLabel = label?.trim();
    if (normalizedLabel == null || normalizedLabel.isEmpty) {
      return Padding(
        padding: padding,
        child: value,
      );
    }

    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Expanded(
            flex: labelFlex,
            child: Text(
              showColon ? '$normalizedLabel:' : normalizedLabel,
              style: effectiveLabelStyle,
            ),
          ),
          SizedBox(width: spacing),
          value,
        ],
      ),
    );
  }
}

class _AmountValue extends StatelessWidget {
  const _AmountValue({
    required this.amount,
    required this.showRial,
    required this.style,
  });

  final num? amount;
  final bool showRial;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final amountText = InvoicePresentationFormatter.amount(amount);

    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.rtl,
      children: [
        Text(
          amountText,
          textDirection: TextDirection.ltr,
          style: style,
        ),
        if (showRial && amount != null)
          Text(
            ' ریال',
            textDirection: TextDirection.rtl,
            style: style,
          ),
      ],
    );
  }
}
