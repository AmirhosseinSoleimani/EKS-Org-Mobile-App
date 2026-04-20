import 'package:eks_sana_plus_org/src/features/services/domain/entities/cartable_cycle_entity.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/cartable_cycle_page/cubit/cartable_cycle_cubit.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/request_detail/widgets/key_value_wiget_row.dart';
import 'package:eks_sana_plus_org/src/features/services/presentation/widgets/status_label.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return  TimelineItemCard(
                icon: icon,
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
                      fillColor: false,
                    ),
                  ),
                  KeyValueWidgetRow(
                    label: "مرحله",
                    value: StatusLabel(
                      text: item.stepTitle ?? "-",
                      color: Colors.grey,
                      fillColor: false,
                    ),
                  ),
                  KeyValueRow(
                    label: "ثبت کننده",
                    value: item.senderFullName ?? "-",
                  ),
                  KeyValueRow(
                    label: "دریافت کننده",
                    value: item.receiverFullName ?? "-",
                  ),
                  KeyValueRow(
                    label: "توضیحات",
                    value: item.description ?? "-",
                  ),
                ],
              );

            },
          ),
          BlocBuilder<CartableCycleCubit, CartableCycleState>(
            builder: (context, state) {
              final cubit = context.read<CartableCycleCubit>();

              if (!cubit.hasMore) {
                return const SizedBox();
              }

              final loadingMore = state.whenOrNull(
                loadingMore: () => true,
              );

              if (loadingMore == true) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Center(
                child: TextButton(
                  onPressed: () => cubit.loadMore(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BodyMediumText(
                        text: 'مشاهده بیشتر',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Space.w4,
                      const Icon(Icons.expand_more),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
