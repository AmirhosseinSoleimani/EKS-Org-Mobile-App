import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class CartableSelectionHeader extends StatelessWidget {
  final VoidCallback onClose;

  const CartableSelectionHeader({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BodyMediumText(
          text: 'انتخاب کارتابل',
          fontWeight: FontWeight.w700,
        ),
        InkResponse(
          onTap: onClose,
          radius: AppSize.s20,
          child: Icon(
            Icons.close_rounded,
            size: AppSize.s20,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}