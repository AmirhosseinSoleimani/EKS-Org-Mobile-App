import 'package:eks_sana_plus_org/src/features/services/presentation/enums/request_card_operation.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';

class RequestOperationTile extends StatelessWidget {
  final RequestCardOperation operation;
  final VoidCallback onTap;
  final bool isDestructive;

  const RequestOperationTile({
    super.key,
    required this.operation,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = isDestructive
        ? colorScheme.error
        : colorScheme.secondaryFixed;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 44,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(
                  operation.icon,
                  size: 22,
                  color: foregroundColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BodyMediumText(
                    text: _resolveLabel(operation),
                    color: foregroundColor,
                    fontWeight: FontWeight.w500 ,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _resolveLabel(RequestCardOperation operation) {
    switch (operation) {
      case RequestCardOperation.nonCooperationList:
        return 'لیست عدم همکاری درخواست';
      case RequestCardOperation.requestStatusHistory:
        return 'تاریخچه وضعیت درخواست';
      case RequestCardOperation.cancelEmdadgar:
        return 'لغو توسط امدادرسان';
      default:
        return operation.label;
    }
  }
}
