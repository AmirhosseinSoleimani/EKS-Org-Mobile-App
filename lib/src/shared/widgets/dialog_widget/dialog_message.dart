import 'package:eks_sana_plus_org/src/shared/widgets/dialog_widget/dialog_data_model.dart';
import 'package:flutter/material.dart';

import 'dialog_widgets.dart';

class DialogMessage {
  static void showError({required BuildContext context, required DialogDataModel dialog, Color? buttonColor}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => BaseDialogWidget.error(
        buttonColor: buttonColor,
        dismissible: false,
        message: dialog.description,
        positiveTxt: 'تائید',
      ),
    );
  }

  static void showErrorWithAction({required BuildContext context, required DialogDataModel dialog, Color? buttonColor, VoidCallback? positiveFunc,}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => BaseDialogWidget.error(
        buttonColor: buttonColor,
        dismissible: false,
        message: dialog.description,
        positiveFunc: positiveFunc,
        positiveTxt: 'تائید',
      ),
    );
  }

  static void showNotice({required BuildContext context, required DialogDataModel dialog, Color? buttonColor}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => BaseDialogWidget.error(
        dismissible: true,
        buttonColor: buttonColor,
        message: dialog.description,
        positiveTxt: 'تائید',
      ),
    );
  }

  static void showNoticeWithAction({required BuildContext context, required DialogDataModel dialog, VoidCallback? positiveFunc, Color? buttonColor, String? buttonText,}) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => BaseDialogWidget.error(
        dismissible: true,
        message: dialog.description,
        positiveTxt: buttonText ?? 'تائید',
        positiveFunc: positiveFunc,
        buttonColor: buttonColor ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }

  static void showCustomWidget({required BuildContext context, Widget? widget, Widget? actionButton, bool? dismissible}) {
    showDialog(
      barrierDismissible: dismissible ?? true,
      context: context,
      builder: (_) => BaseDialogWidget.success(
        widget: widget ?? const SizedBox(),
        actionWidget: actionButton ?? const SizedBox(),
        dismissible: dismissible ?? true,
      ),
    );
  }
}
