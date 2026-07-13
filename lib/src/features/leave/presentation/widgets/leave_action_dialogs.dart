import 'package:eks_sana_plus_org/src/shared/resources/color_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

class LeaveActionDialogs {
  const LeaveActionDialogs._();

  static Future<bool> confirmApprove(BuildContext context) async {
    return await _confirm(
          context: context,
          title: 'توجه',
          message: 'آیا مرخصی مورد نظر تایید شود؟',
          positiveText: 'بله',
          positiveColor: const Color(0xFF59B45C),
        ) ??
        false;
  }

  static Future<bool> confirmRollback(BuildContext context) async {
    return await _confirm(
          context: context,
          title: 'توجه',
          message: 'آیا وضعیت مرخصی به ثبت شده تغییر کند؟',
          positiveText: 'تغییر وضعیت',
          positiveColor: const Color(0xFFE5A000),
        ) ??
        false;
  }

  static Future<String?> rejectionReason(BuildContext context) async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('رد درخواست', textAlign: TextAlign.right),
          content: TextField(
            controller: controller,
            minLines: 3,
            maxLines: 5,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'علت رد درخواست را وارد کنید',
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('انصراف'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: ColorLightManager.error,
              ),
              onPressed: () {
                final text = controller.text.trim();
                if (text.isEmpty) return;
                Navigator.of(dialogContext).pop(text);
              },
              child: const Text('رد درخواست'),
            ),
          ],
        );
      },
    );

    controller.dispose();
    return result;
  }

  static Future<bool?> _confirm({
    required BuildContext context,
    required String title,
    required String message,
    required String positiveText,
    required Color positiveColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title, textAlign: TextAlign.right),
          content: Text(message, textAlign: TextAlign.right),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('انصراف'),
            ),
            SizedBox(
              width: 132,
              child: InkwellButtonWidget(
                title: positiveText,
                backgroundColor: positiveColor,
                height: 42,
                onTap: () => Navigator.of(dialogContext).pop(true),
              ),
            ),
          ],
        );
      },
    );
  }
}

