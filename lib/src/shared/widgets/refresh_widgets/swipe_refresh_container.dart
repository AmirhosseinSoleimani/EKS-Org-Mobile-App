import 'package:flutter/material.dart';

/// Keeps pull-to-refresh available even when a list has no scrollable content.
///
/// Use this for empty/error states that belong to a refreshable list page.
/// Loaded lists should still wrap their own scrollable with [RefreshIndicator].
class SwipeRefreshContainer extends StatelessWidget {
  const SwipeRefreshContainer({
    super.key,
    required this.onRefresh,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : 0.0;

        return RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: padding,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: child,
              ),
            ],
          ),
        );
      },
    );
  }
}
