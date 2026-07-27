import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_sheet_message_model.dart';
import 'bottom_sheet_widget.dart';

class BottomSheetMessage {
  BottomSheetMessage._();

  static Future<BottomSheetAction?> showCustom({
    required BuildContext context,
    required Widget content,
    Widget? actionWidget,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useRootNavigator = false,
    Color? barrierColor,
    double? topRadius,
    Color? backgroundColor,
    VoidCallback? onDismiss,
    double? maxHeight,
  }) {
    return _showSheet(
        context: context,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        useRootNavigator: useRootNavigator,
        barrierColor: barrierColor,
        onDismiss: onDismiss,
        builder: (_) => BottomSheetWidget(
          dismissible: false,
          contentWidget: content,
          actionWidget: actionWidget,
          backgroundColor: backgroundColor,
          borderRadius: topRadius,
          maxHeight: maxHeight,
        )
    );
  }

  static Future<T?> showFullScreenCustom<T>({
    required BuildContext context,
    required Widget content,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useRootNavigator = false,
    Color? barrierColor,
    Color? backgroundColor,
    double heightFactor = 1,
    double topRadius = 0,
    VoidCallback? onDismiss,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      useRootNavigator: useRootNavigator,
      barrierColor: barrierColor,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return PopScope(
          canPop: isDismissible,
          child: FractionallySizedBox(
            heightFactor: heightFactor,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(topRadius),
              ),
              child: ColoredBox(
                color: backgroundColor ?? Theme.of(context).colorScheme.surface,
                child: content,
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      if (onDismiss != null) onDismiss();
    });
  }

  static Future<BottomSheetAction?> showNotice({
    required BuildContext context,
    required BottomSheetMessageModel data,
    bool isDismissible = true,
    bool enableDrag = true,
    String positiveText = 'تائید',
    Color? buttonColor,
    VoidCallback? onPositive,
  }) {
    final theme = Theme.of(context);
    return _showSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (_) => BottomSheetWidget(
        dismissible: isDismissible,
        title: data.title,
        message: data.message,
        positiveTxt: positiveText,

        buttonColor: buttonColor ?? theme.colorScheme.primary,
        positiveFunc: () {
          context.pop();
          if (onPositive != null) {
            onPositive();
          }
        },

      ),
    );
  }

  static Future<BottomSheetAction?> showNoticeWithAction({
    required BuildContext context,
    required BottomSheetMessageModel data,
    VoidCallback? onPositive,
    VoidCallback? cancelFunc,
    String positiveText = 'تایید',
    String cancelTxt = 'بستن',
    bool isDismissible = true,
    bool enableDrag = true,
    Color? buttonColor,
  }) {
    final theme = Theme.of(context);
    return _showSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (_) => BottomSheetWidget(
        dismissible: isDismissible,
        title: data.title,
        message: data.message,
        positiveTxt: positiveText,
        positiveFunc: onPositive,
        buttonColor: buttonColor ?? theme.colorScheme.primary,
        cancelFunc: cancelFunc,
        cancelTxt: cancelTxt,
      ),
    );
  }

  static Future<BottomSheetAction?> showError({
    required BuildContext context,
    required BottomSheetMessageModel data,
    bool isDismissible = false,
    bool enableDrag = false,
    String positiveText = 'تایید',
    onButtonTap,
  }) {
    final theme = Theme.of(context);
    return _showSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (_) => BottomSheetWidget(
        dismissible: isDismissible,
        title: data.title,
        message: data.message,
        positiveTxt: positiveText,
        buttonColor: theme.colorScheme.error,
        positiveFunc: onButtonTap,contentWidget: const SizedBox(),
      ),
    );
  }

  static Future<BottomSheetAction?> showErrorWithAction({
    required BuildContext context,
    required BottomSheetMessageModel data,
    VoidCallback? onPositive,
    VoidCallback? onCancel,
    String positiveText = 'تلاش مجدد',
    bool isDismissible = true,
    bool enableDrag = true,
    Color? buttonColor,
  }) {
    final theme = Theme.of(context);
    return _showSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (_) => BottomSheetWidget(
        dismissible: isDismissible,
        title: data.title,
        message: data.message,
        positiveTxt: positiveText,
        positiveFunc: onPositive,
        cancelFunc: onCancel,
        buttonColor: buttonColor ?? theme.colorScheme.error,
      ),
    );
  }

  static Future<BottomSheetAction?> _showSheet({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = true,
    bool enableDrag = true,
    bool useRootNavigator = false,
    Color? barrierColor,
    VoidCallback? onDismiss,
  }) {
    return showModalBottomSheet<BottomSheetAction>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      useRootNavigator: useRootNavigator,
      barrierColor: barrierColor,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return PopScope(
          canPop: isDismissible,
          onPopInvoked: (didPop) {
            if (!didPop && isDismissible) {
              Navigator.of(ctx).pop(BottomSheetAction.dismissed);
            }
          },
          child: builder(ctx),
        );
      },
    ).whenComplete(() {
      if (onDismiss != null) onDismiss();
    });
  }
}
