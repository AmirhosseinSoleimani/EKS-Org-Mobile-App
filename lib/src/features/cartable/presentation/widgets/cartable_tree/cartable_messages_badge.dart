import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class CartableMessagesBadge extends StatelessWidget {
  final int count;

  const CartableMessagesBadge({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      constraints: const BoxConstraints(
        minWidth: AppSize.s24,
        minHeight: AppSize.s24,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p6,
      ),
      decoration: BoxDecoration(
        color:  Color(0x66F2F2F2),
        borderRadius: BorderRadius.circular(
          AppSize.s20,
        ),
      ),
      child: Text(
        count.toString(),
        style: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.onPrimaryFixed,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}