import 'package:eks_sana_plus_org/src/features/services/presentation/enums/request_card_operation.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/operation_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'request_operation_tile.dart';

class RequestOperationsBottomSheet extends StatelessWidget {
  final List<RequestCardOperation> operations;
  final Future<void> Function(RequestCardOperation operation)
      onOperationSelected;

  const RequestOperationsBottomSheet({
    super.key,
    required this.operations,
    required this.onOperationSelected,
  });

  static const List<RequestCardOperation> _primaryOrder = [
    RequestCardOperation.requestDetail,
    RequestCardOperation.followUpRegister,
    RequestCardOperation.updateRequest,
    RequestCardOperation.evaluationHistory,
    RequestCardOperation.technicalReportHistory,
    RequestCardOperation.completeIncompleteRequest,
    RequestCardOperation.invoiceModification,
    RequestCardOperation.serviceRequestCopy,
    RequestCardOperation.aidRollbackInvoice,
    RequestCardOperation.homeRollbackInvoice,
    RequestCardOperation.requestPreInvoice,
    RequestCardOperation.emdadgarInvoice,
    RequestCardOperation.changeHomeServiceRequestTime,
    RequestCardOperation.changeHomeServiceRequestAddress,
    RequestCardOperation.aidServiceFactorRegister,
    RequestCardOperation.homeServiceFactorRegister,
    RequestCardOperation.assignEmdadgar,
    RequestCardOperation.externalEmdadNavgan,
    RequestCardOperation.completeUrgentRequest,
    RequestCardOperation.requestControlInfo,
  ];

  static const List<RequestCardOperation> _historyOrder = [
    RequestCardOperation.nonCooperationList,
    RequestCardOperation.kartableCycle,
    RequestCardOperation.requestStatusHistory,
    RequestCardOperation.chassisRequestHistory,
    RequestCardOperation.assignDispatchHistory,
    RequestCardOperation.smsHistory,
    RequestCardOperation.requestImages,
  ];

  static const List<RequestCardOperation> _mapOrder = [
    RequestCardOperation.onlineMap,
  ];

  static const List<RequestCardOperation> _destructiveOrder = [
    RequestCardOperation.cancelEmdadgar,
    RequestCardOperation.cancelRequest,
    RequestCardOperation.cancelExternalEmdadNavgan,
  ];

  @override
  Widget build(BuildContext context) {
    final sections = _buildSections();

    final entries = <OperationBottomSheetEntry>[];

    for (var sectionIndex = 0;
        sectionIndex < sections.length;
        sectionIndex++) {
      final section = sections[sectionIndex];
      for (var itemIndex = 0; itemIndex < section.length; itemIndex++) {
        final operation = section[itemIndex];

        entries.add(
          OperationBottomSheetEntry(
            child: RequestOperationTile(
              operation: operation,
              isDestructive: _destructiveOrder.contains(operation),
              onTap: () => onOperationSelected(operation),
            ),
            dividerAfter: null,
          ),
        );
      }
    }

    return OperationBottomSheet(entries: entries);
  }

  List<List<RequestCardOperation>> _buildSections() {
    final visibleOperations = operations.toSet();
    final orderedOperations = <RequestCardOperation>{
      ..._primaryOrder,
      ..._historyOrder,
      ..._mapOrder,
      ..._destructiveOrder,
    };

    final remainingOperations = operations
        .where((operation) => !orderedOperations.contains(operation))
        .toList(growable: false);

    return [
      _visibleItems(_primaryOrder, visibleOperations),
      _visibleItems(_historyOrder, visibleOperations),
      _visibleItems(_mapOrder, visibleOperations),
      remainingOperations,
      _visibleItems(_destructiveOrder, visibleOperations),
    ].where((section) => section.isNotEmpty).toList(growable: false);
  }

  List<RequestCardOperation> _visibleItems(
    List<RequestCardOperation> order,
    Set<RequestCardOperation> visibleOperations,
  ) {
    return order.where(visibleOperations.contains).toList(growable: false);
  }
}
