import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class FormSectionContainer extends StatelessWidget {
  final Widget child;

  const FormSectionContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSize.s12),
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16,
          vertical:  AppSize.s24),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
