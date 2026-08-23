import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/list/rescuer_card.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:flutter/material.dart';

class RescuerListViewer extends StatelessWidget {
  final List<RescuerEntity> items;
  final int? deletingRescuerId;
  final ValueChanged<RescuerEntity> onViewDetails;
  final ValueChanged<RescuerEntity> onOperations;

  const RescuerListViewer({
    super.key,
    required this.items,
    required this.deletingRescuerId,
    required this.onViewDetails,
    required this.onOperations,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const EmptyListWidget();
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        return RescuerCard(
          item: item,
          isDeleting: deletingRescuerId == item.id,
          onViewDetails: () => onViewDetails(item),
          onOperations: () => onOperations(item),
        );
      },
    );
  }
}
