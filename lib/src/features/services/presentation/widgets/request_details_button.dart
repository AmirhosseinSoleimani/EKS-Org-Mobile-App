import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class RequestDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RequestDetailsButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.arrow_forward_ios_rounded,
            size: AppSize.s16, color: Theme.of(context).colorScheme.outline),
        iconAlignment: IconAlignment.end,
        label: const BodyMediumText(text: "جزئیات"),
      ),
    );
  }
}
