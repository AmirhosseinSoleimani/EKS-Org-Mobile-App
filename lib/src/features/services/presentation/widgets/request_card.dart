import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'operation_menu.dart';
import 'request_details_button.dart';
import 'request_header.dart';
import 'request_info_row.dart';


class RequestCard extends StatelessWidget {
  final BaseRequestEntity request;

  final String serviceTitle;
  final Color serviceColor;
  final IconData serviceIcon;
  final Function(BaseRequestEntity) onSelected;

  const RequestCard({
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
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          RequestHeader(
            request: request,
            serviceColor: serviceColor,
            serviceIcon: serviceIcon,
          ),
          const SizedBox(height: 16),
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

          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.tertiaryFixed,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OperationMenu(
                request: request,
                onSelected: onSelected,

              ),
              const SizedBox(width: 12),
              RequestDetailsButton(
                onPressed: () {
                  onSelected(request);
                  context.push(RequestDetailPage.path, extra: request.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
