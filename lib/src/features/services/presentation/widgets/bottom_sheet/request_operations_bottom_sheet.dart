import 'package:eks_sana_plus_org/src/features/services/presentation/enums/request_card_operation.dart';
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
    RequestCardOperation.followUpRegister,
    RequestCardOperation.updateRequest,
    RequestCardOperation.evaluationHistory,
    RequestCardOperation.requestPreInvoice,
    RequestCardOperation.emdadgarInvoice,
    RequestCardOperation.changeHomeServiceRequestTime,
    RequestCardOperation.changeHomeServiceRequestAddress,
    RequestCardOperation.aidServiceFactorRegister,
    RequestCardOperation.homeServiceFactorRegister,
    RequestCardOperation.assignEmdadgar,
    RequestCardOperation.completeUrgentRequest,
    RequestCardOperation.requestDetail,
    RequestCardOperation.requestControlInfo,
  ];

  static const List<RequestCardOperation> _historyOrder = [
    RequestCardOperation.nonCooperationList,
    RequestCardOperation.kartableCycle,
    RequestCardOperation.requestStatusHistory,
    RequestCardOperation.chassisRequestHistory,
  ];

  static const List<RequestCardOperation> _mapOrder = [
    RequestCardOperation.onlineMap,
  ];

  static const List<RequestCardOperation> _destructiveOrder = [
    RequestCardOperation.cancelEmdadgar,
    RequestCardOperation.cancelRequest,
  ];

  @override
  Widget build(BuildContext context) {
    final sections = _buildSections();
    final maxHeight = MediaQuery.sizeOf(context).height * 0.82;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              _buildDragHandle(context),
              const SizedBox(height: 10),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var index = 0;
                          index < sections.length;
                          index++) ...[
                        if (index > 0) _buildDivider(context),
                        ...sections[index].map(
                          (operation) => RequestOperationTile(
                            operation: operation,
                            isDestructive:
                                _destructiveOrder.contains(operation),
                            onTap: () => onOperationSelected(operation),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context) {
    return Container(
      width: 76,
      height: 5,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(20),
      ),
    );
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

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).dividerColor,
    );
  }
}
