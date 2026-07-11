import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class CartableSelectionConfirmButton extends StatelessWidget {
  final bool enabled;
  final Future<void> Function() onPressed;

  const CartableSelectionConfirmButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: enabled ? 1 : 0.45,
        child: InkwellButtonWidget(
          title: 'تأیید و تغییر کارتابل',
          onTap: onPressed,
        ),
      ),
    );
  }
}