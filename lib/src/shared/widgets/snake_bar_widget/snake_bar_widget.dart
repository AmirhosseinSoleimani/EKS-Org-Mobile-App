import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class SnakeBarWidget {
  static void _showSnackBarMessage({
    required BuildContext context,
    required String message,
    required Color? backgroundColor,
    required Color? textColor,
    Duration duration = DurationConstant.d4000,
    int? maxLines,
    IconData? leadingIcon,
    EdgeInsets? margin,
    SnackBarBehavior? snackBarBehavior
  }) {
    final theme = Theme.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final bg = backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final fg = textColor ?? theme.colorScheme.onSurface;
    final media = MediaQuery.of(context);
    final bottomInset = media.viewInsets.bottom > 0
        ? media.viewInsets.bottom
        : media.viewPadding.bottom;
    final resolvedMargin = margin ??
        EdgeInsets.fromLTRB(
          AppPadding.p16,
          AppPadding.p0,
          AppPadding.p16,
          bottomInset + AppPadding.p16,
        );
    scaffoldMessenger.hideCurrentSnackBar();
    final snackBar = SnackBar(
      duration: duration,
      behavior: snackBarBehavior ?? SnackBarBehavior.floating,
      elevation: AppSize.s0,
      backgroundColor: bg,
      padding: const EdgeInsets.all(AppPadding.p8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        side: BorderSide(
          color: fg,
          width: 1.5,
        ),
      ),
      margin: resolvedMargin,
      content: _buildSnackBarContent(
        context: context,
        message: message,
        maxLines: maxLines,
        textColor: fg,
        onClose: () =>scaffoldMessenger.hideCurrentSnackBar(),
      ),
    );

    scaffoldMessenger.showSnackBar(snackBar);
  }

  static void showError({
    required BuildContext context,
    required String message,
    SnackBarBehavior? snackBarBehavior,
    int? maxLines,
  }) {
    _showSnackBarMessage(
      context: context,
      message: message,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      textColor: Theme.of(context).colorScheme.error,
      snackBarBehavior: snackBarBehavior,
      maxLines: maxLines,
    );
  }

  static void showSuccess({
    required BuildContext context,
    required message,
    Duration duration = DurationConstant.d4000,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    _showSnackBarMessage(
      context: context,
      message: message,
      backgroundColor: colorScheme.surfaceBright,
      textColor: colorScheme.onError,
      duration: duration,
    );
  }


  static void showNotice({
    required BuildContext context,
    required message,
    Duration duration = DurationConstant.d4000,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    _showSnackBarMessage(
      context: context,
      message: message,
      backgroundColor: colorScheme.surfaceContainer,
      textColor: colorScheme.onSecondaryContainer,
      duration: duration,
    );
  }


  static void showCustomSnackBar({
    required BuildContext context,
    required String message,
    required Color? backgroundColor,
    required Color? textColor,
    required VoidCallback onClose,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: AppSize.s80,
        left: AppPadding.p16,
        right: AppPadding.p16,
        child: Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                    child: message.bodyMedium(context, fontSize: AppSize.s16, color: textColor, overflow: TextOverflow.ellipsis, maxLines: 3),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: textColor, size: AppSize.s20,),
                  onPressed: onClose,
                  padding: EdgeInsets.zero,
                  tooltip: 'بستن',
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(DurationConstant.d4000, () {
      overlayEntry.remove();
    });
  }

  static Widget _buildSnackBarContent({
    required BuildContext context,
    required String message,
    required Color textColor,
    required VoidCallback onClose,
    IconData? leadingIcon,
    int? maxLines,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[
          Icon(leadingIcon, color: textColor, size: AppSize.s20),
          Space.w8,
        ],
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
            child: message.bodyMedium(
                context,
                fontSize: AppSize.s16,
                color: textColor,
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines ?? 10,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: textColor, size: AppSize.s20,),
          onPressed: onClose,
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          tooltip: 'بستن',
        ),
      ],
    );
  }
}
