import 'package:eks_sana_plus_org/src/features/services/presentation/enums/request_card_operation.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_action_tile.dart';
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
    return BottomSheetActionTile(
      icon: operation.icon,
      title: _resolveLabel(operation),
      isDestructive: isDestructive,
      onTap: onTap,
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
