import 'package:eks_sana_plus_org/src/features/services/domain/entities/chassis_request_history_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/domain/entities/evaluation_history_item_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/chassis_request_history_page/widgets/chassis_request_history_card.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/request_detail_page.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChassisRequestHistoryListViewer extends StatelessWidget {
  final List<ChassisRequestHistoryEntity> items;

  const ChassisRequestHistoryListViewer({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = items.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.62,
            child: const Center(
              child: EmptyListWidget(),
            ),
          ),
        if (!isEmpty)
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];

              return ChassisRequestHistoryCard(
                chassisRequest: item,
                serviceIcon: Icons.build,
                onSelected: (item) {
                  context.push(RequestDetailPage.path, extra: item.id);
                },
              );
            },
          ),
      ],
    );
  }

  bool hasInvoice(EvaluationHistoryItemEntity item) =>
      (item.invoiceId != null && item.invoiceId != -1);
}
