import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class CartableSelectionConfirmButton extends StatelessWidget {
  final String title;
  final bool enabled;
  final bool isLoading;
  final Future<void> Function() onPressed;

  const CartableSelectionConfirmButton({
    super.key,
    required this.enabled,
    required this.onPressed,
    this.title = 'تأیید و تغییر کارتابل',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? () async {} : onPressed;

    return IgnorePointer(
      ignoring: !enabled,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: enabled ? 1 : 0.45,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkwellButtonWidget(
              title: isLoading ? '' : title,
              onTap: effectiveOnPressed,
            ),
            if (isLoading)
              const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}