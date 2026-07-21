import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class FormSectionContainer extends StatelessWidget {
  final Widget child;
  final bool hasBorder;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const FormSectionContainer({
    super.key,
    required this.child,
    this.hasBorder = false,
    this.padding, this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: AppSize.s12),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: AppSize.s16,
          vertical:  AppSize.s24),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        border: hasBorder ? Border.all(width: 1, color: Colors.grey.shade300) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
