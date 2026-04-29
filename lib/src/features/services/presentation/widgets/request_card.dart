import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../enums/request_card_operation.dart';
import 'request_details_button.dart';
import 'request_header.dart';
import 'request_info_row.dart';

enum RequestCardMode {
  normal,
  operations,
}

class RequestCard extends StatelessWidget {
  final BaseRequestEntity request;
  final String serviceTitle;
  final Color serviceColor;
  final IconData serviceIcon;
  final Function(BaseRequestEntity) onSelected;

  final ValueNotifier<RequestCardMode> _state =
      ValueNotifier(RequestCardMode.normal);

  RequestCard({
    super.key,
    required this.request,
    required this.serviceTitle,
    required this.serviceColor,
    required this.serviceIcon,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
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
            serviceColor: serviceColor,
            serviceIcon: serviceIcon,
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<RequestCardMode>(
            valueListenable: _state,
            builder: (context, mode, _) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: mode == RequestCardMode.normal
                    ? _buildInfoList(context)
                    : _buildOperationsGrid(context),
              );
            },
          ),
          const SizedBox(height: 12),
          Divider(
              height: 1, color: Theme.of(context).colorScheme.tertiaryFixed),
          const SizedBox(height: 12),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildInfoList(BuildContext context) {
    return Column(
      key: const ValueKey("info"),
      children: [
        RequestInfoRow(
            icon: Icons.person,
            text: "${request.firstName} ${request.lastName}"),
        const SizedBox(height: 8),
        RequestInfoRow(icon: Icons.location_on, text: request.aidAddress ?? ''),
        const SizedBox(height: 8),
        RequestInfoRow(
            icon: Icons.check_circle,
            text: "${request.carName} - ${request.licensePlate}"),
        const SizedBox(height: 8),
        RequestInfoRow(icon: Icons.settings, text: serviceTitle),
      ],
    );
  }

  Widget _buildOperationsGrid(BuildContext context) {
    final items =
        RequestCardOperation.values.where((item) => item.isVisible(request)).toList();

    return GridView.builder(
      key: const ValueKey("operations"),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () {
            onSelected(request);
            context.push(item.route, extra: request.id);
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: item.color,
                child: Icon(item.icon, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 4),
              BodySmallText(
                text: item.label,
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.ellipsis,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            _state.value = _state.value == RequestCardMode.normal
                ? RequestCardMode.operations
                : RequestCardMode.normal;
          },
          child: Row(
            children: [
              ValueListenableBuilder<RequestCardMode>(
                valueListenable: _state,
                builder: (context, mode, _) {
                  return Row(
                    children: [
                      Icon(
                          mode == RequestCardMode.normal
                              ? Icons.apps
                              : Icons.menu,
                          size: 22),
                      const SizedBox(width: 6),
                      BodyMediumText(
                        text: mode == RequestCardMode.normal
                            ? "عملیات"
                            : "اطلاعات درخواست",
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
