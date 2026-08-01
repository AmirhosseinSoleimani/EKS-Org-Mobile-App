import 'dart:async';

import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/enums/request_card_operation.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/bottom_sheet/request_operations_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'request_header.dart';
import 'request_info_row.dart';

class RequestCard extends StatelessWidget {
  final BaseRequestEntity request;
  final String serviceTitle;
  final Color serviceColor;
  final IconData serviceIcon;
  final FutureOr<void> Function(BaseRequestEntity) onSelected;
  final FutureOr<void> Function()? onRefreshAfterReturn;

  const RequestCard({
    super.key,
    required this.request,
    required this.serviceTitle,
    required this.serviceColor,
    required this.serviceIcon,
    required this.onSelected,
    required this.onRefreshAfterReturn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RequestHeader(request: request),
          const SizedBox(height: 16),
          _buildInfoList(),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.tertiaryFixed,
          ),
          const SizedBox(height: 12),
          _buildOperationsButton(context),
        ],
      ),
    );
  }

  Widget _buildInfoList() {
    return Column(
      children: [
        RequestInfoRow(
          icon: Icons.person,
          text: '${request.firstName} ${request.lastName}',
        ),
        const SizedBox(height: 8),
        RequestInfoRow(
          icon: Icons.location_on,
          text: request.aidAddress ?? '',
        ),
        const SizedBox(height: 8),
        RequestInfoRow(
          icon: Icons.check_circle,
          text: '${request.carName} - ${request.licensePlate}',
        ),
        const SizedBox(height: 8),
        RequestInfoRow(
          icon: Icons.settings,
          text: serviceTitle,
        ),
      ],
    );
  }

  Widget _buildOperationsButton(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _showOperationsBottomSheet(context),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.apps, size: 22),
              SizedBox(width: 6),
              BodyMediumText(text: 'عملیات'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showOperationsBottomSheet(BuildContext context) async {
    final operations = RequestCardOperation.values
        .where((operation) => operation.isVisible(request))
        .toList(growable: false);

    if (operations.isEmpty) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return RequestOperationsBottomSheet(
          operations: operations,
          onOperationSelected: (operation) => _openOperation(
            pageContext: context,
            bottomSheetContext: bottomSheetContext,
            operation: operation,
          ),
        );
      },
    );
  }

  Future<void> _openOperation({
    required BuildContext pageContext,
    required BuildContext bottomSheetContext,
    required RequestCardOperation operation,
  }) async {
    Navigator.of(bottomSheetContext).pop();

    await Future.sync(() => onSelected(request));
    if (!pageContext.mounted) return;

    await pageContext.push(operation.route, extra: request.id);
    if (!pageContext.mounted) return;

    await Future.sync(() => onRefreshAfterReturn?.call());
  }
}
