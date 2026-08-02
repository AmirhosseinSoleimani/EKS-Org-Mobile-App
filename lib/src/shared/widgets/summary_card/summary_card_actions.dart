import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/operation_button.dart';
import 'package:flutter/material.dart';

class SummaryCardActions extends StatelessWidget {
  const SummaryCardActions({
    super.key,
    this.primaryAction,
    this.onOperation,
    this.isOperationLoading = false,
    this.primaryActionFlex = 56,
    this.operationActionFlex = 44,
    this.spacing = 16,
  });

  final Widget? primaryAction;
  final VoidCallback? onOperation;
  final bool isOperationLoading;
  final int primaryActionFlex;
  final int operationActionFlex;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final operationButton = onOperation == null
        ? null
        : OperationButton(
            isLoading: isOperationLoading,
            onTap: isOperationLoading ? () {} : onOperation!,
          );

    print(operationButton);
    if (primaryAction != null && operationButton != null) {

      return Row(
        children: [
          Flexible(flex: primaryActionFlex, child: primaryAction!),
          SizedBox(width: spacing),
          Expanded(flex: operationActionFlex, child: operationButton),
        ],
      );
    }

    return primaryAction ?? operationButton ?? const SizedBox.shrink();
  }
}
