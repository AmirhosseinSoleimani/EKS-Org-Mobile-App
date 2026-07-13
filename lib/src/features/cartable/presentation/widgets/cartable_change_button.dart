import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
class CartableChangeButton extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color textColor;
  final bool isLoading;
  final VoidCallback? onTap;

  const CartableChangeButton({
    super.key,
    required this.title,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? () {} : onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 105,
            minHeight: 40,
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.s12,
            vertical: AppSize.s8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isLoading
                ? SizedBox(
              key: const ValueKey('loading'),
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: textColor,
              ),
            )
                : Text(
              title,
              key: const ValueKey('title'),
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}