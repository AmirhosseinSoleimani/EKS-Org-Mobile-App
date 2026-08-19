import 'package:flutter/material.dart';

class LoadingOverlayWidget extends StatelessWidget {
  const LoadingOverlayWidget({
    super.key,
    required this.isLoading,
    required this.child,
    this.indicatorColor,
    this.barrierAlpha = 36,
  });

  final bool isLoading;
  final Widget child;
  final Color? indicatorColor;
  final int barrierAlpha;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    final theme = Theme.of(context);

    return Stack(
      children: [
        child,
        Positioned.fill(
          child: AbsorbPointer(
            child: ColoredBox(
              color: theme.colorScheme.scrim.withAlpha(barrierAlpha),
              child: Center(
                child: CircularProgressIndicator(
                  color: indicatorColor ?? theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
