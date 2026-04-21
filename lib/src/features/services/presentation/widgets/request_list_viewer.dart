
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:flutter/material.dart';

import 'request_card.dart';

class RequestListViewer extends StatelessWidget {
  final List<BaseRequestEntity> items;
  final Function(BaseRequestEntity) onSelected;
  const RequestListViewer({super.key, required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];

        return RequestCard(
          request: item,
          serviceTitle: _resolveServiceTitle(item),
          serviceColor: item.serviceType?.serviceColor ?? ServiceType.reliefService.serviceColor,
          serviceIcon: Icons.build,
          onSelected: onSelected,
        );
      },
    );
  }

  String _resolveServiceTitle(BaseRequestEntity entity) {
    if (entity is ReliefRequestEntity) {
      return entity.defectTitle ?? '';
    }
    if (entity is HomeServiceRequestEntity) {
      return entity.emdadServiceCategoryTitle ?? '';
    }
    return "";
  }
}
