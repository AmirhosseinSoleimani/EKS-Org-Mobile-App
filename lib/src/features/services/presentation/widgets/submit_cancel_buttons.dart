import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class SubmitCancelButtons extends StatelessWidget {
  final String submitTitle;
  final String cancelTitle;
  final bool isLoading;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;

  const SubmitCancelButtons({
    super.key,
    required this.submitTitle,
    this.isLoading = false,
    this.onSubmit,
    this.onCancel,
    this.cancelTitle = 'انصراف',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 60,
          child: InkwellButtonWidget(
            title: submitTitle,
            showLoading: isLoading,
            onTap: onSubmit,
          )/*InkWell(
            onTap: isLoading ? (){} : onSubmit,
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 48,
              decoration: BoxDecoration(
                color: isLoading
                    ? Colors.grey.shade300
                    : (onSubmit == null
                          ? Colors.grey.shade400
                          : Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(
                      submitTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          )*/
        ),

        const SizedBox(width: 12),

        Expanded(
          flex: 40,
          child: TextButton(
            onPressed: isLoading ? null : onCancel,
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey.shade600,
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              cancelTitle,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
