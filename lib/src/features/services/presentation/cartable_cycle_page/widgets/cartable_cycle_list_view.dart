import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_wiget_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/empty_lsit.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

import '../../widgets/timeline_item_card.dart';

class CartableCycleListView extends StatelessWidget {
  final List<CartableCycleItemEntity> items;
  final Widget icon;

  const CartableCycleListView({
    super.key,
    required this.items,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = items.isEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodySmallText(text: "لیست چرخه کارتابل"),
          const SizedBox(height: 8),
          if (isEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.62,
              child: const Center(
                child: EmptyListWidget(),
              ),
            ),

          if (!isEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = items[index];

                return TimelineItemCard(
                  icon: icon,
                  expandedChildren:
                      (item.description != null && item.description!.isNotEmpty)
                          ? [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BodySmallText(text: "توضیحات"),
                                  const SizedBox(height: 8),
                                  BodySmallText(
                                    text: item.description!,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              )
                            ]
                          : const [],
                  children: [
                    KeyValueRow(
                      label: "شماره درخواست",
                      value: item.serviceRequestTrackCode?.toString() ?? "-",
                    ),
                    KeyValueRow(
                      label: "تاریخ ثبت پیغام",
                      value:
                          "${item.sendDateJalali ?? '-'} - ${item.sendTime ?? '-'}",
                    ),
                    KeyValueWidgetRow(
                      label: "وضعیت درخواست",
                      value: StatusLabel(
                        text: item.statusTitle ?? "-",
                        color: Colors.grey,
                        variant: StatusLabelVariant.outlined,
                      ),
                    ),
                    KeyValueWidgetRow(
                      label: "مرحله",
                      value: StatusLabel(
                        text: item.stepTitle ?? "-",
                        color: Colors.grey,
                        variant: StatusLabelVariant.outlined,
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
