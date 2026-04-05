import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppPadding.p16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: Border.all(
          color: Theme.of(context).colorScheme.onInverseSurface,
        ),
      ),
      child: child,
    );
  }
}
