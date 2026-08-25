import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/title_medium_text.dart';
import 'package:flutter/material.dart';

class DeleteConfirmSheet extends StatefulWidget {
  const DeleteConfirmSheet._({
    super.key,
    required this.title,
    required this.message,
    required this.confirmTitle,
    required this.onConfirm,
    this.icon = Icons.delete_forever_outlined,
    this.iconColor,
    this.iconBackgroundColor,
    this.messageMaxLines = 4,
  });

  final String title;
  final String message;
  final String confirmTitle;
  final Future<void> Function() onConfirm;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final int? messageMaxLines;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmTitle,
    required Future<void> Function() onConfirm,
    IconData icon = Icons.delete_forever_outlined,
    Color? iconColor,
    Color? iconBackgroundColor,
    int? messageMaxLines = 4,
    bool isDismissible = false,
    bool enableDrag = false,
  }) async {
    await BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      actionWidget: const SizedBox.shrink(),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      content: DeleteConfirmSheet._(
        title: title,
        message: message,
        confirmTitle: confirmTitle,
        icon: icon,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
        messageMaxLines: messageMaxLines,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<DeleteConfirmSheet> createState() => _DeleteConfirmSheetState();
}

class _DeleteConfirmSheetState extends State<DeleteConfirmSheet> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p8,
          vertical: AppPadding.p4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSize.s64,
              height: AppSize.s64,
              decoration: BoxDecoration(
                color: widget.iconBackgroundColor ??
                    theme.colorScheme.error.withOpacity(0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: widget.iconColor ?? theme.colorScheme.error,
                size: AppSize.s34,
              ),
            ),
            Space.h24,
            TitleMediumText(
              text: widget.title,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w800,
            ),
            Space.h12,
            BodyMediumText(
              text: widget.message,
              textAlign: TextAlign.center,
              color: theme.colorScheme.onSurfaceVariant,
              lineHeight: 1.8,
              maxLines: widget.messageMaxLines,
              textOverflow: TextOverflow.ellipsis,
            ),
            Space.h24,
            InkwellButtonWidget(
              title: widget.confirmTitle,
              backgroundColor: theme.colorScheme.error,
              showLoading: _isSubmitting,
              onTap: _isSubmitting ? (){} : _handleConfirm,
            ),
            Space.h12,
            InkwellButtonWidget(
              title: 'انصراف',
              backgroundColor: theme.colorScheme.onPrimary,
              borderWidth: 2,
              borderColor: const Color(0x48626E33).withAlpha(25),
              titleColor: const Color(0xFF48626E),
              onTap: _isSubmitting ? null : () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleConfirm() async {
    if (_isSubmitting) return;

    final route = ModalRoute.of(context);
    setState(() => _isSubmitting = true);

    try {
      await widget.onConfirm();
    } finally {
      if (!mounted || route == null || !route.isActive) return;

      final navigator = route.navigator;
      if (route.isCurrent) {
        navigator?.pop();
      } else {
        // Keep a newer error bottom sheet visible and remove only the
        // confirmation sheet underneath it.
        navigator?.removeRoute(route);
      }
    }
  }
}
