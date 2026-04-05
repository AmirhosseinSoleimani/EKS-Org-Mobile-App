import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:flutter/material.dart';

enum CloseButtonMode {
  visible,
  hidden,
  onlyIfDismissible,
}

class BaseDialogWidget extends StatelessWidget {
  const BaseDialogWidget._internal({
    super.key,
    this.message,
    this.dismissible,
    this.widget,
    this.borderRadius,
    this.positiveTxt,
    this.cancelFunc,
    this.positiveFunc,
    this.isDialogPop,
    this.isLoading,
    this.buttonColor,
    this.textStyle,
    this.actionWidget,
    this.backgroundColor,
    required this.closeButtonMode
  });

  final String? message;
  final bool? dismissible;
  final Widget? widget;
  final double? borderRadius;
  final String? positiveTxt;
  final VoidCallback? positiveFunc;
  final VoidCallback? cancelFunc;
  final bool? isDialogPop;
  final bool? isLoading;
  final Color? buttonColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Widget? actionWidget;
  final CloseButtonMode closeButtonMode;

  factory BaseDialogWidget.success({
    Key? key,
    required Widget widget,
    required Widget actionWidget,
    Color? backgroundColor,
    TextStyle? textStyle,
    Color? buttonColor,
    bool? isLoading,
    double? borderRadius,
    bool? isDialogPop,
    bool dismissible = true,
  }) {
    return BaseDialogWidget._internal(
      key: key,
      dismissible: dismissible,
      widget: widget,
      actionWidget: actionWidget,
      closeButtonMode: CloseButtonMode.onlyIfDismissible,
      buttonColor: buttonColor,
      isLoading: isLoading,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      isDialogPop: isDialogPop,
    );
  }

  factory BaseDialogWidget.error({
    Key? key,
    String? message,
    bool dismissible = true,
    String? positiveTxt,
    VoidCallback? positiveFunc,
    VoidCallback? cancelFunc,
    Color? backgroundColor,
    TextStyle? textStyle,
    Color? buttonColor,
    bool? isLoading,
    double? borderRadius,
    bool? isDialogPop,
  }) {
    return BaseDialogWidget._internal(
      key: key,
      message: message,
      dismissible: dismissible,
      positiveTxt: positiveTxt,
      positiveFunc: positiveFunc,
      cancelFunc: cancelFunc,
      closeButtonMode: CloseButtonMode.onlyIfDismissible,
      buttonColor: buttonColor,
      isLoading: isLoading,
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      isDialogPop: isDialogPop,
    );
  }


  bool get _shouldShowClose {
    switch (closeButtonMode) {
      case CloseButtonMode.visible:
        return true;
      case CloseButtonMode.hidden:
        return false;
      case CloseButtonMode.onlyIfDismissible:
        return dismissible ?? false;
    }
  }

  Widget _buildCloseButton({required BuildContext context, Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            cancelFunc?.call();
          },
          child: Icon(
            IconManager.close,
            color: color ?? Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildActions({required BuildContext context}) {
    return Center(
      child: InkwellButtonWidget(
        onTap: () {
          if (isDialogPop ?? true) Navigator.of(context).pop();
          positiveFunc?.call();
        },
        title: positiveTxt ?? 'تایئد',
        showLoading: isLoading ?? false,
        height: AppSize.s42,
        backgroundColor: buttonColor ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Text(
          message ?? '',
          textAlign: TextAlign.center,
          style: textStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: AppSize.s14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: dismissible ?? false,
      onPopInvoked: (didPop) {
        if (!didPop && (dismissible ?? false)) {
          Navigator.of(context).pop();
        }
      },
      child: AlertDialog(
        backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s16),
        ),
        actions: [
          actionWidget ?? _buildActions(context: context),
        ],
        content: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_shouldShowClose)_buildCloseButton(context: context),
                if (!_shouldShowClose) Space.h16,
                widget ?? _buildContent(context),
                Space.h24,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
