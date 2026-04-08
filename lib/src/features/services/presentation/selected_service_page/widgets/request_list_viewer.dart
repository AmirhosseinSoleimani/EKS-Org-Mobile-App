
import 'package:eks_sana_plus_org/src/features/services/domain/entities/abstract/base_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/home_service_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/relief_request_entity.dart';
import 'package:flutter/material.dart';

import 'request_card.dart';

class RequestListViewer extends StatelessWidget {
  final List<BaseRequestEntity> items;

  const RequestListViewer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];

        return RequestCard(
          request: item,
          serviceTitle: _resolveServiceTitle(item),
          serviceColor: Colors.blue,
          serviceIcon: Icons.build,
        );
      },
    );
  }

  String _resolveServiceTitle(BaseRequestEntity entity) {
    if (entity is ReliefRequestEntity) {
      return entity.defectTitle;
    }
    if (entity is HomeServiceRequestEntity) {
      return entity.emdadServiceCategoryTitle;
    }
    return "";
  }
}
