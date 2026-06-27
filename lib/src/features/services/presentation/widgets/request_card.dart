import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../enums/request_card_operation.dart';
import 'request_header.dart';
import 'request_info_row.dart';

class RequestCard extends StatelessWidget {
  final BaseRequestEntity request;
  final String serviceTitle;
  final Color serviceColor;
  final IconData serviceIcon;
  final Function(BaseRequestEntity) onSelected;
  final ValueNotifier<num?> selectedOperationRequestId;

  const RequestCard({
    super.key,
    required this.request,
    required this.serviceTitle,
    required this.serviceColor,
    required this.serviceIcon,
    required this.onSelected,
    required this.selectedOperationRequestId,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<num?>(
      valueListenable: selectedOperationRequestId,
      builder: (context, selectedRequestId, _) {
        final isOperationsMode = selectedRequestId == request.id;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(80),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RequestHeader(
                request: request,
              ),
              const SizedBox(height: 16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: isOperationsMode
                    ? _buildOperationsGrid(context)
                    : _buildInfoList(context),
              ),
              const SizedBox(height: 12),
              Divider(
                height: 1,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ),
              const SizedBox(height: 12),
              _buildBottomBar(
                context: context,
                isOperationsMode: isOperationsMode,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoList(BuildContext context) {
    return Column(
      key: ValueKey('info_${request.id}'),
      children: [
        RequestInfoRow(
          icon: Icons.person,
          text: "${request.firstName} ${request.lastName}",
        ),
        const SizedBox(height: 8),
        RequestInfoRow(
          icon: Icons.location_on,
          text: request.aidAddress ?? '',
        ),
        const SizedBox(height: 8),
        RequestInfoRow(
          icon: Icons.check_circle,
          text: "${request.carName} - ${request.licensePlate}",
        ),
        const SizedBox(height: 8),
        RequestInfoRow(
          icon: Icons.settings,
          text: serviceTitle,
        ),
      ],
    );
  }


  Widget _buildOperationsGrid(BuildContext context) {
    final items = RequestCardOperation.values
        .where((item) => item.isVisible(request))
        .toList();
    return GridView.builder(
      key: ValueKey('operations_${request.id}'),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 90,
        mainAxisSpacing: 16,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.maxWidth.clamp(40.0, 72.0);

            return Tooltip(
              message: item.label,
              child: InkWell(
                onTap: () {
                  onSelected(request);
                  context.push(item.route, extra: request.id);
                },
                child: Center(
                  child: CircleAvatar(
                    radius: size / 2.2,
                    backgroundColor: item.color,
                    child: Icon(
                      item.icon,
                      color: Colors.white,
                      size: size * 0.40,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomBar({
    required BuildContext context,
    required bool isOperationsMode,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            if (isOperationsMode) {
              selectedOperationRequestId.value = null;
            } else {
              selectedOperationRequestId.value = request.id;
            }
          },
          child: Row(
            children: [
              Icon(
                isOperationsMode ? Icons.menu : Icons.apps,
                size: 22,
              ),
              const SizedBox(width: 6),
              BodyMediumText(
                text: isOperationsMode ? "اطلاعات درخواست" : "عملیات",
              ),
            ],
          ),
        ),
      ],
    );
  }
}