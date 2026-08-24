import 'dart:async';

import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/enums/request_card_operation.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/bottom_sheet/request_operations_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/request_operation_access_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/summary_card/summary_card_actions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'request_header.dart';
import 'request_info_row.dart';

class RequestCard extends StatelessWidget {
  final BaseRequestEntity request;
  final String serviceTitle;
  final Color serviceColor;
  final IconData serviceIcon;
  final RequestOperationAccessEntity operationAccess;
  final FutureOr<void> Function(BaseRequestEntity) onSelected;
  final FutureOr<void> Function()? onRefreshAfterReturn;

  const RequestCard({
    super.key,
    required this.request,
    required this.serviceTitle,
    required this.serviceColor,
    required this.serviceIcon,
    required this.operationAccess,
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
          SummaryCardActions(
            operationActionFlex: 50,
            primaryActionFlex: 50,
            primaryAction: operationAccess.canView
                ? InkwellButtonWidget(
                    title: 'مشاهده جزئیات',
                    backgroundColor: serviceColor,
                    prefixIcon: const Icon(
                      Icons.visibility_outlined,
                      color: Colors.white,
                      size: AppSize.s20,
                    ),
                    onTap: () async {
                      await Future.sync(() => onSelected(request));
                      if (!context.mounted) return;

                      final requestId = request.id;
                      if (requestId == null) return;

                      await context.pushNamed(
                        RequestDetailPage.name,
                        extra: requestId,
                      );
                      if (!context.mounted) return;

                      await Future.sync(() => onRefreshAfterReturn?.call());
                    },
                  )
                : null,
            onOperation: () => _showOperationsBottomSheet(context),
            isOperationLoading: false,
          ),
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
          text: _requestAddress,
        ),
        const SizedBox(height: 8),
        RequestInfoRow(
          icon: Icons.check_circle,
          text: _vehicleDisplayText,
        ),
        const SizedBox(height: 8),
        RequestInfoRow(
          icon: Icons.settings,
          text: serviceTitle,
        ),
      ],
    );
  }

  String get _requestAddress {
    return [
      request.provinceName?.trim(),
      request.cityName?.trim(),
      request.aidAddress?.trim(),
    ]
        .whereType<String>()
        .where((value) => value.isNotEmpty)
        .join('، ');
  }

  String get _vehicleDisplayText {
    final carName = _rtlIsolate(request.carName?.trim());
    final licensePlate = _rtlIsolate(request.licensePlate?.trim());
    return '$carName - $licensePlate';
  }

  String _rtlIsolate(String? value) {
    final text = value?.isNotEmpty == true ? value! : '-';
    return '\u2067$text\u2069';
  }

  Future<void> _showOperationsBottomSheet(BuildContext context) async {
    final operations = RequestCardOperation.values
        .where((operation) => operation.isVisible(request, operationAccess))
        .toList(growable: false);

    if (operations.isEmpty) return;

    await BottomSheetMessage.showCustom(
      context: context,
      backgroundColor: Colors.white,
      topRadius: 28,
      maxHeight: .82,
      content: Builder(
        builder: (bottomSheetContext) => RequestOperationsBottomSheet(
          operations: operations,
          onOperationSelected: (operation) => _openOperation(
            pageContext: context,
            bottomSheetContext: bottomSheetContext,
            operation: operation,
          ),
        ),
      ),
      actionWidget: const SizedBox.shrink(),
    );
  }

  Future<void> _openOperation({
    required BuildContext pageContext,
    required BuildContext bottomSheetContext,
    required RequestCardOperation operation,
  }) async {
    Navigator.of(bottomSheetContext).pop();

    final routeName = operation.routeName;
    if (!operation.isImplemented || routeName == null) {
      // TODO: Replace this notice with the real operation flow when its page is implemented.
      SnakeBarWidget.showNotice(
        context: pageContext,
        message: 'این قابلیت به‌زودی در دسترس شما قرار می‌گیرد.',
      );
      return;
    }

    await Future.sync(() => onSelected(request));
    if (!pageContext.mounted) return;

    await pageContext.pushNamed(
      routeName,
      extra: operation.routeExtra(request.id),
    );
    if (!pageContext.mounted) return;

    await Future.sync(() => onRefreshAfterReturn?.call());
  }
}
