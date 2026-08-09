import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/operation_button.dart';
import 'package:flutter/material.dart';

class SummaryCardActions extends StatelessWidget {
  const SummaryCardActions({
    super.key,
    this.primaryAction,
    this.operationAction,
    this.onOperation,
    this.isOperationLoading = false,
    this.primaryActionFlex = 56,
    this.operationActionFlex = 44,
    this.spacing = 16,
  });

  final Widget? primaryAction;

  /// Use this when the second action has a custom UI.
  ///
  /// If it is null, [onOperation] keeps the previous behavior and renders
  /// the shared [OperationButton].
  final Widget? operationAction;

  final VoidCallback? onOperation;
  final bool isOperationLoading;
  final int primaryActionFlex;
  final int operationActionFlex;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final secondaryAction = operationAction ?? _buildOperationButton();

    if (primaryAction != null && secondaryAction != null) {
      return Row(
        children: [
          Expanded(
            flex: primaryActionFlex,
            child: primaryAction!,
          ),
          SizedBox(width: spacing),
          Expanded(
            flex: operationActionFlex,
            child: secondaryAction,
          ),
        ],
      );
    }

    return primaryAction ?? secondaryAction ?? const SizedBox.shrink();
  }

  Widget? _buildOperationButton() {
    if (onOperation == null) return null;

    return OperationButton(
      isLoading: isOperationLoading,
      onTap: isOperationLoading ? () {} : onOperation!,
    );
  }
}
