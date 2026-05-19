import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class SubmitCancelButtons extends StatelessWidget {
  final String submitTitle;
  final Color submitButtonColor;
  final String cancelTitle;
  final bool isLoading;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;

  const SubmitCancelButtons({
    super.key,
    required this.submitTitle,
    required this.submitButtonColor,
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
            backgroundColor: submitButtonColor,
            showLoading: isLoading,
            onTap: onSubmit,
          )
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
