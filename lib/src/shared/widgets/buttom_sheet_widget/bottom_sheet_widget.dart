import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  final String title;
  final String message;
  final Widget? actionWidget;
  final Widget? contentWidget;
  final double? borderRadius;
  final Color? buttonColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final String? positiveTxt;
  final String? cancelTxt;
  final VoidCallback? positiveFunc;
  final VoidCallback? cancelFunc;
  final bool? isLoading;
  final bool? isSheetPop;
  final bool? dismissible;

  const BottomSheetWidget({
    super.key,
    this.title = '',
    this.message = '',
    this.contentWidget,
    this.actionWidget,
    this.borderRadius,
    this.buttonColor,
    this.backgroundColor,
    this.textStyle,
    this.positiveTxt,
    this.cancelTxt,
    this.positiveFunc,
    this.cancelFunc,
    this.isLoading,
    this.isSheetPop,
    this.dismissible,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    final maxHeight = media.size.height * 0.7;

    final hasTitle = title.trim().isNotEmpty;
    final hasMessage = message.trim().isNotEmpty;
    final hasContent = contentWidget != null;
    final hasCustomActions = actionWidget != null;

    const horizontal = AppPadding.p16;
    const top = AppPadding.p8;
    const bottom = AppPadding.p16;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: media.viewInsets,
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: maxHeight),
          decoration: BoxDecoration(
            color: backgroundColor ?? theme.colorScheme.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius ?? AppSize.s24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Padding(
                padding: const EdgeInsets.only(
                  left: horizontal,
                  right: horizontal,
                  top: top,
                ),
                child: Column(
                  children: [
                    _buildDragHandle(context),
                    const SizedBox(height: 12),

                    if (hasTitle)
                      _CenteredText(
                        text: title.trim(),
                        style: (textStyle ??
                            theme.textTheme.titleMedium?.copyWith(
                              fontSize: AppSize.s18,
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.onSurface,
                            )) ??
                            const TextStyle(),
                      ),

                    if (hasTitle && hasMessage) const SizedBox(height: 10),

                    if (hasMessage)
                      _CenteredText(
                        text: message.trim(),
                        style: (textStyle ??
                            theme.textTheme.bodyMedium?.copyWith(
                              fontSize: AppSize.s16,
                              height: 1.35,
                              color: theme.colorScheme.onSurfaceVariant,
                            )) ??
                            const TextStyle(),
                      ),
                  ],
                ),
              ),

              if (!hasContent) const SizedBox(height: 8),

              if (hasContent)
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      horizontal,
                      12,
                      horizontal,
                      12,
                    ),
                    child: contentWidget!,
                  ),
                ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  horizontal,
                  8,
                  horizontal,
                  bottom,
                ),
                child: hasCustomActions
                    ? actionWidget!
                    : _buildActions(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context) {
    return SizedBox(
      width: AppSize.s80,
      height: AppSize.s6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary.withAlpha(100),
          borderRadius: BorderRadius.circular(AppSize.s32),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final showCancel = dismissible ?? false;

    return Row(
      children: [
        Expanded(child: _buildActionButton(context)),
        if (showCancel) ...[
          const SizedBox(width: AppSize.s12),
          Expanded(child: _buildCancelButton(context)),
        ],
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    final theme = Theme.of(context);
    final loading = isLoading ?? false;

    return SizedBox(
      height: AppSize.s48,
      child: ElevatedButton(
        style: _buildButtonStyle(
          backgroundColor: buttonColor ?? theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
        ),
        onPressed: loading
            ? null
            : () {
          positiveFunc?.call();
        },
        child: loading
            ? const SizedBox(
          width: AppSize.s20,
          height: AppSize.s20,
          child: CircularProgressIndicator(strokeWidth: AppSize.s2),
        )
            : _NoWrapButtonText(
          text: positiveTxt ?? 'تایید',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: AppSize.s48,
      child: ElevatedButton(
        style: _buildButtonStyle(
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.surface,
          borderColor: theme.colorScheme.error,
        ),
        onPressed: () {
          Navigator.pop(context);
          cancelFunc?.call();
        },
        child: _NoWrapButtonText(
          text: cancelTxt ?? 'انصراف',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.error,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  ButtonStyle _buildButtonStyle({
    required Color backgroundColor,
    required Color foregroundColor,
    Color? borderColor,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
        side: borderColor != null ? BorderSide(color: borderColor) : BorderSide.none,
      ),
    );
  }
}

class _CenteredText extends StatelessWidget {
  const _CenteredText({required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: style,
      ),
    );
  }
}

class _NoWrapButtonText extends StatelessWidget {
  const _NoWrapButtonText({required this.text, required this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: style,
      ),
    );
  }
}
