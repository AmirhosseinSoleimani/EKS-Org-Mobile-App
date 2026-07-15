import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RescuerActionsBottomSheet extends StatelessWidget {
  final VoidCallback onDelete;
  final bool isDeleting;

  const RescuerActionsBottomSheet({
    super.key,
    required this.onDelete,
    required this.isDeleting,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.settings_outlined, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 8),
            const Expanded(
              child: BodyMediumText(
                text: 'عملیات امدادرسان',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        InkwellButtonWidget(
          title: 'حذف امدادرسان',
          backgroundColor: colorScheme.error,
          showLoading: isDeleting,
          prefixIcon: Icon(
            Icons.delete_outline,
            color: colorScheme.onError,
          ),
          onTap: isDeleting
              ? null
              : () {
                  context.pop();
                  onDelete();
                },
        ),
      ],
    );
  }
}
